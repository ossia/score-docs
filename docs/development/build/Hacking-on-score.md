---
layout: default

title: Hacking
description: "Creating a development build of score"

parent: "Building from source"
grand_parent: Development

permalink: /development/build/hacking.html
---

# Quickstart

The [developer script](https://github.com/ossia/score/blob/master/tools/developer.sh) installs platform dependencies and configures a debug build with precompiled headers:

```bash
git clone --recursive -j16 https://github.com/ossia/score
cd score
./tools/developer.sh
```

Read the script before running it: dependency installation changes system packages and may ask for administrator privileges. It uses Homebrew on macOS, distribution-specific scripts on Linux, and supports MSYS2 on Windows. Use the **CLANG64** shell on Windows. The default build directory is `build-developer`; pass another directory as the script's argument if needed.

Subsequent rebuilds do not need to reinstall dependencies:

```bash
cmake --build build-developer --parallel
```

Open the root `CMakeLists.txt` in Qt Creator or another CMake-aware IDE, select the same compiler and build directory, and configure its run target to launch the built application. See [Release build]({{ site.baseurl }}/development/build/release.html) for dependency and SDK constraints.

## Ubuntu 26.04

The script recognizes Ubuntu's `resolute` codename and selects `ci/ubuntu.2604.deps.sh`. Its default `PKGS` is `clang-22 lld-22 libclang-22-dev llvm-22-dev`; it can be overridden in the environment. Keep the compiler, LLVM and Clang development packages compatible, especially when enabling C++ JIT. The script selects an installed Clang compiler, preferring version 22, then earlier supported versions.

Do not reuse the Noble Qt package names on 26.04. For manual installation or CI, consult the matching scripts:

| Distribution | Dependencies | Build recipe |
|---|---|---|
| Ubuntu 22.04 | [ubuntu.jammy.deps.sh](https://github.com/ossia/score/blob/master/ci/ubuntu.jammy.deps.sh) | [ubuntu.jammy.build.sh](https://github.com/ossia/score/blob/master/ci/ubuntu.jammy.build.sh) |
| Ubuntu 24.04 | [ubuntu.noble.deps.sh](https://github.com/ossia/score/blob/master/ci/ubuntu.noble.deps.sh) | [ubuntu.noble.build.sh](https://github.com/ossia/score/blob/master/ci/ubuntu.noble.build.sh) |
| Ubuntu 26.04 | [ubuntu.2604.deps.sh](https://github.com/ossia/score/blob/master/ci/ubuntu.2604.deps.sh) | [ubuntu.2604.build.sh](https://github.com/ossia/score/blob/master/ci/ubuntu.2604.build.sh) |

The dependency scripts are not passive package lists: they also fetch add-ons. When invoking the 26.04 dependency script directly, provide its required `PKGS` environment variable and run it from the source root.

## Manual development configuration

With dependencies already installed, a Linux debug build can be configured as follows:

```bash
cmake -S . -B build-developer -GNinja \
  -DCMAKE_C_COMPILER=clang \
  -DCMAKE_CXX_COMPILER=clang++ \
  -DCMAKE_BUILD_TYPE=Debug \
  -DSCORE_PCH=ON \
  -DSCORE_DYNAMIC_PLUGINS=ON \
  -DCMAKE_COLOR_DIAGNOSTICS=ON
cmake --build build-developer --parallel
./build-developer/ossia-score
```

Use the installed compiler's versioned name if necessary. For faster linking on Linux, add `-fuse-ld=lld` (or `mold`) to CMake's executable, shared and module linker flags if that linker is installed.

Keep unity builds off for frequent small edits; they favor full rebuilds over edit/compile iterations. The developer script enables dynamic core plug-ins on Linux/macOS but disables them on Windows. This build-layout choice is **not** the same as support for loading external add-ons or compiling add-ons at run time on Windows.

Use a fresh build directory when changing toolchains or switching between SDK and system dependencies. SDK builds should follow the platform recipe in [Release build]({{ site.baseurl }}/development/build/release.html); in particular, do not combine Homebrew headers with the SDK's libraries.

## Add-ons

The base repository does not include every add-on shipped by official builds. To include one in your source build, clone it into `src/addons`, then reconfigure:

```bash
git clone --recursive https://github.com/ossia/score-addon-ndi src/addons/score-addon-ndi
cmake -S . -B build-developer
cmake --build build-developer --parallel
```

The add-on can require its own SDK or runtime. [ci/common.deps.sh](https://github.com/ossia/score/blob/master/ci/common.deps.sh) records the add-ons and revisions used by the distribution; it is not a guarantee that all of their optional dependencies exist on your workstation.

For a new audio, control, image or GPU processor, start with [Avendish]({{ site.baseurl }}/development/plugins/plugins-with-avendish.html). For application extensions and protocols, see [Plug-ins]({{ site.baseurl }}/development/plug-ins.html). External add-ons can be built against either your score build or a matching exported score SDK; they do not have to be added to the main repository.

## Debugging and platform recipes

- [Qt Creator documentation](https://doc.qt.io/qtcreator/): CMake kits, run configurations and debugging.
- [Current build configurations](https://github.com/ossia/score/tree/master/.cninja): development, sanitizer and release configurations used by the project.
- [Windows symbol helper](https://github.com/ossia/score/blob/master/tools/windows-resymbolize.sh): the maintained recipe for preparing Windows debug symbols.
- [Platform CI scripts](https://github.com/ossia/score/tree/master/ci): Homebrew, MSYS2, Visual Studio, Linux distributions and FreeBSD. Use the scripts at your checkout's revision rather than assuming the master branch still matches an older release.
