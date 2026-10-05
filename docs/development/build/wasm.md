---
layout: default
title: Building for WebAssembly
description: "Building and serving the browser target of ossia score"
parent: Building from source
grand_parent: Development
permalink: /development/build/wasm.html
---

# Building for WebAssembly

The browser target builds score with Emscripten and Qt for WebAssembly. Only features supported by web browsers can be used in WASM builds of score.

For application use and platform restrictions, see [Using score in the browser]({{ site.baseurl }}/quick-start/using-score-in-the-browser.html).

## Reproduce the CI environment

The [CI workflow](https://github.com/ossia/score/blob/master/.github/workflows/wasm.yaml) runs on Ubuntu 24.04, matching the SDK's host tools. In an Ubuntu 24.04 container or build machine, run from a recursive source checkout:

```sh
./ci/wasm.deps.sh
./ci/wasm.build.sh
```

These scripts install system packages, extract the SDK into `/opt/ossia-sdk-wasm`, build in `/build`, and replace the user-library checkout selected by `SCORE_LIBRARY_DIR`.

[`ci/wasm.deps.sh`](https://github.com/ossia/score/blob/master/ci/wasm.deps.sh) downloads sdk42. Its [version definitions](https://github.com/ossia/sdk/blob/sdk42/common/versions.sh) select Qt's 6.12 branch, emsdk 5.0.5 and FFmpeg 9.0; the [WASM FFmpeg recipe](https://github.com/ossia/sdk/blob/sdk42/WASM/ffmpeg.sh) uses that shared FFmpeg version. The dependency script also downloads the user library and add-ons.

[`ci/wasm.build.sh`](https://github.com/ossia/score/blob/master/ci/wasm.build.sh) sources `emsdk_env.sh` and configures with `qt-wasm/bin/qt-cmake`, Ninja, C++23, a release unity build and no precompiled headers. The target uses SIMD, pthreads, Wasm exceptions and JSPI, with a 16-thread pool, an 8 MiB main stack and memory growth up to 2 GiB. Audio uses Emscripten AudioWorklet and Wasm Worker support.

Configuration entry points:

| Setting | Purpose |
|---|---|
| `SCORE_EXTRA_CMAKE_ARGS` | Additional CMake arguments passed by the build script. |
| `SCORE_CMAKE_CACHE` | Initial CMake cache file, supplied with `-C`. |
| `SCORE_LIBRARY_DIR` | Library source directory used by the CI scripts; defaults to `$HOME/score-user-library`. The dependency script replaces this checkout. |
| `SCORE_WASM_PRELOAD_LIBRARY` | CMake directory to embed as the default library. The build script supplies it when `SCORE_LIBRARY_DIR` exists. |

The library is embedded in the `.data` payload at `/home/web_user/Documents/ossia/score/packages/default` in the application's virtual filesystem. Rebuild to update it.

## Add-ons and feature availability

The WASM configuration in [`ci/common.deps.sh`](https://github.com/ossia/score/blob/master/ci/common.deps.sh) includes the network, Synthimi, JK, GBAP, LTC, Granola, Bendage, Airwindows, computer-vision, ONNX, Puara and Deuterium add-ons.

Desktop-only add-ons are excluded, including BLE, Context Free, HDF5, LED, Libav filter graphs, LSL, NDI, OpenZen, SpatGRIS, Ultraleap, system information, tracking protocols, Video I/O, Carto TCP and Orbbec. Native VST/LV2 binaries cannot run in the browser.

JavaScript processes are disabled because the QML execution engine's thread synchronization is incompatible with AudioWorklet execution. Native UDP/TCP sockets are also unavailable to web pages; use browser-supported transports such as WebSocket.

## Bundle and deployment layout

[`ci/wasm.deploy.sh`](https://github.com/ossia/score/blob/master/ci/wasm.deploy.sh) assembles `site/` from `/build` and [`cmake/Deployment/WASM`](https://github.com/ossia/score/tree/master/cmake/Deployment/WASM). It initializes a deployment Git repository, so use it as a packaging reference rather than a generic local server command.

Keep the generated files together:

- `ossia-score.js` and generated JavaScript helpers, including worker/worklet files;
- the application binary, either `ossia-score.wasm` or the deployed `ossia-score.wasm.gz`;
- `ossia-score.data` when generated, containing Qt resources and the preloaded library;
- the supplied `index.html`, `qtloader.js`, JSPI check, URL importer, gzip loader and cross-origin-isolation service worker.

The published website uses a gzipped binary to avoid the hosting repository's per-file size limit. `score-wasm-gz.js` uses `DecompressionStream` and streaming WebAssembly compilation; it also handles a server that already decoded `Content-Encoding: gzip`. A deployment containing only the compressed binary therefore needs this browser API. When the compressed resource is absent, the loader falls back to the normal plain `.wasm` path.

CI also publishes a WASM ZIP (`ossia.score-<version>-wasm.zip`, or `ossia.score-master-wasm.zip`). It contains the plain `.wasm` binary and its accompanying JavaScript and data files. See [[Custom applications]] to package a custom browser application.

## Serve with browser isolation

Serve over HTTPS or localhost, rather than `file://`. The threaded target needs cross-origin isolation and shared memory. Configure the server with:

```text
Cross-Origin-Opener-Policy: same-origin
Cross-Origin-Embedder-Policy: require-corp
```

The supplied page also loads `coi-serviceworker.min.js`, which can establish isolation on static hosting by intercepting requests and adding headers. Service workers require a secure context and may trigger an initial reload. Keep the worker in the application's deployment scope. Cross-origin subresources must satisfy the chosen isolation policy; co-hosting the application assets avoids many such failures. Serve a plain `.wasm` resource as `application/wasm`.

At startup, the page checks JSPI before calling Qt's `qtLoad()`. Its entry function is `score_entry` (derived from the CMake target name), not a function guessed from `ossia-score.js`. The loader installs URL-imported files during `preRun` and passes the document path to the application as a command-line argument.

The `?open=` importer accepts same-origin HTTP(S) documents and stored/deflated ZIP projects. ZIP64 is unsupported. Use project-relative media references and include media in the project archive.

## Diagnose a deployed bundle

Check the browser's developer console and network panel when the page does not start:

1. Confirm `WebAssembly.Suspending` and `WebAssembly.promising` are functions. The supplied page explains a missing JSPI capability.
2. Confirm `crossOriginIsolated` is true and shared memory is available; inspect isolation headers and service-worker scope if not.
3. Check that JS helpers, the selected binary and `.data` all load from the same deployment. A cached loader paired with a different binary is not a valid bundle.
4. If audio or camera input fails, check secure-context status, user interaction and site permissions. Camera support additionally requires `MediaStreamTrackProcessor` on the thread used by the implementation.
5. For missing media after a reload, remember that imported files are in MEMFS. Local-storage preferences and crash recovery do not persist the imported filesystem.
