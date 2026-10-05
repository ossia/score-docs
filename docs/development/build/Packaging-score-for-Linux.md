---
layout: default

title: Packaging
description: "Packaging score for Linux distros"

parent: "Building from source"
grand_parent: Development

permalink: /development/build/packaging.html
---

# Packaging for Linux distributions

Use a recursive checkout or the project's uploaded source tarball, not GitHub's automatically generated source archive. Dependencies and compiler requirements are summarized in [Release build]({{ site.baseurl }}/development/build/release.html); the scripts from the version being packaged are the authoritative recipe.

## Vendored or system libraries

By default, score uses its selected dependency versions where appropriate. This avoids mismatches with libraries whose APIs or behavior differ between distributions. score also supports an explicit system-library configuration with `SCORE_USE_SYSTEM_LIBRARIES=ON` (which enables the corresponding libossia option). Optional dependencies can fall back to vendored copies; inspect the configure output rather than assuming every dependency came from the system.

See [ScoreConfiguration.cmake](https://github.com/ossia/score/blob/master/cmake/ScoreConfiguration.cmake) and the [Debian system-library recipe](https://github.com/ossia/score/blob/master/ci/debian.trixie-system.build.sh). Package managers should record the enabled feature set: omitting LLVM/Clang, Faust, FFmpeg or a device SDK can remove user-visible functionality without preventing a build.

## Build and stage the application

A distribution-style configuration uses the current `SCORE_DEPLOYMENT_BUILD` and `SCORE_FHS_BUILD` options. The old unprefixed `DEPLOYMENT_BUILD` option is not the current recipe.

```bash
cmake -S /path/to/score -B build-package -GNinja \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=/usr \
  -DSCORE_DEPLOYMENT_BUILD=ON \
  -DSCORE_FHS_BUILD=ON \
  -DSCORE_STATIC_PLUGINS=ON \
  -DBUILD_SHARED_LIBS=OFF
cmake --build build-package --parallel
DESTDIR=/path/to/package-root cmake --install build-package \
  --strip --component OssiaScore
```

`OssiaScore` installs the application component rather than all development headers from score and its dependencies. Exported add-on headers belong to the separate `Devel` component. Add `SCORE_USE_SYSTEM_LIBRARIES=ON` when required by distribution policy; the example above otherwise retains the default dependency selection.

For CPack-generated packages, use your distribution's dependency, build and deployment scripts. See the [distribution table]({{ site.baseurl }}/development/build/hacking.html#distribution-scripts) and [CI recipes](https://github.com/ossia/score/tree/master/ci).

## Reference recipes

- [Arch Linux system build](https://github.com/ossia/score/blob/master/ci/archlinux.system.build.sh) and [AUR package](https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=ossia-score).
- [Nix recipe](https://github.com/ossia/score/blob/master/ci/nix.build.nix).
- [Flatpak manifest](https://github.com/ossia/score/blob/master/cmake/Deployment/Linux/Flatpak/io.ossia.score.yml).
- [AppImage build](https://github.com/ossia/score/blob/master/ci/appimage.build.sh), for a bundled distribution rather than an FHS system package.

An application package and its exported score SDK must come from the same build if users are expected to load binary add-ons. Preserve the build's compiler/standard-library and dependency compatibility when distributing that SDK.
