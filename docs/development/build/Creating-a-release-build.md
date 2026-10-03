---
layout: default

title: Release build
description: "Creating a release build of score for production"

parent: "Building from source"
grand_parent: Development

permalink: /development/build/release.html
---

# Building a release

These instructions describe the current source tree. Use the scripts from the tag you are building: a development checkout can require newer dependencies than the latest published release. Distribution maintainers should use [Packaging]({{ site.baseurl }}/development/build/packaging.html); for frequent code changes, use [Hacking]({{ site.baseurl }}/development/build/hacking.html).

## Source and dependencies

```bash
git clone --recursive https://github.com/ossia/score
cd score
```

After switching tags or branches, run `git submodule update --init --recursive`. GitHub's automatically generated “Source code” archives omit submodules. Use a recursive clone or the separately uploaded `ossia.score-…-src.tar.xz` release asset.

The current build requests **C++23** and **CMake 3.25 or newer**. Use a recent compiler and its matching standard library, preferably the toolchain selected by the platform's CI recipe rather than the old GCC 9 / Qt 5 instructions.

- **Qt 6**: Core, Widgets, Gui, Network, Xml, StateMachine, OpenGL, OpenGLWidgets, Qml, Quick, QmlModels and ShaderTools are required. Private development headers and optional modules enable additional features. The top-level CMake check accepts Qt 6.2; this is not a promise that every optional graphics feature works with that version. Follow the dependency recipe for the checkout and platform.
- **Boost and vendored libraries**: initialize the submodules and let CMake use the versions selected by the source tree, or deliberately choose the system-library configuration when packaging.
- **FFmpeg, audio backends, device and plug-in libraries**: required for their respective media capabilities. A successful minimal build is not necessarily equivalent to an official release.
- **C++ JIT**: requires LLVM 20 or newer and compatible Clang development libraries. Missing dependencies cause the JIT plug-in to be skipped. Faust additionally needs libfaust built against a compatible LLVM.

The authoritative requirements are [CMakeLists.txt](https://github.com/ossia/score/blob/master/CMakeLists.txt), [the CI dependency scripts](https://github.com/ossia/score/tree/master/ci), and the configure summary.

## Linux: system dependencies

Use the dependency script for the distribution you actually run. In particular, Ubuntu 26.04 uses [ubuntu.2604.deps.sh](https://github.com/ossia/score/blob/master/ci/ubuntu.2604.deps.sh), not the Ubuntu 24.04 package list. Its Qt WebSockets, SerialPort and ShaderTools packages are named `qt6-websockets-dev`, `qt6-serialport-dev` and `qt6-shadertools-dev`.

The simplest dependency setup is the [developer script]({{ site.baseurl }}/development/build/hacking.html), which also makes a debug build. For a release build using those installed dependencies, configure a **separate** directory:

```bash
cmake -S . -B build-release -GNinja \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_UNITY_BUILD=ON
cmake --build build-release --parallel
./build-release/ossia-score
```

This produces a local executable, not a portable AppImage. Use [appimage.build.sh](https://github.com/ossia/score/blob/master/ci/appimage.build.sh) and its matching dependencies/deployment scripts for the official packaging configuration. Read those scripts before running them: they assume a packaging environment and may recreate build directories.

## Matching the official SDK

There are two different SDKs:

- **`OSSIA_SDK`**: compilers and third-party dependencies, published in [ossia/score-sdk](https://github.com/ossia/score-sdk/releases).
- **`SCORE_SDK`**: score headers and build support exported by a particular score build, used for [external add-ons]({{ site.baseurl }}/development/plugins/plugins-with-avendish.html).

Select the dependency SDK used by the checkout's CI scripts. [tools/fetch-sdk.sh](https://github.com/ossia/score/blob/master/tools/fetch-sdk.sh) accepts the SDK tag as its first argument; its default is a pinned tag, **not a lookup of the newest release**, and can lag behind the CI recipes. Check the script's extraction paths and required tools before running it. Never mix an arbitrary score header SDK with a different application build.

For a Linux SDK extracted to `/opt/ossia-sdk-x86_64`, a local release configuration is:

```bash
cmake -S . -B build-sdk -GNinja \
  -DOSSIA_SDK=/opt/ossia-sdk-x86_64 \
  -DCMAKE_C_COMPILER=/opt/ossia-sdk-x86_64/llvm/bin/clang \
  -DCMAKE_CXX_COMPILER=/opt/ossia-sdk-x86_64/llvm/bin/clang++ \
  -DCMAKE_BUILD_TYPE=Release \
  -DSCORE_DYNAMIC_PLUGINS=OFF
cmake --build build-sdk --parallel
```

Use the appropriate architecture directory rather than copying the x86_64 path to an ARM machine. Keep SDK headers and libraries together; mixing them with system Qt, FFmpeg or LLVM can compile successfully and still fail at run time.

## Windows

For development with system packages, use an **MSYS2 CLANG64** shell and `tools/developer.sh`. Official SDK builds use the LLVM/MinGW toolchain, not an interchangeable MSVC SDK. Put the selected SDK's `llvm/bin` first on `PATH` and follow [win32.build.sh](https://github.com/ossia/score/blob/master/ci/win32.build.sh) with [win32.deps.sh](https://github.com/ossia/score/blob/master/ci/win32.deps.sh).

The current Windows target is Windows 10 or newer. CI has separate x86_64 and ARM64 builds; use the matching SDK and binaries. The fetch script's Windows branch is x86_64-specific, so it is not an ARM64 installation recipe. Visual Studio builds have their own [CI recipe](https://github.com/ossia/score/blob/master/ci/win32.msvc.build.cmd); do not reuse obsolete instructions pinned to Visual Studio 2022 17.6.2.

## macOS

Choose either a Homebrew build (`tools/developer.sh`) or a matching ossia SDK, not a mixture of both. SDK builds use Xcode and an architecture-specific `/opt/ossia-sdk-aarch64` or `/opt/ossia-sdk-x86_64` directory. Both architectures have [CI build jobs](https://github.com/ossia/score/blob/master/.github/workflows/mac-builds.yaml).

The current [packaging script](https://github.com/ossia/score/blob/master/ci/osx.package.build.sh) selects the `macos-release-12.0` configuration. That deployment target is not a guarantee that all bundled SDK libraries run on macOS 12: use the [published installation requirements]({{ site.baseurl }}/quick-start/installation.html) for downloaded applications. Code signing and notarization are separate packaging steps, not prerequisites for a local development build.
