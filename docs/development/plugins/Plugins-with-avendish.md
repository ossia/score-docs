---
layout: default

title: "Plug-ins with Avendish"
description: "Writing plug-ins with the Avendish API"

parent: "Plug-ins"

permalink: /development/plugins/plugins-with-avendish.html
---

# Avendish documentation

Before focusing on writing score plug-ins, read the Avendish documentation to get familiar with what it allows: https://celtera.github.io/avendish.

In short: this plug-in API leverages C++ reflection to define media objects. 
The inputs and outputs of objects are simply struct members: here is for instance the entire definition of a simple Avendish audio processing object:

```c++
#pragma once
#include <cmath>
struct Distortion
{
  static consteval auto name() { return "Distortion"; }
  static consteval auto c_name() { return "disto"; }
  static consteval auto uuid() { return "dd4dd880-d525-44fb-9773-325c87b235c0"; }

  struct {
    struct {
      static consteval auto name() { return "Preamp"; }
      static consteval auto control() {
        struct {
          const float min = 0.001;
          const float max = 1000.;
          const float init = 1.;
        } c; return c;
      }

      float value{0.5};
    } preamp;

    struct {
      static consteval auto name() { return "Volume"; }
      float value{1.0};
    } volume;
  } inputs;

  void operator()(double** in, double** out, int frames)
  {
    const double preamp = inputs.preamp.value;
    const double volume = inputs.volume.value;

    for (int c = 0; c < channels; c++)
      for (int i = 0; i < frames; i++)
        out[c][i] = volume * std::tanh(in[c][i] * preamp);
  }
};
```

Note in particular that Avendish objects implementation do not by themselves require *any* library to be included, not even the standard C++ one.
This allows them to be portable to as many platforms as C++ compilers run on, including bare-metal microcontrollers.

Note that in order to reduce verbosity, an helper library is provided, and most examples use it: it is however in no way mandatory.

# Plug-in types
Multiple kind of plug-ins can be written with Avendish:

- Audio processing plug-ins.
- Message processing plug-ins.
- CPU-based image processing plug-ins.
- GPU-based plug-ins (compute pipelines or vertex/fragment draw pipelines).

The reflection-based approach allows various "shapes" of plug-ins to work: for instance, the above sample plug-in passes the audio channels as arguments to the processing function.
Another way to write the same plug-in, which would use ports for everything, would be: 

```c++
#pragma once
#include <halp/audio.hpp>
#include <halp/controls.hpp>
#include <halp/meta.hpp>

#include <cmath>

class Distortion
{
public:
  halp_meta(name, "Distortion (helpers)")
  halp_meta(c_name, "disto")
  halp_meta(uuid, "82bdb9b5-9cf8-440e-8675-c0caf4fc59b9")

  struct
  {
    halp::dynamic_audio_bus<"Input", double> audio;
    halp::hslider_f32<"Preamp", halp::range{.min = 0.001, .max = 1000., .init = 0.5}> preamp;
    halp::val_port<"Volume", float> volume;
  } inputs;

  struct
  {
    halp::dynamic_audio_bus<"Output", double> audio;
  } outputs;

  using tick = halp::tick;
  void operator()(halp::tick t)
  {
    const double volume = inputs.volume;
    const double preamp = inputs.preamp;

    for(int c = 0; c < inputs.audio.channels; c++)
    {
      auto* in = inputs.audio[c];
      auto* out = outputs.audio[c];

      for (int i = 0; i < t.frames; i++)
        outputs.audio[c][i] = volume * std::tanh(inputs.audio[c][i] * preamp);
    }
  }
};
```

# Creating a dynamic score plug-in with the template

