---
layout: default

title: "Hacking"
description: "Creating a development build of score"

parent: "Building from source"
grand_parent: Development

permalink: /development/build/hacking.html
---

# Quickstart

This page presents how to start developing things on ossia score.

We recommend heavily to use QtCreator as IDE to do so, or at least an IDE with native support for CMake.

- [For Windows](#windows-with-visual-studio)
- [For macOS](#macos)
- [For various Linux distros](#arch-linux)

# System dependencies

Ensure that you have the latest version of Qt, boost, and your C++ compiler installed.

*Note* : to ensure a very fast build time, it is recommended to use clang as compiler and ninja for building, on every platform.
Additionally, on Linux and Windows `lld` can be used as a linker. It is quite faster than `GNU ld` and `gold`.

At the time of this writing, this means :

| Software | Version                         |
|----------|---------------------------------|
| Compiler | clang 11 or gcc 10 or msvc 2019 |
| Qt       | 5.15 (Qt6 is not supported yet) |
| Boost    | 1.75                            |
| CMake    | 3.20                            |

However, to get a complete build with support for more features, more is needed :

| Software      | Version |
|---------------|---------|
| FFMPEG        | 4.x     | # Required for sound playback
| LLVM          | 9.x     | # Required for Faust support
| OpenSSL       | 1.1.x   | # Required to connect to wss / https
| Faust         | Latest  | # Required to load Faust plug-ins
| suil, lilv    | Latest  | # Required to load LV2 plug-ins
| PortAudio     | Latest  | # Required to playback sound using Coreaudio, ASIO, ALSA, Pulseaudio...
| JACK2         | Latest  | # Required to playback sound using JACK
| SDL2          | Latest  | # Required to have gamepad support
| qt 5.15       | Latest  | # Required for the GFX addon
| qtshadertools | Latest  | # Required for the GFX addon

They can be downloaded either from here for a pre-built set of packages : https://github.com/ossia/sdk/releases

Or you can install them with your package manager of choice - see the packages for each platform at the end of this document.

# Useful documentation

- (Using) CMake : https://cliutils.gitlab.io/modern-cmake/chapters/intro/running.html
- (Writing) CMake : https://cmake.org/cmake/help/latest/manual/cmake-buildsystem.7.html
- Qt : https://doc.qt.io/qt-5/gettingstarted.html
- Qt Creator : https://doc.qt.io/qtcreator/index.html

# Building on the command line

First get a recursive clone of the repository :

    $ git clone --recursive -j16 https://github.com/ossia/score

The preferred way to build when hacking on the software is with [cninja](https://github.com/jcelerier/cninja):

    cninja ~/path/to/score developer

Alternatively, one can build with CMake.
Pass the following options to `cmake` to ensure maximal build speed :

    -GNinja
    -DCMAKE_C_COMPILER=/path/to/clang
    -DCMAKE_CXX_COMPILER=/path/to/clang++
    -DCMAKE_SHARED_LINKER_FLAGS="-fuse-ld=lld"
    -DCMAKE_EXE_LINKER_FLAGS="-fuse-ld=lld"
    -DCMAKE_BUILD_TYPE=Debug
    -DSCORE_PCH=1
    -DSCORE_DYNAMIC_PLUGINS=1

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

*Note : * Run the `cmake` command in a separate build folder, especially not in the source directory of score !

If you are not using your distribution's Qt version because it's too old, pass the path to a recent version with, for instance,

    -DCMAKE_PREFIX_PATH=/home/yourname/Qt/5.15.3/gcc_64

The path must contain a `lib` folder in which CMake is going to look for Qt.

Once CMake has ran successfully, do :

    cmake --build .

To be safe, you should have at least 15 gigabytes free on your hard drive before starting a build.

# Building with Qt Creator

Refer to this video : https://www.youtube.com/watch?v=LSifHFbuky0

# Quick scripts to get started

## Arch Linux
```
pacman -S git cmake ninja clang lld boost qt5-base qt5-imageformats qt5-websockets qt5-quickcontrols2 qt5-serialport qt5-declarative qt5-tools  ffmpeg portaudio jack lv2 suil lilv sdl2

# Clone the code
git clone --recursive -j16 https://github.com/ossia/score
cd score

# Build
mkdir build
cd build
CC=clang CXX=clang++ cmake .. -DSCORE_CONFIGURATION=debug -GNinja
ninja

# Run
./ossia-score
```
## Ubuntu 20.10, 20.04, 19.10, 19.04, 18.10, 18.04

```
# Install dependencies
snap install cmake --edge --classic
apt update
apt -y install clang lld build-essential libavdevice-dev libavformat-dev libswresample-dev ninja-build portaudio19-dev llvm-dev libclang-dev liblilv-dev libsuil-dev git mesa-common-dev

# If you want to use the latest Qt which fixes a lot of bugs present in Debian's old version
apt -y install python3-pip python3 p7zip-full
python3 -m pip install aqtinstall
python3 -m aqt install --outputdir ~/Qt 5.15.1 linux desktop

# Else use that:
apt -y install qtbase5-dev qtdeclarative5-dev qtbase5-private-dev qtdeclarative5-private-dev libqt5websockets5-dev

# Clone the code
git clone --recursive -j16 https://github.com/ossia/score
cd score

# Build
mkdir build
cd build
CC=clang CXX=clang++ cmake .. -DCMAKE_PREFIX_PATH=~/Qt/5.15.1/gcc_64 -DSCORE_CONFIGURATION=debug -GNinja
ninja

# Run
./run.sh
```

## Debian stable (also derivatives such as LibraZiK)

```
# Install dependencies
apt update
apt -y install build-essential libboost-dev libavdevice-dev libavformat-dev libswresample-dev cmake ninja-build portaudio19-dev git mesa-common-dev

# If you want to use the latest Qt which fixes a lot of bugs present in Debian's old version
apt -y install python3-pip python3 p7zip-full
python3 -m pip install aqtinstall
python3 -m aqt install --outputdir ~/Qt 5.15.1 linux desktop

# Else use that:
apt -y install qtbase5-dev qtdeclarative5-dev qtbase5-private-dev qtdeclarative5-private-dev libqt5websockets5-dev

# Also useful but not mandatory (support for LV2, wiimotes, serial port, etc...):
apt -y install llvm-dev libbluetooth-dev libqt5serialport5-dev libqt5websockets5-dev libfftw3-dev liblilv-dev libsuil-dev

# Clone the code
git clone --recursive -j16 https://github.com/ossia/score
cd score

# Build
mkdir build
cd build
# The line with PREFIX is only necessary if you used the latest Qt
cmake .. \
  -DCMAKE_PREFIX_PATH=~/Qt/5.15.1/gcc_64 \
  -DCMAKE_BUILD_TYPE=Debug \
  -GNinja

ninja

# Run
./run.sh
```

## Fedora
```
# Install dependencies
# RPMFusion repos are required
dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

dnf install cmake clang lld ffmpeg-devel llvm-devel portaudio-devel lilv-devel suil-devel ninja-build git qt5-qtbase-devel qt5-qtsvg-devel qt5-qttools-devel qt5-qtserialport-devel qt5-qtwebsockets-devel qt5-qtdeclarative-devel qt5-qtquickcontrols2-devel

# Clone the code
git clone --recursive -j16 https://github.com/ossia/score
cd score

# Build
mkdir build
cd build
CC=clang CXX=clang++ cmake .. -DSCORE_CONFIGURATION=debug -GNinja
ninja

# Run
./run.sh
```

## OpenSuse Tumbleweed
```
# Install dependencies
zypper install libqt5-qtbase-devel cmake clang ninja boost-devel lld llvm-devel libjack-devel portaudio-devel lv2-devel liblilv-0-devel suil-devel libSDL2-devel libqt5-qtdeclarative-devel  libqt5-qtwebsockets-devel libqt5-qttools  libqt5-qtserialport-devel libqt5-qtquickcontrols2 libqt5-qtimageformats-devel ffmpeg-4-libavcodec-devel ffmpeg-4-libavdevice-devel ffmpeg-4-libavfilter-devel ffmpeg-4-libavformat-devel ffmpeg-4-libswresample-devel

# Clone the code
git clone --recursive -j16 https://github.com/ossia/score
cd score

# Build
mkdir build
cd build
CC=clang CXX=clang++ cmake .. -DSCORE_CONFIGURATION=debug -DOSSIA_USE_FAST_LINKER=1 -GNinja
ninja

# Run
./run.sh
```

## macOS

First install XCode and [Homebrew](https://brew.sh).
Then :
```
# Install dependencies
brew install git qt5 ninja cmake ffmpeg portaudio boost

# Clone the code
git clone --recursive -j16 https://github.com/ossia/score
cd score

# Build
mkdir build
cd build
cmake ~/score -DCMAKE_PREFIX_PATH=/usr/local/Cellar/qt -DSCORE_CONFIGURATION=debug -GNinja
ninja

# Run
./score
```

## Windows (with Visual Studio)

First install:
* The latest version of Visual Studio 2019 (16.10 as of July 2021)
* [git](https://gitforwindows.org/)
* [CMake](https://cmake.org/)
* [Python](https://www.python.org)
* Take a few seconds to contemplate the easiness of building on the above Unix platforms
* Extract https://github.com/ossia/sdk/releases/download/sdk14/win-audio-sdk-msvc.zip in your `c:\` so that the folders once extracted look like `c:\score-sdk-msvc\portaudio` and `c:\score-sdk-msvc\ffmpeg`


Run a `x64 Native Tools Command Prompt for VS 2019`:
![Screenshot](https://imgur.com/chDaR6J)

In the command prompt, install Qt:

(Assuming your development environment is in a `c:\dev` folder)
```
cd c:\dev

# Install dependencies
## Qt
pip install aqtinstall
aqt install --outputdir c:\Qt 5.15.2 windows desktop win64_msvc2019_64

# Build
cmake ../score -DCMAKE_PREFIX_PATH="c:/Qt/5.15.2/msvc2019_64" -DOSSIA_SDK="c:/score-sdk-msvc" -DSCORE_CONFIGURATION=static-debug -DCMAKE_INSTALL_PREFIX=installed
cmake --build . --config Release
cmake --build . --config Release --target install

# Run
cd installed
score.exe
```

## Windows (with MSYS2)
First download [the MinGW SDK](https://github.com/ossia/sdk/releases/download/sdk21/sdk-mingw.7z) and extract it in your `c:\` (the folder should look like `c:\ossia-sdk\ffmpeg`)

Then, in a mingw-w64 terminal (not an MSYS terminal, this is very important ! if in doubt, run `c:\msys64\mingw64.exe`):

```
# Install dependencies
pacman -S mingw-w64-x86_64-cmake  mingw-w64-x86_64-ninja

# Build
cmake ../score \
  -GNinja \
  -DCMAKE_C_COMPILER="c:/score-sdk/llvm/bin/clang.exe" \
  -DCMAKE_CXX_COMPILER="c:/score-sdk/llvm/bin/clang++.exe" \
  -DCMAKE_PREFIX_PATH="c:/score-sdk/qt5-dynamic" \
  -DOSSIA_SDK="c:/score-sdk" \
  -DSCORE_CONFIGURATION=debug \
  -DOSSIA_USE_FAST_LINKER=1 \
  -DCMAKE_INSTALL_PREFIX=installed

cmake --build . --config Release
cmake --build . --config Release --target install

# Run
cd installed
score.exe
```
