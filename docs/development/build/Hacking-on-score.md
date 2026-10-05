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

The script installs packages with Homebrew on macOS, the distribution package manager on Linux, or MSYS2 CLANG64 on Windows. Package installation may request administrator privileges. Its default build directory is `build-developer`; pass another directory as its argument if needed.

Subsequent rebuilds do not need to reinstall dependencies:

```bash
cmake --build build-developer --parallel
```

Open the root `CMakeLists.txt` in Qt Creator or another CMake-aware IDE, select the same compiler and build directory, and configure its run target to launch the built application. See [Release build]({{ site.baseurl }}/development/build/release.html) for dependency and SDK constraints.

## Distribution scripts

Use the dependency and build scripts matching your distribution:

| Distribution | Dependencies | Build recipe |
|---|---|---|
| Ubuntu 22.04 | [ubuntu.jammy.deps.sh](https://github.com/ossia/score/blob/master/ci/ubuntu.jammy.deps.sh) | [ubuntu.jammy.build.sh](https://github.com/ossia/score/blob/master/ci/ubuntu.jammy.build.sh) |
| Ubuntu 24.04 | [ubuntu.noble.deps.sh](https://github.com/ossia/score/blob/master/ci/ubuntu.noble.deps.sh) | [ubuntu.noble.build.sh](https://github.com/ossia/score/blob/master/ci/ubuntu.noble.build.sh) |
| Ubuntu 26.04 | [ubuntu.2604.deps.sh](https://github.com/ossia/score/blob/master/ci/ubuntu.2604.deps.sh) | [ubuntu.2604.build.sh](https://github.com/ossia/score/blob/master/ci/ubuntu.2604.build.sh) |
| Debian 12 | [debian.bookworm.deps.sh](https://github.com/ossia/score/blob/master/ci/debian.bookworm.deps.sh) | [debian.bookworm.build.sh](https://github.com/ossia/score/blob/master/ci/debian.bookworm.build.sh) |
| Debian 13 | [debian.trixie.deps.sh](https://github.com/ossia/score/blob/master/ci/debian.trixie.deps.sh) | [debian.trixie.build.sh](https://github.com/ossia/score/blob/master/ci/debian.trixie.build.sh) |
| Arch Linux | [archlinux.deps.sh](https://github.com/ossia/score/blob/master/ci/archlinux.deps.sh) | [archlinux.build.sh](https://github.com/ossia/score/blob/master/ci/archlinux.build.sh) |
| Fedora | [fedora.deps.sh](https://github.com/ossia/score/blob/master/ci/fedora.deps.sh) | [fedora.build.sh](https://github.com/ossia/score/blob/master/ci/fedora.build.sh) |
| openSUSE Leap | [suse.leap.deps.sh](https://github.com/ossia/score/blob/master/ci/suse.leap.deps.sh) | [suse.build.sh](https://github.com/ossia/score/blob/master/ci/suse.build.sh) |
| openSUSE Tumbleweed | [suse.tumbleweed.deps.sh](https://github.com/ossia/score/blob/master/ci/suse.tumbleweed.deps.sh) | [suse.build.sh](https://github.com/ossia/score/blob/master/ci/suse.build.sh) |
| FreeBSD | [freebsd.deps.sh](https://github.com/ossia/score/blob/master/ci/freebsd.deps.sh) | [freebsd.build.sh](https://github.com/ossia/score/blob/master/ci/freebsd.build.sh) |

Run dependency scripts from the source root; they also fetch add-ons. Some accept a `PKGS` environment variable for compiler packages. `tools/developer.sh` supplies `clang-22 lld-22 libclang-22-dev llvm-22-dev` for Ubuntu 26.04 and selects an installed Clang compiler.

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

Keep unity builds off for frequent small edits. The developer script enables dynamic core plug-ins on Linux/macOS and disables them on Windows; external and JIT add-ons remain supported.

Official Windows releases use llvm-mingw; MSYS2 CLANG64 is the development alternative. MSVC is only needed for exceptional Qt WebEngine builds. Use a fresh build directory when changing toolchains or switching between SDK and system dependencies. See [Release build]({{ site.baseurl }}/development/build/release.html) for the SDK commands.

## Add-ons

The base repository does not include every add-on shipped by official builds. To include one in your source build, clone it into `src/addons`, then reconfigure:

```bash
git clone --recursive https://github.com/ossia/score-addon-ndi src/addons/score-addon-ndi
cmake -S . -B build-developer
cmake --build build-developer --parallel
```

Some add-ons require additional dependencies. [ci/common.deps.sh](https://github.com/ossia/score/blob/master/ci/common.deps.sh) lists the add-ons and revisions used by official builds.

For a new audio, control, image or GPU processor, start with [Avendish]({{ site.baseurl }}/development/plugins/plugins-with-avendish.html). For application extensions and protocols, see [Plug-ins]({{ site.baseurl }}/development/plug-ins.html). External add-ons can also be built separately against your score build or its exported headers.

## Debugging and platform recipes

- [Qt Creator documentation](https://doc.qt.io/qtcreator/): CMake kits, run configurations and debugging.
- [Current build configurations](https://github.com/ossia/score/tree/master/.cninja): development, sanitizer and release configurations used by the project.
- [Windows symbol helper](https://github.com/ossia/score/blob/master/tools/windows-resymbolize.sh): the maintained recipe for preparing Windows debug symbols.
- [Platform CI scripts](https://github.com/ossia/score/tree/master/ci): llvm-mingw, MSYS2 CLANG64, Homebrew, Linux distributions and FreeBSD.
