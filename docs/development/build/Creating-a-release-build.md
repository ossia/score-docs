---
layout: default

title: "Release build"
description: "Creating a release build of score for production"

parent: "Building from source"
grand_parent: Development

permalink: /development/build/release.html
---

# Build

This page describes how to build score on various operating systems.

**Dear packagers: here are specific build instructions to make packages for Linux/BSD/... : [Packaging score for Linux]({{ site.baseurl }}/development/build/packaging.html)**.


## Dependencies
To build, you will need the following dependencies :
 * [Qt 5](http://www.qt.io/) (>= 5.12)
 * [CMake](https://cmake.org/) (>= 3.15)
 * [Boost](http://www.boost.org/) (automatically downloaded)
 * (optional) FFMPEG (http://www.ffmpeg.org) (>= 3.3)
 * A **recursive** clone of the score repository : `git clone --recursive https://github.com/ossia/score`.

The easiest way to get most dependencies in a prebuilt form is by [downloading our SDK for your platform](https://github.com/ossia/sdk/releases).

**Important:** do not use the source releases produced by GitHub :
they do not have the submodules and compiling with them won't work.

Your compiler need to be recent; supported compilers are:
* gcc >= 8
* clang >= 8
* Xcode >= 11
* Visual Studio 2019 (the very latest version !)


What does **not** work :
- GCC <= 7.
- Older MSVC versions

## Debian-like systems

### Ubuntu, Debian

#### Dependencies

```bash
sudo apt-get update -qq
sudo apt-get install wget software-properties-common

wget -nv https://github.com/Kitware/CMake/releases/download/v3.19.1/cmake-3.19.1-Linux-x86_64.tar.gz -O cmake-linux.tgz
tar xaf cmake-linux.tgz
rm cmake-linux.tgz
mv cmake* /opt/

echo 'deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-9 main' | sudo tee /etc/apt/sources.list.d/llvm.list
sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 1397BC53640DB551
sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 15CF4D18AF4F7421

sudo add-apt-repository --yes ppa:ubuntu-toolchain-r/test
sudo add-apt-repository --yes ppa:beineri/opt-qt-5.13.2-bionic

sudo apt-get update -qq
sudo apt-get install -qq --force-yes \
    g++-9 binutils libasound-dev ninja-build \
    gcovr lcov \
    qt513-meta-minimal qt513svg qt513quickcontrols2 qt513websockets qt513serialport \
    qt513base qt513declarative \
    libgl1-mesa-dev \
    libavcodec-dev libavutil-dev libavfilter-dev libavformat-dev libswresample-dev \
    portaudio19-dev clang-9 lld-9 \
    libbluetooth-dev \
    libsdl2-dev libsdl2-2.0-0 libglu1-mesa-dev libglu1-mesa \
    libgles2-mesa-dev \
    libavahi-compat-libdnssd-dev
```

#### Build

    mkdir -p build_folder
    cd build_folder
    /opt/cmake-3.19.1-Linux-x86_64/bin/cmake path/to/score \
      -DCMAKE_C_COMPILER=/usr/bin/gcc-9 \
      -DCMAKE_CXX_COMPILER=/usr/bin/g++-9 \
      -DCMAKE_PREFIX_PATH=/opt/qt513 \
      -DCMAKE_BUILD_TYPE=release \
      -DPORTAUDIO_ONLY_DYNAMIC=1
    make all_unity # you can add -j$(nproc) to make it faster

NOTE : if you have installed Qt with Qt installer instead of your distro package manager, then you may need to specify where CMake should look for Qt with, for example :

    cmake -GNinja -DCMAKE_PREFIX_PATH=~/Qt/5.13.2/gcc_64 ../score/

### Run

    ./score

### Raspberry Pi

#### Dependencies

First edit `/etc/apt/sources.list`.

Replace :

    deb http://archive.raspbian.org/raspbian jessie main

By :

    deb http://archive.raspbian.org/raspbian stretch main

Then :

    sudo apt -y install git cmake wget ninja-build libqt5websockets5-dev qtbase5-dev qtdeclarative5-dev qt5-default qtbase5-dev-tools qttools5-dev libqt5svg5-dev g++-7 libportmidi0 libasound-dev mesa-common-dev libboost-dev libavahi-compat-libdnssd-dev

#### Build

    mkdir -p build_folder
    cd build_folder
    cmake -GNinja -DCMAKE_C_COMPILER=/usr/bin/gcc-7 -DCMAKE_CXX_COMPILER=/usr/bin/g++-7 path/to/score
    ninja

### Run :

    $ ./score

## macOS :

There is a build.sh script at the root of the repository, it requires [Homebrew](http://brew.sh/)

So either :

    ./build.sh
    open build/score.app

Or

    ./build.sh release
    open build-release/score.app



## Build on Windows with Clang

- Download and extract the latest MinGW SDK here : https://github.com/ossia/sdk/releases/tag/sdk16
in `c:\score-sdk` (so you should have a `c:\score-sdk\llvm\` folder for instance).

- Install dependencies: CMake and ninja.

With chocolatey:

    cinst -y cmake ninja

- Build from a cmd shell (note: this will take 10-15 minutes on a good machine)

```
mkdir build
cd build

set PATH=%PATH%;c:\score-sdk\llvm\bin
cmake -GNinja c:/path/to/score ^
  -DCMAKE_C_COMPILER=c:/score-sdk/llvm/bin/clang.exe ^
  -DCMAKE_CXX_COMPILER=c:/score-sdk/llvm/bin/clang++.exe ^
  -DCMAKE_BUILD_TYPE=Release ^
  -DOSSIA_SDK=c:\score-sdk ^
  -DCMAKE_INSTALL_PREFIX=release ^
  -DCMAKE_PREFIX_PATH="c:/score-sdk/qt5-static;c:/score-sdk/llvm-libs;c:/score-sdk/SDL2;c:/score-sdk" ^
  -DCMAKE_UNITY_BUILD=1 ^
  -DOSSIA_STATIC_EXPORT=1 ^
  -DSCORE_INSTALL_HEADERS=1 ^
  -DDEPLOYMENT_BUILD=1

cmake --build .
cmake --build . --target package
```

This will create an installer for the latest version.
Alternatively, replace `cmake --build . --target package` by `cmake --build . --target install` to install the executable directly in the
`release` subfolder of your build folder.

## Build on Windows with MSVC (currently broken !)

This requires at least Visual Studio 2017 15.9.6, freely available from Microsoft's website.

First, install the dependencies with the mechanism of your choice.

Then, on a command shell, run :
```
mkdir score-build
cd score-build
cmake -T host=x64 -A x64 ../score -DCMAKE_BUILD_TYPE=release -DCMAKE_PREFIX_PATH=path/to/Qt5Config.cmake
cmake --build . --target package
```

The relevant folders are :
* For boost : the path to the folder contained in the archive downloaded, for instance c:\Libraries\boost_1_63_0 ; it should contain `boost`, `libs`, `doc` subfolders. e.g. `-DBOOST_ROOT=c:/Libraries/boost_1_63_0`.
* For Qt : the path to the `Qt5Config.cmake`, e.g. `-DCMAKE_PREFIX_PATH=c:/Libraries/Qt/5.7/msvc2015/lib/cmake/Qt5`.

This creates an installable package, install it and run score from your desktop. Else you have to copy the Qt DLLs and plug-ins to the folder where `score.exe` was built.


## Android

Clone qt5 from git :

    git clone https://github.com/qt/qt5
    cd qt5
    git submodule update --init --recursive

Apply the following patch : https://bugreports.qt.io/browse/QTBUG-60455
if it has not been merged, in the folder qt5/qtbase :

    cd qt5/qtbase
    git-apply 0001-Android-....patch

Also add `#include <QtMath>` in `qtbase/src/plugins/platforms/android/androidjniinput.cpp`.

Configure and build Qt5 :

    ../qt5/configure -opensource -confirm-license -xplatform 'android-clang-libc++' -nomake tests -nomake examples -android-ndk /opt/android-ndk-r15b -android-sdk /opt/android/sdk -android-arch armeabi-v7a -no-warnings-are-errors -opengl es2 -opengles3 -android-ndk-platform android-22 -prefix /opt/qt-android

    make -j8
    make install

Build the player library :

    cd ~/build
    cmake ~/score -DCMAKE_TOOLCHAIN_FILE=~/score/API/CMake/android_toolchain.cmake -DCMAKE_PREFIX_PATH=/opt/qt-android/lib/cmake/Qt5  -DISCORE_CONFIGURATION=android-debug -DISCORE_PLAYER=1 -Wno-dev -DOSSIA_PROTOCOL_MIDI=0

Put the library in the correct folder :

    mkdir -p /opt/qt-android/qml/Ossia/
    ln -s ~/score/API/ossia/ossia-qml/Ossia/*.qml  /opt/qt-android/qml/Ossia/
    cp ~/score/API/ossia/ossia-qml/Ossia/qmldir  /opt/qt-android/qml/Ossia/
    ln -s ~/build/libiscore_player_plugin.so /opt/qt-android/qml/Ossia/

Change the name of the library in the qmldir (iscore_player_plugin instead of ossia)

To run with QtCreator, add the following library in the android build :

    /opt/android-ndk-r14b/sources/cxx-stl/llvm-libc++/libs/armeabi-v7a/libc++_shared.so

(adapt the architecture, paths, etc... for your phone / tablet)

## Sanitization

    clang-tidy -p ~/iscore-tidy/compile_commands.json  base/**/*.cpp --header-filter=base/