The recommended way to create a plug-in is by using the [template provided on Github](https://github.com/ossia-templates/score-avnd-simple-template/).
It contains everything needed to automatically create a plug-in. Whenever you push a new commit, Github will automatically compile the plug-in for Mac, Windows and Linux.

1. Create a repository from the template by clicking on the green "Use this template" button.

![Github template creation]({{ site.img }}/development/plugins/avendish/template.png "Github template")

For instance, let's say your personal repository will be: https://github.com/yourself/foobinator and your plug-in name is Foobinator.

2. Clone your new repository:

```bash
$ git clone git@github.com:yourself/foobinator
```

3. If your shell is zsh, run `./init.zsh Foobinator`, otherwise `./init.sh Foobinator`

This will replace the generic names in the repository by your custom name, Foobinator and auto-generate unique identifiers.

4. Set-up your plug-in's name and description inside the `addon.json` file.

5. Set-up git again -- the script removes the existing local git repo to make sure you can start from a clean state, without the template repo git history.

```bash
$ git remote add origin git@github.com:yourself/foobinator
$ git add .
$ git commit -m 'First commit'
$ git push --set-upstream origin main --force
```

6. After some minutes, you can check the "SDK" action of the plug-in on Github:

https://github.com/yourself/foobinator/actions/workflows/builds-sdk.yaml

If everything is ok, it should have generated a "plugin" archive which will contain the MacOS, Windows and Linux builds.
This can be extracted to `Documents/ossia/score/package/foobinator`: the object should become visible the next time you launch score.

# Building locally from the command line

For building a plug-in locally, you need: 

- If you are on a Mac, XCode must be installed. On all platforms you must also install CMake and Ninja.

- The simplest way is to follow the steps that are done on the CI as they are regularly automatically checked, unlike the instructions on this page :-)

https://github.com/ossia-templates/score-avnd-simple-template/blob/main/.github/workflows/builds-sdk.yaml

In short: 

1. Create an empty "development" folder and clone or move your repository in it

```bash
$ mkdir dev
$ cd dev
$ git clone git@github.com:yourself/foobinator
```

2. Download and run this script: `https://github.com/ossia/score/raw/master/tools/fetch-sdk.sh` which will download required compilers and libraries.

3. From score's package manager, download the SDK which will contain the header files that match this version of score.

![Score SDK]({{ site.img }}/development/plugins/avendish/settings.png "Score SDK download")

It will be installed in `~/Documents/ossia/score/sdk/<VERSION>`

**NOTE** The 3.1.8 version does not support this yet, you need to download and extract the SDK of the `continuous` build (and `continuous` version of score) manually. Starting from 3.1.9 this will be fixed, but until then use this: https://github.com/ossia/score/releases/tag/continuous

For instance on Linux:

```bash
$ mkdir -p ~/Documents/ossia/score/sdk
$ cd ~/Documents/ossia/score/sdk
$ wget https://github.com/ossia/score/releases/download/continuous/linux-sdk.zip
$ 7z x linux-sdk.zip -ocontinuous
```

4. Run CMake (this step will only be needed the first time)

```
$ cd dev
$ export SCORE_SDK=/path/to/Documents/ossia/score/sdk/3.1.x
# Or if you downloaded the "continuous" SDK as mentioned above: 
$ export SCORE_SDK=/path/to/Documents/ossia/score/sdk/continuous

# If on windows:
$ export OSSIA_SDK=c:/ossia-sdk
$ export PATH=$OSSIA_SDK/llvm/bin:$PATH
$ export CC=clang
$ export CXX=clang++

# If on mac:
$ export OSSIA_SDK=/opt/ossia-sdk-x86_64

# If on Linux:
$ export OSSIA_SDK=/opt/ossia-sdk
$ export PATH=$OSSIA_SDK/llvm/bin:$PATH
$ export CC=clang
$ export CXX=clang++

$ cmake -S foobinator \
        -B foobinator-build-release \
        -GNinja \
        -DCMAKE_BUILD_TYPE=RelWithDebInfo \
        -DCMAKE_MODULE_PATH="$SCORE_SDK/usr/lib/cmake/score" \
        -DSCORE_SDK="$SCORE_SDK/usr" \
        -DOSSIA_SDK="$OSSIA_SDK" \
        -DCMAKE_INSTALL_PREFIX=/path/to/Documents/ossia/score/packages/my_plugin
```

5. Run a build

```
$ cmake --build foobinator-build-release
$ cmake --install foobinator-build-release
```

This should copy the plug-in in the `ossia/score/packages/<your plugin>` folder. If everything is correct, the next time you launch score you should see your plug-in show up in the Process library :-)

Another way for fast iteration is to create a symbolic lijnk from the `foobinator-build-release/plugins` folder to `ossia/score/packages/<your plugin>`. This way, every time you run `ninja`, the binary will be updated.

Note that on Windows, you must exit score if you rebuild the DLL as the operating system does not support replacing of currently loaded DLL files.

# Building locally from Qt Creator

Once you have a local build up-and-running, you can configure an IDE to make the edit/compile/run loop easier.
We will use Qt Creator.

Here is a video explanation: 

<video controls>
    <source src="{{ site.img }}/development/plugins/avendish/addon-build.webm" type="video/mp4">
</video>
