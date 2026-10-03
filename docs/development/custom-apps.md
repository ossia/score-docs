---
layout: default
title: Custom applications
description: "Package a QML interface and score as a branded application"
parent: Development
permalink: /development/custom-apps.html
---

# Custom applications

The current development checkout includes `tools/create-app.sh`, which repackages an existing score distribution with your QML interface, optional score and assets. It does not compile score or make unavailable processes work on a different platform. Use a base release or local build that contains the features your project needs.

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

The paths above stand for your own files; omit `--score` for a UI-only application. `--name` and `--app-name` are aliases, not two separate required settings. `--qml`, `--output` and a name are required. Prefer absolute paths for optional resources and environment files too: platform scripts change their working directory.

Repeat `--qml` to include additional files or directory contents. Pass the main `.qml` file explicitly first to avoid depending on directory search order. Directory contents are merged into the package's `qml` directory, not wrapped in their source folder; avoid colliding names.

With `--score`, the scripts also copy the score's sibling directory contents. Use a dedicated project folder, not a home directory or a folder containing credentials, unrelated projects or the output packages. The wildcard copy of score siblings does not include hidden files. Prepare media with [Project files]({{ site.baseurl }}/reference/project-files.html): external absolute paths are not made portable simply by packaging the score.

## Base distribution and targets

`--release TAG` selects an official GitHub release; the default is `continuous`. `--local-installer PATH` uses a local distribution instead and takes precedence over `--release`. There is no source-build step in this command.

| `--platform` | Base distribution | Output and host requirements |
|---|---|---|
| `linux-x86_64`, `linux-aarch64` | AppImage | AppImage and launcher shell script. The script executes the input AppImage and architecture-specific packaging tools: use a compatible Linux host. |
| `macos-intel`, `macos-arm` | `.app` or `.dmg` | `.app` bundle and DMG; requires macOS tools including `hdiutil` and `PlistBuddy`. |
| `windows`, `windows-arm64` | Windows installer `.exe` | ZIP containing the application and native launcher. Requires Bash, `7z`/`7za`, a Windows-targeting C++ compiler and a ZIP tool. |
| `wasm` | WASM release ZIP, or local build directory/ZIP | Static web directory and ZIP, not a native executable. |

Repeat `--platform` for multiple targets only when the host has the required tooling; the flag is not a universal cross-compiler. Without it, the script detects the current platform. Downloaded distributions and packaging tools require network access. The Windows launcher uses `clang++`, then `CXX`, then `g++`; despite a fallback message, absence of a compiler ends packaging rather than producing a batch launcher.

For WASM, a local build must provide `ossia-score.js` and `ossia-score.wasm` (and associated data when used). The generated directory is named `<safe-name>-wasm` and must be served over HTTP, not opened as a local HTML file. Consult [Using score in the browser]({{ site.baseurl }}/quick-start/using-score-in-the-browser.html) for browser capabilities and [[Building for WebAssembly]] for build and hosting requirements.

## Startup and debugging

The native launcher runs score with `--ui` and your main QML file. A supplied score loads on startup, but does **not** play automatically unless you add `--autoplay` when packaging. Additional native application arguments are forwarded to score.

Launch the generated native application with `--debug` to use `--ui-debug`: both your custom UI and the score editor are shown. The generated browser page uses the `?debug` URL parameter instead. This is useful for diagnosing device setup, routing and project loading without changing the normal presentation.

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

The native launchers set `SCORE_CUSTOM_APP_ORGANIZATION_NAME`, `SCORE_CUSTOM_APP_ORGANIZATION_DOMAIN`, `SCORE_CUSTOM_APP_APPLICATION_NAME` and `SCORE_CUSTOM_APP_APPLICATION_VERSION`. Application and organization names also distinguish the app's settings from a normal score installation; do not assume it inherits your editor's library configuration.

On Windows the icon/version resource editing block runs when the ICO file exists, so supply a valid ICO when relying on that metadata. Branding options are platform-specific: the WASM wrapper does not apply the native launcher environment or all native icon/metadata settings.

## Environment and per-OS overrides

`--app-environment /absolute/path/to/app.env` supplies startup environment settings for native launchers. Keep the portable subset to literal assignments, for example:

```bash
export MY_INSTALLATION_MODE=gallery
```

Linux and macOS append the file to a Bash launcher. Windows parses assignments, accepts the optional `export` prefix and does not execute shell commands or conditionals. Avoid shell expansion or executable shell syntax in a shared file.

If adjacent files exist, the orchestrator appends the matching overlay after the base file:

- `app.env.linux`
- `app.env.macos`
- `app.env.windows`

Later assignments can override common values, useful for a graphics backend supported only on one OS. End each file with a newline so concatenation does not join two assignments. There is no WASM overlay, and the current WASM packager does not consume `--app-environment`.

## Qt resources

`--app-qrc /absolute/path/to/resources.qrc` invokes Qt's `rcc` to generate a file named `resources.rcc`. Native scripts place it beside the real score executable, where score attempts to register it at startup. The WASM packager includes it in its preload manifest at `/resources.rcc`.

Provide a compatible `rcc` in `PATH`; the WASM script additionally accepts the `RCC` environment variable and warns and skips compilation when that tool is missing. Resource names come from your QRC aliases and prefixes. This is separate from ordinary score media collection and does not automatically replace absolute media references with resource URLs.

The current scripts invoke `rcc` without an explicit binary-output flag. Do not assume that merely finding a file named `resources.rcc` proves it is a valid binary resource bundle: verify its format and resource loading with the Qt toolchain used for your distribution. A precompiled binary bundle beside the executable can also be registered by score's startup resource loader.

## Enabled add-ons

There is no `create-app.sh` switch that compiles or enables add-ons. The packaged application's available processes depend on its base distribution and installed compatible add-ons.

For a source build, the CMake setting `SCORE_ENABLED_ADDONS` selects add-on directory names from `src/addons`; comma-separated values are accepted. `SCORE_ENABLE_ADDONS` is accepted as an input alias. An unset selection permits all discovered add-ons, subject to other build exclusions. This is a **build-time** selection, not an environment variable in `app.env`. Prepare and verify that distribution first, then pass it through `--local-installer`. See [Building from source]({{ site.baseurl }}/development/build-from-source.html).

## Signing and distribution

On macOS, set `MAC_CODESIGN_IDENTITY` in the packaging shell to request signing of the bundle and DMG. Optional notarization uses all three of `MAC_NOTARIZE_TEAM_ID`, `MAC_NOTARIZE_APPLE_ID` and `MAC_NOTARIZE_PASSWORD`, with Apple's `notarytool`. These are packaging credentials, not application runtime settings; keep them out of `app.env` and the score assets directory. Signing failures can be reported as warnings, so inspect the result rather than treating package creation as proof of a valid signature.

The Windows script produces a ZIP, not a signed installer, and has no Authenticode signing option. Linux produces an AppImage. Any additional installer creation, signing, licence compliance and target-machine acceptance checks remain part of your distribution workflow. Test the packaged application on each intended OS with its own library, plug-ins, audio devices and media paths; packaging success alone does not establish that the score plays correctly.
