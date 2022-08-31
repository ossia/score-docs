---
layout: default

title: "Hacking"
description: "Creating a development build of score"

parent: "Building from source"
grand_parent: Development

permalink: /development/build/hacking.html
---

# Very very quickstart

The [developer.sh](https://github.com/ossia/score/blob/master/tools/developer.sh) will try to download and install the required dependencies, and compile score in a way suitable for development.

# Quickstart

This page presents how to start developing things on ossia score.

We recommend heavily to use QtCreator as IDE to do so, or at least an IDE with native support for CMake.

# The SDK

Required dependencies and libraries, except CMake and Ninja, can be downloaded from a [pre-built SDK](https://github.com/ossia/sdk/releases). 
This will give you exactly the library used for the official ossia score releases. This is recommended on Windows and Linux distributions older than Ubuntu 22.04.

This [script](https://github.com/ossia/score/blob/master/tools/fetch-sdk.sh) will download the latest version of the SDK automatically. Otherwise:

- On Windows: 
  * [Install git with git bash](https://git-scm.com/downloads).
  * [Download the SDK](https://github.com/ossia/sdk/releases/download/sdk26/sdk-mingw.7z) and extract it in `c:\ossia-sdk`. 
  * You must also install [CMake](https://cmake.org/). 
  * [Ninja](https://github.com/ninja-build/ninja/releases) is extremely recommended for build speed - download it and extract `ninja.exe` in `c:\ossia-sdk\llvm\bin\`.


- On Linux: [Download the SDK](https://github.com/ossia/sdk/releases/download/sdk26/sdk-linux.tar.xz) and extract it in `/opt/ossia-sdk`. You must also install CMake (from your distribution's repositories).
  
- On macOS: [Download the SDK](https://github.com/ossia/sdk/releases/download/sdk26/sdk-macOS.tar.xz) and extract it in `/opt/ossia-sdk-x86_64`. You must also install XCode (sorry) and CMake+Ninja (for instance through Homebrew).

# Quick development build

## Cloning the project

Make sure to make a *recursive* clone of the project, or you will encounter build issues:

```bash
$ git clone --recursive -j16 https://github.com/ossia/score
```

## Build the project on Windows
With git bash: 

```bash
$ export PATH=/c/ossia-sdk/llvm/bin:$PATH
$ cmake c:/path/to/score                             \
  -GNinja                                            \
  -DCMAKE_C_COMPILER=c:/ossia-sdk/llvm/bin/clang     \
  -DCMAKE_CXX_COMPILER=c:/ossia-sdk/llvm/bin/clang++ \
  -DOSSIA_SDK=c:/ossia-sdk                           \
  -DCMAKE_BUILD_TYPE=Debug                           \
  -DSCORE_PCH=1

$ cmake --build .
```

Or with cmd.exe, the native command shell:

```batch
> set PATH=c:\ossia-sdk\llvm\bin;%PATH%
> cmake c:\path\to\score                             ^
  -GNinja                                            ^
  -DCMAKE_C_COMPILER=c:\ossia-sdk\llvm\bin\clang     ^
  -DCMAKE_CXX_COMPILER=c:\ossia-sdk\llvm\bin\clang++ ^
  -DOSSIA_SDK=c:\ossia-sdk                           ^
  -DCMAKE_BUILD_TYPE=Debug                           ^
  -DSCORE_PCH=1

> cmake --build .
```

> Note: on Windows, the system antivirus slows build times a *lot*. Be sure to exclude recursively: 
> 
> - The ossia-sdk folder
> - The score source folder
> - The score build folder
> 
> from antivirus scans if things are slow as it seems that every file access is checked, and compilers do those a lot.

## Build the project on Linux

It is harder to give a single set of build instructions for Linux, 
as every distribution differs.

Check out the build scripts for your distros [here](https://github.com/ossia/score/tree/master/ci).

For instance, for Ubuntu 20.04:

- [focal.deps.sh](https://github.com/ossia/score/blob/master/ci/focal.deps.sh) will install the required dependencies.
- [focal.build.sh](https://github.com/ossia/score/blob/master/ci/focal.build.sh) will build. 

> You should change the CMake invocation a bit, as the one on the CI scripts is optimized for a fast complete rebuild on the CI server, but changing a single file and rebuilding will be excruciatingly slow:

Instead of 

```bash
$ cmake ..                       \
  -GNinja                        \
  -DCMAKE_BUILD_TYPE=Release     \
  -DCMAKE_INSTALL_PREFIX=install \
  -DSCORE_DYNAMIC_PLUGINS=1      \
  -DCMAKE_UNITY_BUILD=1
```

You really want (adapted with the clang version you have):

```bash
$ cmake ~/path/to/score                         \
    -GNinja                                     \
    -DCMAKE_C_COMPILER="clang-14"               \
    -DCMAKE_CXX_COMPILER="clang++-14"           \
    -DCMAKE_SHARED_LINKER_FLAGS="-fuse-ld=lld"  \
    -DCMAKE_EXE_LINKER_FLAGS="-fuse-ld=lld"     \
    -DCMAKE_BUILD_TYPE=Debug                    \
    -DSCORE_PCH=1                               \
    -DSCORE_DYNAMIC_PLUGINS=1

$ cmake --build .
```

which will make individual changes much faster (the difference can be between waiting a couple minutes instead of a couple seconds after each rebuild).

> If you have an up-to-date distribution, you can also install the mold linker 
> which is even faster than lld, and replace `-fuse-ld=lld` with `-fuse-ld=mold` in the lines above. 

## Build the project on macOS

```bash
$ xcrun cmake ~/path/to/score       \
  -GNinja                           \
  -DOSSIA_SDK=/opt/ossia-sdk-x86_64 \
  -DCMAKE_BUILD_TYPE=Debug          \
  -DSCORE_PCH=1                     \
  -DSCORE_DYNAMIC_PLUGINS=1

$ xcrun cmake --build .
```

## Rebuild the project after an initial build

Once you have a build folder, only the `cmake --build .` command is necessary.

# Installing dependencies manually

Ensure that you have the latest version of Qt, boost, and your C++ compiler installed.

*Note* : to ensure a very fast build time, it is recommended to use clang as compiler and ninja for building, on every platform.
Additionally, on Linux and Windows `lld` can be used as a linker. It is quite faster than `GNU ld` and `gold`. On recent Linux, `mold` can also be 
used, which is even faster.

At the time of this writing, this means :

| Software | Version                         |
|----------|---------------------------------|
| Compiler | clang 14 or gcc 12 or msvc 2022 |
| Qt       | 5.15 or Qt 6.2+                 |
| Boost    | 1.80                            |
| CMake    | 3.24                            |

However, to get a complete build with support for more features, more is needed :

| Software      | Version |
|---------------|---------|
| FFMPEG        | 5.x     | # Required for sound playback
| LLVM          | 14.x    | # Required for Faust support
| OpenSSL       | 1.1.x   | # Required to connect to wss / https
| Faust         | Latest  | # Required to load Faust plug-ins
| suil, lilv    | Latest  | # Required to load LV2 plug-ins
| PortAudio     | Latest  | # Required to playback sound using Coreaudio, ASIO, ALSA, Pulseaudio...
| JACK2         | Latest  | # Required to playback sound using JACK
| SDL2          | Latest  | # Required to have gamepad support
| Qt            | 5.15+   | # Required for the GFX addon
| qtshadertools | 5.15+   | # Required for the GFX addon

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
    -DSCORE_DYNAMIC_PLUGINS=1                   # Makes the linking faster (only on Mac / Linux ; on Windows it does not work without rebuilding every dependency)

> Important: Run the `cmake` command in a separate build folder, especially not in the source directory of score !

For instance, for generating the build files on Ubuntu, Debian or Linux Mint, that gives :

    cmake /path/to/score                         \
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

    -DCMAKE_PREFIX_PATH=/home/yourname/Qt/5.15.3/gcc_64

The path must contain a `lib` folder in which CMake is going to look for Qt.

Once CMake has ran successfully, do :

    cmake --build .

To be safe, you should have at least 8 gigabytes free on your hard drive before starting a build.

# Building with Qt Creator

Refer to this video : https://www.youtube.com/watch?v=LSifHFbuky0

# Windows with Visual Studio

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
aqt install --outputdir c:\Qt 5.15.3 windows desktop win64_msvc2019_64

# Build
cmake ../score -DCMAKE_PREFIX_PATH="c:/Qt/5.15.3/msvc2019_64" -DOSSIA_SDK="c:/score-sdk-msvc" -DSCORE_PCH=1 -DCMAKE_INSTALL_PREFIX=installed -DCMAKE_BUILD_TYPE=Debug
cmake --build . --config Debug
cmake --build . --config Debug --target install

# Run
cd installed
score.exe
```
