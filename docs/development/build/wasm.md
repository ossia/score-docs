---
layout: default
title: Building for WebAssembly
description: "Building and serving the browser target of ossia score"
parent: Building from source
grand_parent: Development
permalink: /development/build/wasm.html
---

# Building for WebAssembly

The browser target compiles score and its supported plug-ins with Emscripten and Qt for WebAssembly. It is not a remote desktop client and cannot load native desktop plug-in binaries. This page follows the current development build; consult the scripts at the revision you build rather than mixing SDKs from different releases.

For application use and platform restrictions, see [Using score in the browser]({{ site.baseurl }}/quick-start/using-score-in-the-browser.html).

## Reproduce the CI environment

The reference pipeline is [`.github/workflows/wasm.yaml`](https://github.com/ossia/score/blob/master/.github/workflows/wasm.yaml). It builds inside **Ubuntu 24.04**, matching the SDK's host-tool dependencies. Start from a recursive source checkout and run the dependency/build scripts from its root in a disposable matching environment:

```sh
./ci/wasm.deps.sh
./ci/wasm.build.sh
```

These are CI provisioning scripts, not an isolated package-manager installation: they install system packages, populate `/opt/ossia-sdk-wasm`, use `/build`, and replace the selected library checkout. Read them before running on a development machine.

At the documented revision, [`ci/wasm.deps.sh`](https://github.com/ossia/score/blob/master/ci/wasm.deps.sh) fetches **sdk42**, with Qt 6.12, emsdk 5.0.5 and FFmpeg 8.1. It also downloads the user library and prepares add-on sources. [`ci/wasm.build.sh`](https://github.com/ossia/score/blob/master/ci/wasm.build.sh) sources the SDK's `emsdk_env.sh` and configures with its `qt-wasm/bin/qt-cmake`, Ninja, C++23, a release unity build and precompiled headers disabled.

The target uses WebAssembly SIMD, pthreads, Wasm exceptions and **JSPI**, not the old Asyncify configuration. The application requests a 16-thread pthread pool and an 8 MiB main stack. The build script enables memory growth with a 2 GiB maximum; media and process graphs still have to fit the browser's available memory. Audio additionally links Emscripten AudioWorklet and Wasm Worker support.

Configuration entry points:

| Setting | Purpose |
|---|---|
| `SCORE_EXTRA_CMAKE_ARGS` | Additional CMake arguments passed by the build script. |
| `SCORE_CMAKE_CACHE` | Initial CMake cache file, supplied with `-C`. |
| `SCORE_LIBRARY_DIR` | Library source directory used by the CI scripts; defaults to `$HOME/score-user-library`. The dependency script replaces this checkout. |
| `SCORE_WASM_PRELOAD_LIBRARY` | CMake directory to embed as the default library. The build script supplies it when `SCORE_LIBRARY_DIR` exists. |

The library is preloaded at `/home/web_user/Documents/ossia/score/packages/default` in the application's virtual filesystem. It becomes part of the `.data` payload, not a directory that the browser reads from the user's disk. Rebuild/repackage to update that snapshot. Embedding presets does not make their unsupported native dependencies available.

## Add-ons and feature availability

The WASM branch of [`ci/common.deps.sh`](https://github.com/ossia/score/blob/master/ci/common.deps.sh) prepares sources for the network, Synthimi, JK, GBAP, LTC, Granola, Bendage, Airwindows, computer-vision, ONNX, Puara and Deuterium add-ons. This is the source selection, **not a guarantee that every process in every add-on compiles or runs in the browser**: each add-on's CMake checks and dependencies determine what is registered in the resulting application. Verify the process/device library in the actual bundle before publishing a project that relies on an add-on.

The same script excludes the desktop-only source group from WASM, including BLE, Context Free, HDF5, LED, Libav filter graphs, LSL, NDI, OpenZen, SpatGRIS, Ultraleap, system information, tracking protocols, Video I/O, Carto TCP and Orbbec. Native VST/LV2 binaries and arbitrary desktop hardware SDKs cannot simply be copied into the web bundle.

JavaScript **process execution** is explicitly disabled in the web target: the QML execution engine cannot safely use its usual Qt thread synchronization inside an AudioWorklet. This restriction is distinct from the JavaScript loader and does not imply that every QML-based application UI is disabled. Browser transport availability must also be checked separately from desktop network protocol registration: native UDP/TCP sockets are not generally available to web pages.

## Bundle and deployment layout

[`ci/wasm.deploy.sh`](https://github.com/ossia/score/blob/master/ci/wasm.deploy.sh) assembles `site/` from `/build` and [`cmake/Deployment/WASM`](https://github.com/ossia/score/tree/master/cmake/Deployment/WASM). It initializes a deployment Git repository, so use it as a packaging reference rather than a generic local server command.

Keep the generated files together:

- `ossia-score.js` and **all generated JavaScript helpers**, including worker/worklet files;
- the application binary, either `ossia-score.wasm` or the deployed `ossia-score.wasm.gz`;
- `ossia-score.data` when generated, containing Qt resources and the preloaded library;
- the supplied `index.html`, `qtloader.js`, JSPI check, URL importer, gzip loader and cross-origin-isolation service worker.

The published website uses a gzipped binary to avoid the hosting repository's per-file size limit. `score-wasm-gz.js` uses `DecompressionStream` and streaming WebAssembly compilation; it also handles a server that already decoded `Content-Encoding: gzip`. A deployment containing only the compressed binary therefore needs this browser API. When the compressed resource is absent, the loader falls back to the normal plain `.wasm` path.

CI also publishes a **WASM ZIP release asset** (`ossia.score-<version>-wasm.zip`, or `ossia.score-master-wasm.zip` for development builds). Unlike the website repository, this archive carries the plain `.wasm` binary. Keep its accompanying JS and data files from the same build. See [[Custom applications]] for using `tools/create-app-wasm.sh` to package a custom browser application.

## Serve with browser isolation

Serve over **HTTPS**, or a trustworthy localhost development origin; do not use `file://`. The threaded target needs cross-origin isolation and shared memory. A server-controlled deployment can set:

```text
Cross-Origin-Opener-Policy: same-origin
Cross-Origin-Embedder-Policy: require-corp
```

The supplied page also loads `coi-serviceworker.min.js`, which can establish isolation on static hosting by intercepting requests and adding headers. Service workers require a secure context and may trigger an initial reload. Keep the worker in the application's deployment scope. Cross-origin subresources must satisfy the chosen isolation policy; co-hosting the application assets avoids many such failures. Serve a plain `.wasm` resource as `application/wasm`.

At startup, the page checks JSPI before calling Qt's `qtLoad()`. Its entry function is `score_entry` (derived from the CMake target name), not a function guessed from `ossia-score.js`. The loader installs URL-imported files during `preRun` and passes the document path to the application as a command-line argument.

The `?open=` importer accepts only same-origin HTTP(S) documents and ordinary stored/deflated ZIP projects. It rejects ZIP64 and unsafe archive paths and bounds downloaded/extracted data. This is an intentional trust boundary; enabling CORS on another host does not bypass it. Prefer project-relative media references and ship media with the document.

## Diagnose a deployed bundle

Check the browser's developer console and network panel when the page does not start:

1. Confirm `WebAssembly.Suspending` and `WebAssembly.promising` are functions. The supplied page explains a missing JSPI capability.
2. Confirm `crossOriginIsolated` is true and shared memory is available; inspect isolation headers and service-worker scope if not.
3. Check that JS helpers, the selected binary and `.data` all load from the same deployment. A cached loader paired with a different binary is not a valid bundle.
4. If audio or camera input fails, check secure-context status, user interaction and site permissions. Camera support additionally requires `MediaStreamTrackProcessor` on the thread used by the implementation.
5. For missing media after a reload, remember that imported files are in MEMFS. Local-storage preferences and crash recovery do not persist the imported filesystem.

Validate the actual project on the browser/device used for deployment. A successful C++ build establishes neither desktop feature parity nor uninterrupted background playback.
