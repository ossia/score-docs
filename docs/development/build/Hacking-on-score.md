---
layout: default

title: "Hacking"
description: "Creating a development build of score"

parent: "Building from source"
grand_parent: Development

permalink: /development/build/hacking.html
---

# Very very quickstart

The [developer.sh](https://github.com/ossia/score/blob/master/tools/developer.sh) will try to download and install the required dependencies, and compile score in a way suitable for development:

```bash
$ git clone --recursive -j16 https://github.com/ossia/score
$ cd score
$ ./tools/developer.sh
```

On Windows it is recommended to run this script from an [MSYS2](https://www.msys2.org/) Clang64 shell.

# Quickstart

This page presents how to start developing things on ossia score.

We recommend heavily to use QtCreator as IDE to do so, or at least an IDE with native support for CMake.

## Cloning the project

Make sure to make a *recursive* clone of the project, or you will encounter build issues:

```bash
$ git clone --recursive -j16 https://github.com/ossia/score
```

## Add-ons

The default repository of score does not come with all add-ons of the official release included, as some of them
are being developed in other git repositories.

To add an add-on to the build, clone its repository into the `score/src/addons` folder.
For instance, to add NDI support:

``` 
$ cd score/src/addons
$ git clone --recursive https://github.com/ossia/score-addon-ndi
```

And rerun CMake in the build folder (`cd build-folder; cmake .`) before rebuilding for the build system to pick-up the new addon.

To get all the add-ons of the official distribution, you can run the `./ci/common.deps.sh` script, but be aware that 
some add-ons such as the ONNX one require additional steps when debugging on Windows or Mac ; it is recommended to start with a functioning build of score without the addons if this is the first time you are building it.

To add a new feature to ossia, it is recommended to start by making a new addon from one of the various [templates](http://github.com/ossia-templates).

## Building ossia score with system packages or a package manager

### Building ossia score on Windows

On Windows we recommend using [MSYS2](https://www.msys2.org/) with a Clang64 shell.

```
$ pacman -S pactoys
$ pacboy -S --needed \
      cmake:p \
      ninja:p \
      toolchain:p \
      cppwinrt:p \
      qt6-base:p \
      qt6-declarative:p \
      qt6-websockets:p \
      qt6-serialport:p \
      qt6-shadertools:p \
      qt6-scxml:p \
      qt6-tools:p \
      boost:p \
      portaudio:p \
      fftw:p \
      ffmpeg:p \
      SDL2:p \
      git

$ git clone --recursive -j16 https://github.com/ossia/score

$ cmake -Wno-dev \
  -S score \
  -B build-folder \
  -GNinja \
  -DCMAKE_BUILD_TYPE=Debug \
  -DSCORE_PCH=1 \
  -DCMAKE_COLOR_DIAGNOSTICS=1 \
  -DCMAKE_OPTIMIZE_DEPENDENCIES=1 \
  -DCMAKE_LINK_DEPENDS_NO_SHARED=1 \
  -DSCORE_DYNAMIC_PLUGINS=0

$ cmake --build build-folder
``` 

### Building ossia score on macOS

On Windows we recommend using Homebrew.

```
$ brew install ninja qt boost cmake ffmpeg fftw portaudio jack sdl lv2 lilv suil freetype
$ brew uninstall --ignore-dependencies qt@5
$ git clone --recursive -j16 https://github.com/ossia/score
  
# Generate CMAKE_PREFIX_PATH="$(brew --prefix qt@6);$(brew --prefix ffmpeg);..."
# This is not necessary but avoids issues when brew upgrades packages as 
# CMake will by default point to a specific version, e.g. /opt/homebrew/Cellar/ffmpeg/7.1.1/blah
# Which breaks whenever brew updates to e.g. ffmpeg 7.1.2
$  CMAKE_PREFIX_PATH=
$  for pkg in "${BREW_PACKAGES[@]}"; do
$   CMAKE_PREFIX_PATH+="$(brew --prefix ${pkg} -q);"
$  done
$ CMAKE_PREFIX_PATH=${CMAKE_PREFIX_PATH::${#CMAKE_PREFIX_PATH}-1}

$ xcrun cmake -Wno-dev \
  -S score \
  -B build-folder \
  -GNinja \
  -DCMAKE_PREFIX_PATH="$CMAKE_PREFIX_PATH" \
  -DCMAKE_BUILD_TYPE=Debug \
  -DSCORE_PCH=1 \
  -DCMAKE_COLOR_DIAGNOSTICS=1 \
  -DCMAKE_OPTIMIZE_DEPENDENCIES=1 \
  -DCMAKE_LINK_DEPENDS_NO_SHARED=1

$ xcrun cmake --build build-folder
``` 

### Building ossia score on Linux

It is harder to give a single set of build instructions for Linux, 
as every distribution differs.

Check out the build scripts for your distros [here](https://github.com/ossia/score/tree/master/ci).

For instance, for Ubuntu 22.04:

- [jammy.deps.sh](https://github.com/ossia/score/blob/master/ci/jammy.deps.sh) will install the required dependencies.
- [jammy.build.sh](https://github.com/ossia/score/blob/master/ci/jammy.build.sh) will build.

Likewise, for Ubuntu 24.04:

- [noble.deps.sh](https://github.com/ossia/score/blob/master/ci/jammy.deps.sh) will install the required dependencies.
- [noble.build.sh](https://github.com/ossia/score/blob/master/ci/jammy.build.sh) will build.

> You should change the CMake invocation a bit, as the one on the CI scripts is optimized for a fast complete rebuild on the CI server, but changing a single file and rebuilding will be excruciatingly slow:

Instead of 

```bash
$ cmake ..                       \
  -GNinja                        \
  -DCMAKE_BUILD_TYPE=Release     \
  -DCMAKE_INSTALL_PREFIX=install \
  -DSCORE_DYNAMIC_PLUGINS=1      \
  -DCMAKE_UNITY_BUILD=1          \
  -DCMAKE_COLOR_DIAGNOSTICS=1
```

You really want (adapted with the clang version you have):

```bash
$ cmake -Wno-dev                                \
    -S ~/path/to/score -B build-folder          \
    -GNinja                                     \
    -DCMAKE_C_COMPILER="clang"                  \
    -DCMAKE_CXX_COMPILER="clang++"              \
    -DCMAKE_SHARED_LINKER_FLAGS="-fuse-ld=lld"  \
    -DCMAKE_EXE_LINKER_FLAGS="-fuse-ld=lld"     \
    -DCMAKE_BUILD_TYPE=Debug                    \
    -DSCORE_PCH=1                               \
    -DSCORE_DYNAMIC_PLUGINS=1                   \
    -DCMAKE_COLOR_DIAGNOSTICS=1

$ cmake --build build-folder
```

which will make individual changes much faster (the difference can be between waiting a couple minutes instead of a couple seconds after each rebuild).

> If you have an up-to-date distribution, you can also install the mold linker 
> which is even faster than lld, and replace `-fuse-ld=lld` with `-fuse-ld=mold` in the lines above. 

## Rebuild the project after an initial build

Once you have a build folder, only the `cmake --build .` command is necessary.

# Building with the ossia SDK

## Downloading the SDK

This gives you the exact same build configuration than the official releases.
Required dependencies and libraries, except CMake and Ninja, can be downloaded from a [pre-built SDK](https://github.com/ossia/sdk/releases). 
This will give you the exact libraries used for the official ossia score releases.

This [script](https://github.com/ossia/score/blob/master/tools/fetch-sdk.sh) will download the latest version of the SDK automatically. Otherwise:

### On Windows

  * [Install git with git bash](https://git-scm.com/downloads).
  * [Download the SDK](https://github.com/ossia/sdk/releases/download/sdk32/sdk-mingw.7z) and extract it in `c:\ossia-sdk`. 
  * You must also install [CMake](https://cmake.org/). 
  * [Ninja](https://github.com/ninja-build/ninja/releases) is extremely recommended for build speed - download it and extract `ninja.exe` in `c:\ossia-sdk\llvm\bin\`.


### On Linux

[Download the SDK](https://github.com/ossia/sdk/releases/download/sdk32/sdk-linux.tar.xz) and extract it in `/opt/ossia-sdk`. You must also install CMake 3.26 at least, either through your distribution or the official CMake website.

### On macOS

Building on macOS is only supported from an ARM64 (M1 / M2 / ...) host, e.g. a Mac from 2020 onwards.

1. If using Homebrew, remove most packages as CMake picks up Homebrew dependencies which can be incompatible with the SDK libraries, and cause run-time crashes for instance because the header files of Homebrew's versions of ffmpeg or Qt were found yet linking occurs with the ossia SDK libraries which may not compatible. If in doubt, remove homebrew entirely and only install cmake, wget, gnu-sed, gnu-tar and ninja. In particular, ffmpeg, fftw, boost, gstreamer, qt, sdl, portaudio must absolutely not be installed through Homebrew.

2. If you cannot remove them, then use the Homebrew build instructions above.

3. [Download the SDK](https://github.com/ossia/sdk/releases/download/sdk32/sdk-macOS-aarch64.tar.gz) and extract it in `/opt/ossia-sdk-aarch64`. You must also install XCode at the latest version (XCode 16) and CMake+Ninja (for instance through Homebrew).

## Building score with the SDK

### Build the project on Windows with the SDK
With git bash: 

```bash
$ export PATH=/c/ossia-sdk/llvm/bin:$PATH
$ cmake -S c:/path/to/score -B build-folder          \
  -GNinja                                            \
  -DCMAKE_C_COMPILER=c:/ossia-sdk/llvm/bin/clang     \
  -DCMAKE_CXX_COMPILER=c:/ossia-sdk/llvm/bin/clang++ \
  -DOSSIA_SDK=c:/ossia-sdk                           \
  -DCMAKE_BUILD_TYPE=Debug                           \
  -DSCORE_PCH=1                                      \
  -DCMAKE_COLOR_DIAGNOSTICS=1

$ cmake --build build-folder
```

Or with cmd.exe, the native command shell:

```batch
> set PATH=c:\ossia-sdk\llvm\bin;%PATH%
> cmake -S c:\path\to\score -B build-folder          ^
  -GNinja                                            ^
  -DCMAKE_C_COMPILER=c:\ossia-sdk\llvm\bin\clang     ^
  -DCMAKE_CXX_COMPILER=c:\ossia-sdk\llvm\bin\clang++ ^
  -DOSSIA_SDK=c:\ossia-sdk                           ^
  -DCMAKE_BUILD_TYPE=Debug                           ^
  -DSCORE_PCH=1                                      ^
  -DCMAKE_COLOR_DIAGNOSTICS=1

> cmake --build build-folder
```

> Note: on Windows, the system antivirus slows build times a *lot*. Be sure to exclude recursively: 
> 
> - The ossia-sdk folder
> - The score source folder
> - The score build folder
> 
> from antivirus scans if things are slow as it seems that every file access is checked, and compilers do those a lot.


### Build the project on macOS with the SDK

> note : replace aarch64 by x86_64 if you are on an older mac

```bash
$ xcrun cmake -S ~/path/to/score     \
  -B build-foldere                   \
  -GNinja                            \
  -DOSSIA_SDK=/opt/ossia-sdk-aarch64 \
  -DCMAKE_BUILD_TYPE=Debug           \
  -DSCORE_PCH=1                      \
  -DSCORE_DYNAMIC_PLUGINS=1          \
  -DCMAKE_COLOR_DIAGNOSTICS=1

$ xcrun cmake --build build-folder
```

### Build the project on Linux with the SDK

```bash
$ cmake -S ~/path/to/score   \
  -B build-folder            \
  -GNinja                    \
  -DOSSIA_SDK=/opt/ossia-sdk \
  -DCMAKE_BUILD_TYPE=Debug   \
  -DSCORE_PCH=1              \
  -DSCORE_DYNAMIC_PLUGINS=1  \
  -DCMAKE_COLOR_DIAGNOSTICS=1

$ cmake --build build-folder
```
# Installing dependencies manually

Ensure that you have the latest version of Qt, boost, and your C++ compiler installed.

*Note* : to ensure a very fast build time, it is recommended to use clang as compiler and ninja for building, on every platform.
Additionally, on Linux and Windows `lld` can be used as a linker. It is quite faster than `GNU ld` and `gold`. On recent Linux, `mold` can also be 
used, which is even faster.

At the time of this writing, this means :

| Software | Version                         |
|----------|---------------------------------|
| Compiler | clang 19 or gcc 14 or msvc 2022 |
| Qt       | Qt 6.8+                         |
| Boost    | 1.87                            |
| CMake    | 3.31                            |

However, to get a complete build with support for more features, more is needed :

| Software      | Version |
|---------------|---------|
| FFMPEG        | 7.x     | # Required for sound playback
| LLVM          | 19.x    | # Required for Faust support. Must be same version than clang used to build.
| OpenSSL       | 3.x     | # Required to connect to wss / https
| Faust         | Latest  | # Required to load Faust plug-ins
| suil, lilv    | Latest  | # Required to load LV2 plug-ins
| PortAudio     | Latest  | # Required to playback sound using Coreaudio, ASIO, ALSA, Pulseaudio...
| PipeWire      | Latest  | # Required to playback sound using PipeWire...
| JACK2         | Latest  | # Required to playback sound using JACK
| SDL2          | Latest  | # Required to have gamepad support
| libbluetooth  | Latest  | # Required to have BLE support on Linux
| Avahi         | Latest  | # Required to have Bonjour / Zeroconf support on Linux

Or you can install them with your package manager of choice - see the packages for each platform at the end of this document.

# Useful documentation

- [(Using) CMake](https://cliutils.gitlab.io/modern-cmake/chapters/intro/running.html)
- [(Writing) CMake](https://cmake.org/cmake/help/latest/manual/cmake-buildsystem.7.html)
- [Qt](https://doc.qt.io/qt-5/gettingstarted.html)
- [Qt Creator](https://doc.qt.io/qtcreator/index.html)

# Building on the command line

First get a recursive clone of the repository :

    $ git clone --recursive -j16 https://github.com/ossia/score

The preferred way to build when hacking on the software is with [cninja](https://github.com/jcelerier/cninja):

    cninja ~/path/to/score developer

Alternatively, one can build with CMake.
Pass the following options to `cmake` to ensure maximal build speed: (note that the instructions later on this page may not be entirely up-to-date)

    -GNinja                                     # Makes the build much faster
    -DCMAKE_C_COMPILER=/path/to/clang           # Makes the build faster (only needed on Linux)
    -DCMAKE_CXX_COMPILER=/path/to/clang++       # Makes the build faster (only needed on Linux)
    -DCMAKE_SHARED_LINKER_FLAGS="-fuse-ld=lld"  # Makes the linking faster (only needed on Linux)
    -DCMAKE_EXE_LINKER_FLAGS="-fuse-ld=lld"     # Makes the linking faster (only needed on Linux)
    -DCMAKE_BUILD_TYPE=Debug                    # For having debug symbols
    -DSCORE_PCH=1                               # Makes the build much much faster
    -DSCORE_DYNAMIC_PLUGINS=1                   # Makes the linking faster (only on Mac / Linux ; on Windows it does not work)
    -DCMAKE_COLOR_DIAGNOSTICS=1                 # Avoids a rebuild if an IDE injects this when opening the project for the first time.

> Important: Run the `cmake` command in a separate build folder, especially not in the source directory of score !

For instance, for generating the build files on Ubuntu, Debian or Linux Mint, that gives :

    cmake -S /path/to/score -B /path/to/build    \
      -GNinja                                    \
      -DCMAKE_C_COMPILER=/usr/bin/clang          \
      -DCMAKE_CXX_COMPILER=/usr/bin/clang++      \
      -DCMAKE_SHARED_LINKER_FLAGS="-fuse-ld=lld" \
      -DCMAKE_EXE_LINKER_FLAGS="-fuse-ld=lld"    \
      -DCMAKE_BUILD_TYPE=Debug                   \
      -DSCORE_PCH=1                              \
      -DSCORE_DYNAMIC_PLUGINS=1

If you are using the SDK mentioned above, add: 

    -DOSSIA_SDK=/path/to/sdk

If you are not using your distribution's Qt version because it's too old, pass the path to a recent version with, for instance,

    -DCMAKE_PREFIX_PATH=/home/yourname/Qt/6.8.2/gcc_64

The path must contain a `lib` folder in which CMake is going to look for Qt.

Once CMake has ran successfully, do :

    cmake --build .

To be safe, you should have at least 8 gigabytes free on your hard drive before starting a build.

# Building with Qt Creator

Refer to this video : https://www.youtube.com/watch?v=LSifHFbuky0

# Windows with Visual Studio

Note that building with Visual Studio, while checked in the CI, is not officially supported ; we recommend using MSYS2 with clang64 instead.

First install:
* The latest version of Visual Studio 2022
* [git](https://gitforwindows.org/)
* [CMake](https://cmake.org/)
* [Python](https://www.python.org)
* Take a few seconds to contemplate the easiness of building on the above Unix platforms
* Extract https://github.com/ossia/sdk/releases/download/sdk14/win-audio-sdk-msvc.zip in your `c:\` so that the folders once extracted look like `c:\score-sdk-msvc\portaudio` and `c:\score-sdk-msvc\ffmpeg`


Run a `x64 Native Tools Command Prompt for VS 2022`:
![Screenshot](https://imgur.com/chDaR6J)

In the command prompt, install Qt:

(Assuming your development environment is in a `c:\dev` folder)
```
cd c:\dev

# Install dependencies
## Qt
pip install aqtinstall
aqt install-qt --outputdir c:\Qt 6.8.2 windows desktop 6.8.2 win64_msvc2022_64

# Build
cmake ../score -DCMAKE_PREFIX_PATH="c:/Qt/6.8.2/msvc2022_64" -DOSSIA_SDK="c:/score-sdk-msvc" -DSCORE_PCH=1 -DCMAKE_INSTALL_PREFIX=installed -DCMAKE_BUILD_TYPE=Debug
cmake --build . --config Debug
cmake --build . --config Debug --target install

# Run
cd installed
score.exe
```
