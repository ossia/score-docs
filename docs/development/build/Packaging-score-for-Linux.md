---
layout: default

title: Packaging
description: "Packaging score for Linux distros"

parent: "Building from source"
grand_parent: Development

permalink: /development/build/packaging.html
---

# General information

Score has many build options, modules, etc... but there is one canonical way to build a release tailored for Unix distributions.

**Please** use the package versions provided with score / libossia as much as possible and not the distribution-provided packages, else we get bug reports because the version of TBB / PortAudio / ... of $DISTRO has known problems. In particular RtMidi and oscpack have been more or less entirely rewritten.

If you don't want to, then it's better to let the users use the AppImage because those are known to be working.

If your distro has a PortAudio package, please ensure that its PortAudio version is not linking against JACK, because else it can cause hangs (e.g. in Debian, Ubuntu). If it does, then please ensure that score does not link against PortAudio.

Examples of existing packages:
- [ArchLinux AUR](https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=ossia-score)
- [Nix](https://github.com/ossia/score/blob/master/ci/nix.build.nix)
- [MinGW](https://github.com/msys2/MINGW-packages/blob/master/mingw-w64-ossia-score/PKGBUILD)
- [Flatpak](https://github.com/ossia/score/blob/master/cmake/Deployment/Linux/Flatpak/io.ossia.score.yml)

# Dependencies

* CMake (>= 3.24)
* Qt (>= 6.4)
* Boost (whatever is the latest version, at least 1.83, otherwise ossia will download the latest version by itself)
* FFMPEG (libavcodec, etc., at least FFMPEG 5)

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


