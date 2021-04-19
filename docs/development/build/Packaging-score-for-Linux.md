---
layout: default

title: "Packaging"
description: "Packaging score for Linux distros "

parent: "Building from source"
grand_parent: Development

permalink: /development/build/packaging.html
---

# General information

Score has many build options, modules, etc... but there is one canonical way to build a release tailored for Unix distros.

**Please** use the package versions provided with score / libossia as much as possible and not the distros one, else we get bug reports because the version of tbb / portaudio / ... of $DISTRO has known problems. In particular RtMidi and oscpack have been more or less entirely rewritten.

If you don't want to, then it's better to let the users use the AppImage because those are known to be working.

If your distro has a PortAudio package, please ensure that its PortAudio version is not linking against JACK, because else it can cause hangs (e.g. in Debian, Ubuntu). If it does, then please ensure that score does not link against PortAudio.

An example of package is the one provided in the ArchLinux AUR : https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=ossia-score

# Dependencies

* CMake (>= 3.9)
* Qt (>= 5.12)
* Boost (whatever is the latest version, at least 1.68)
* FFMPEG (libavcodec, etc., at least FFMPEG 3)

# Building a release

The procedure is straightforward:

```bash
# Configure step
cmake -Wno-dev \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_UNITY_BUILD=1 \
  -DDEPLOYMENT_BUILD=1 \
  -DCMAKE_SKIP_RPATH=ON \
  -DCMAKE_INSTALL_PREFIX="/usr" \
  "srcdir"

# Build step
# Just running make is possible but will be much slower.
cmake --build . # adding -- -j4 at least will greatly increase build speed

# Install step
# do **not** just run make install, else score will install a lot of unneeded headers (boost, etc).
cmake -DCMAKE_INSTALL_DO_STRIP=1 -DCOMPONENT=OssiaScore -P cmake_install.cmake
```

### Important note
Due to a bug not fixed in mainline LLVM yet, we recommend disabling the JIT plug-in which may cause crashes (will be fixed in LLVM-12 ; LLVM-11 and LLVM-10 won't work). Add the following to the CMake invocation:

    -DSCORE_DISABLED_PLUGINS="score-plugin-jit"
