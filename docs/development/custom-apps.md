---
layout: default
title: Custom applications
description: "Package a QML interface and score as a branded application"
parent: Development
permalink: /development/custom-apps.html
---

# Custom applications

Package score with a QML interface, a score and its media as a standalone application. Start from the [custom application template](https://github.com/ossia-templates/score-custom-app-template): replace `qml/Main.qml` and `score/app.score`, then edit the application name and metadata in its workflows.

The template's [packaging workflow](https://github.com/ossia-templates/score-custom-app-template/blob/master/.github/workflows/build.yml) uses an existing score release. Its [full-build workflow](https://github.com/ossia-templates/score-custom-app-template/blob/master/.github/workflows/full-build.yml) builds score with selected features before packaging.

## First package

Run from the score source checkout with Bash:

```bash
bash tools/create-app.sh --help

bash tools/create-app.sh \
  --qml /absolute/path/to/App.qml \
  --qml /absolute/path/to/ui-assets \
  --score /absolute/path/to/project/App.score \
  --output /absolute/path/to/packages \
  --name "My Installation" \
  --app-organization "My Studio" \
  --app-domain "example.org" \
  --app-identifier "org.example.installation" \
  --app-version "1.0.0" \
  --platform linux-x86_64
```

`--qml`, `--output` and `--name` (also called `--app-name`) are required. Omit `--score` for a UI-only application. Use absolute paths: platform scripts change their working directory.

Repeat `--qml` for additional files or directories, listing the main QML file first. Directory contents are merged into the package's `qml` directory. With `--score`, the scripts copy the score's sibling files and directories, except hidden files. Keep the project in its own folder and collect its media as described in [Project files]({{ site.baseurl }}/reference/project-files.html).

## Base distribution and targets

`--release TAG` selects a GitHub release (default: `continuous`). `--local-installer PATH` uses a local distribution instead.

| `--platform` | Base distribution | Output and host requirements |
|---|---|---|
| `linux-x86_64`, `linux-aarch64` | AppImage | AppImage and launcher shell script. The script executes the input AppImage and architecture-specific packaging tools: use a compatible Linux host. |
| `macos-intel`, `macos-arm` | `.app` or `.dmg` | `.app` bundle and DMG; requires macOS tools including `hdiutil` and `PlistBuddy`. |
| `windows`, `windows-arm64` | Windows installer `.exe` | ZIP containing the application and native launcher. Requires Bash, `7z`/`7za`, a Windows-targeting C++ compiler and a ZIP tool. |
| `wasm` | WASM release ZIP, or local build directory/ZIP | Static web directory and ZIP, not a native executable. |

Without `--platform`, the script detects the host. Repeat it for multiple targets when the host has the required tools. On Windows, use llvm-mingw's `clang++` or MSYS2 CLANG64 for the native launcher.

For WASM, pass a release ZIP or a local directory containing `ossia-score.js`, `ossia-score.wasm` and its accompanying files. Serve the generated `<safe-name>-wasm` directory over HTTP. See [[Building for WebAssembly]] for browser and hosting requirements.

## Startup and debugging

The native launcher starts score with `--ui` and the main QML file. A supplied score loads at startup; add `--autoplay` to start playback. Additional native command-line arguments are forwarded to score.

Launch with `--debug` to show both the custom UI and score editor (`--ui-debug`). In a browser, use `?debug`.

## Branding and icons

| Option | Purpose |
|---|---|
| `--app-organization`, `--app-domain` | Application organization and domain. |
| `--app-identifier` | Bundle identifier, especially for macOS distribution. |
| `--app-version` | Application version metadata. |
| `--app-description` | One-line description. |
| `--app-copyright` | Copyright metadata. |
| `--app-png` | Linux PNG icon. |
| `--app-appdata-xml` | Linux AppStream metadata file. |
| `--app-icns` | macOS ICNS icon. |
| `--app-ico` | Windows ICO icon. |

Native launchers set `SCORE_CUSTOM_APP_ORGANIZATION_NAME`, `SCORE_CUSTOM_APP_ORGANIZATION_DOMAIN`, `SCORE_CUSTOM_APP_APPLICATION_NAME` and `SCORE_CUSTOM_APP_APPLICATION_VERSION`. Application and organization names give the app its own settings.

On Windows, provide an ICO file to apply the icon and version resources. WASM does not use the native launcher environment or native icon metadata.

## Environment and per-OS overrides

`--app-environment /absolute/path/to/app.env` supplies environment settings to native launchers:

```bash
export MY_INSTALLATION_MODE=gallery
```

Linux and macOS source the file as Bash. Windows accepts literal assignments with an optional `export` prefix, but not shell expansion or commands.

If adjacent files exist, the orchestrator appends the matching overlay after the base file:

- `app.env.linux`
- `app.env.macos`
- `app.env.windows`

The overlay overrides the common values. End each file with a newline. WASM does not use these environment files.

## Qt resources

`--app-qrc /absolute/path/to/resources.qrc` invokes `rcc` from `PATH` and places `resources.rcc` beside the native executable, or at `/resources.rcc` in the WASM preload manifest. WASM also accepts the `RCC` environment variable.

The current scripts omit `rcc`'s binary-output flag. To supply a binary resource bundle manually, run `rcc --binary resources.qrc -o resources.rcc` and place it beside the native executable; score registers it on startup.

## Enabled add-ons

The packaged app uses the add-ons in its base distribution. To select add-ons in a source build, set `SCORE_ENABLED_ADDONS` to comma-separated directory names from `src/addons`; `SCORE_ENABLE_ADDONS` is also accepted. Leave it unset to include all discovered add-ons. Pass the resulting distribution with `--local-installer`.

## GitHub Actions

[ossia/actions](https://github.com/ossia/actions) provides:

- [`package-custom-app`](https://github.com/ossia/actions/tree/master/package-custom-app): packages a release with `app-name`, `qml-files`, optional `score-file`, `release-tag` and `platforms`.
- [`custom-score-build`](https://github.com/ossia/actions/tree/master/custom-score-build): builds score with `cmake-options` or `cmake-cache`. Pass its `artifact-id` output to the packaging action's `score-build-id` input.

For example, in a Linux job after checking out your application:

```yaml
- uses: ossia/actions/package-custom-app@master
  with:
    app-name: My Installation
    qml-files: qml
    score-file: score/app.score
    release-tag: continuous
    platforms: linux-x86_64
```

The template workflows include native and WASM packaging jobs and artifact uploads. To build WASM from source, use an `ubuntu-24.04` runner and set `target-platform: wasm` on `custom-score-build`, then `platforms: wasm` on `package-custom-app`.

## Signing and distribution

On macOS, set `MAC_CODESIGN_IDENTITY` to sign the app and DMG. Notarization also uses `MAC_NOTARIZE_TEAM_ID`, `MAC_NOTARIZE_APPLE_ID` and `MAC_NOTARIZE_PASSWORD`. In GitHub Actions, supply the corresponding certificate and notarization inputs from repository secrets.

Windows packaging produces a ZIP without Authenticode signing; Linux produces an AppImage.
