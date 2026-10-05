---
layout: default

title: Release build
description: "Creating a release build of score for production"

parent: "Building from source"
grand_parent: Development

permalink: /development/build/release.html
---

# Building a release

For frequent code changes, use [Hacking]({{ site.baseurl }}/development/build/hacking.html). Distribution maintainers should use [Packaging]({{ site.baseurl }}/development/build/packaging.html). Use the dependency scripts from the tag or branch you are building.

## Source and dependencies

```bash
git clone --recursive https://github.com/ossia/score
cd score
```

After switching tags or branches, run `git submodule update --init --recursive`. GitHub's automatically generated “Source code” archives omit submodules. Use a recursive clone or the separately uploaded `ossia.score-…-src.tar.xz` release asset.

The build requires C++23 and CMake 3.25 or newer.

- Qt 6: Core, Widgets, Gui, Network, Xml, StateMachine, OpenGL, OpenGLWidgets, Qml, Quick, QmlModels and ShaderTools, including development headers. The platform dependency scripts select the version and optional modules.
- Boost and vendored libraries: initialize the submodules, or use the system-library configuration when packaging.
- FFmpeg, audio backends, device and plug-in libraries: dependencies for the corresponding media features.
- C++ JIT: LLVM 20 or newer and compatible Clang development libraries. Faust also requires libfaust.

The authoritative requirements are [CMakeLists.txt](https://github.com/ossia/score/blob/master/CMakeLists.txt), [the CI dependency scripts](https://github.com/ossia/score/tree/master/ci), and the configure summary.

## Linux: system dependencies

Use the dependency script matching your distribution; the [Hacking]({{ site.baseurl }}/development/build/hacking.html#distribution-scripts) page lists the available recipes.

The developer script installs dependencies and makes a debug build. To build a release with the same dependencies, use a separate directory:

```bash
cmake -S . -B build-release -GNinja \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_UNITY_BUILD=ON
cmake --build build-release --parallel
./build-release/ossia-score
```

This produces a local executable, not a portable AppImage. Use [appimage.build.sh](https://github.com/ossia/score/blob/master/ci/appimage.build.sh) and its matching dependencies/deployment scripts for the official packaging configuration. Read those scripts before running them: they assume a packaging environment and may recreate build directories.

## Matching the official SDK

The ossia SDK contains the compiler and third-party dependencies needed to build score itself. Download it from [ossia/sdk](https://github.com/ossia/sdk/releases) and pass its directory as `OSSIA_SDK`.

The score SDK supplies score's headers and build support for run-time JIT add-ons. It is exported by a score build and distributed through score's package manager; it is not the SDK needed to build score itself. External add-on CMake builds also use this exported directory through `SCORE_SDK`; see [Avendish add-ons]({{ site.baseurl }}/development/plugins/plugins-with-avendish.html).

Use the ossia SDK tag selected by the checkout's CI scripts (currently `sdk42`). [tools/fetch-sdk.sh](https://github.com/ossia/score/blob/master/tools/fetch-sdk.sh) accepts the tag as its first argument; its default is pinned.

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

On ARM, use the matching architecture directory.

## Windows

Official Windows builds use llvm-mingw from the ossia SDK. MSYS2 CLANG64 is the alternative for development with system packages: run `tools/developer.sh` from its CLANG64 shell. MSVC is supported only for exceptional builds needing Qt WebEngine; it is not used for official releases.

For the official configuration, run these commands from the source root in Git Bash, with Chocolatey and 7-Zip available:

```bash
export RUNNER_ARCH=X64
bash ci/win32.deps.sh
bash ci/win32.build.sh
```

Use `RUNNER_ARCH=ARM64` on an ARM64 runner. The [dependency script](https://github.com/ossia/score/blob/master/ci/win32.deps.sh) installs Ninja, rsync and NSIS and extracts `sdk-mingw-x86_64.7z` into `C:/ossia-sdk-x86_64` (or `sdk-mingw-aarch64.7z` into `C:/ossia-sdk-aarch64`).

The [build script](https://github.com/ossia/score/blob/master/ci/win32.build.sh) puts the SDK's `llvm/bin` first on `PATH`, selects `clang.exe` and `clang++.exe`, configures a release unity build with strict feature checks, then builds the application and installer. For example, its x86_64 configuration is:

```bash
export PATH="/c/ossia-sdk-x86_64/llvm/bin:$PATH:/c/ossia-sdk-x86_64/cmake/bin"
cmake -GNinja -S . -B build \
  -DCMAKE_C_COMPILER=c:/ossia-sdk-x86_64/llvm/bin/clang.exe \
  -DCMAKE_CXX_COMPILER=c:/ossia-sdk-x86_64/llvm/bin/clang++.exe \
  -DOSSIA_SDK=c:/ossia-sdk-x86_64 \
  -DCMAKE_INSTALL_PREFIX=install \
  -DCMAKE_BUILD_TYPE=Release -DCMAKE_UNITY_BUILD=1 \
  -DOSSIA_STATIC_EXPORT=1 -DSCORE_INSTALL_HEADERS=1 \
  -DKFR_ARCH=avx2 -DSCORE_DEPLOYMENT_BUILD=1 \
  -DSCORE_STRICT_FEATURE_CHECK=1 \
  -DCMAKE_C_FLAGS="-g0" -DCMAKE_CXX_FLAGS="-g0"
cmake --build build
cmake --build build --target package
```

## macOS

For development with Homebrew, run `tools/developer.sh`. For an SDK release build, install Xcode and select it with `sudo xcode-select -s /Applications/Xcode.app`.

From the source root, install the tools and SDK using the same versions and archive layout as [CI](https://github.com/ossia/score/blob/master/ci/osx.package.deps.sh):

```bash
export MACOS_ARCH=aarch64
brew install gnu-tar ninja xz
curl -L "https://github.com/jcelerier/cninja/releases/download/v3.7.9/cninja-v3.7.9-macOS-$MACOS_ARCH.tar.gz" \
  -o cninja.tgz
gtar xhaf cninja.tgz
sudo mkdir -p /usr/local/bin
sudo cp cninja /usr/local/bin/
curl -L "https://github.com/ossia/sdk/releases/download/sdk42/sdk-macOS-$MACOS_ARCH.tar.xz" \
  -o "sdk-macOS-$MACOS_ARCH.tar.xz"
sudo mkdir -p "/opt/ossia-sdk-$MACOS_ARCH"
sudo gtar xhaf "sdk-macOS-$MACOS_ARCH.tar.xz" --strip-components=2 \
  --directory "/opt/ossia-sdk-$MACOS_ARCH"
bash ci/common.deps.sh MACOS
bash ci/osx.package.build.sh
```

Use `MACOS_ARCH=x86_64` for Intel. The [build script](https://github.com/ossia/score/blob/master/ci/osx.package.build.sh) selects Xcode, maps `aarch64` to CMake's `arm64`, runs cninja's `macos-release-12.0` configuration, and installs the application in `install` and exported headers in `SDK/usr`. Code signing and notarization are separate [packaging steps](https://github.com/ossia/score/blob/master/ci/osx.package.deploy.sh).
