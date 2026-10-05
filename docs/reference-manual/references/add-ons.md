---
layout: default

title: Add-ons
description: "Optional extensions, native dependencies and availability"

parent: Reference

permalink: /reference/add-ons.html
---

# Add-ons

Add-ons extend score with processes, devices or file formats. They are not all
included in every downloadable build, and a source repository is not proof that an
extension is enabled. This overview describes score's optional add-ons.

Start with the [package manager]({{ site.baseurl }}/package-manager.html) for content,
runtime source packages, SDKs and support-library installation. After installation,
look for processes in the [Process library]({{ site.baseurl }}/panels/library.html)
and protocol extensions in the device-creation dialog. A dependency failure can mean
that an extension registers no user-visible entry at all.

## Extension families

| Extension | What it provides | Requirements and availability |
|---|---|---|
| [NDI](https://github.com/ossia/score-addon-ndi) | NDI input and output **devices** for network video. These are not generic process names. | Requires the graphics and media plug-ins and a loadable NDI-compatible native library. The add-on registers neither device if that library is unavailable. Excluded from the browser/WebAssembly build. |
| [Computer vision (CV)](https://github.com/ossia/score-addon-cv) | Classical image filtering and analysis, blob/contour processing, feature and motion analysis. Combines GPU shaders with CPU algorithms. | The current add-on is **OpenCV-free**. GPU shader/compute operations require the corresponding graphics capabilities. Neural-network models belong to ONNX, not this package. Available objects depend on the add-on build. |
| [ONNX](https://github.com/ossia/score-addon-onnx) | Model-driven inference, including image detection, pose, depth and related machine-learning workflows. | Requires ONNX Runtime and a model compatible with the selected process. Installing model data alone does not install the inference process. GPU acceleration depends on an available execution provider, driver and runtime; do not assume CUDA support on every machine. Tokenizer-dependent language/vision-language objects are separately build-configurable and are not enabled by that option in WebAssembly. |
| [Tracking protocols](https://github.com/ossia/score-addon-trackingprotocols) | Source implementations for TUIO, PSN, RTTrP, OpenTrackIO and optional OpenXR devices. | **Disabled:** its CMake file returns before building the add-on. Do not expect these devices merely because the sources are present. OpenXR has an additional dependency even when the add-on is enabled. |
| [System information](https://github.com/ossia/score-addon-sysinfo) | A device exposing machine information and live readings such as CPU load, memory, disk space and network throughput. | Native Linux, macOS and Windows support; not WebAssembly. Unsupported readings can be zero or empty rather than absent. NVIDIA-specific readings depend on the installed driver and runtime NVML availability. Most addresses are read-only; `/rate` controls the refresh interval. |
| [CartoTCP](https://github.com/sat-mtl/carto-tcp-avendish/tree/update-avendish-packaging) | Receives XYZ point-cloud data using Carto's TCP protocol. | A SAT-maintained external add-on referenced by score's build dependency script, not an ossia-owned package or a general TCP device. It needs a compatible sender and a build that includes it. Its upstream README only claims testing as a TouchDesigner POP; score operation is not asserted tested here. |

## NDI runtime licensing

The NDI add-on's upstream documentation recommends the
[libndi implementation](https://code.videolan.org/jbk/libndi). It warns that the
proprietary NDI SDK's licence is incompatible with redistributing its DLL together
with GPLv3 score. Do not assume an NDI runtime ships with score; obtain a suitable
runtime separately and follow its licence and installation instructions.

## Diagnosing a missing extension

1. Check whether the running build includes the add-on and the host features it uses.
2. For runtime source packages, check that the matching SDK and JIT compiler are
   available and inspect the message console for compilation failures.
3. For native dependencies, verify the OS and architecture match, install required
   support libraries, and restart score. A library rescan does not reload native code.
4. For model-based processes, select the model required by that process; an arbitrary
   `.onnx` file is not necessarily interchangeable with its expected model.
5. Check the extension's own documentation for required devices, network senders,
   drivers and execution providers. Presence in the package catalogue does not remove
   these requirements.

The source references above describe the extensions themselves. The package catalogue
and your installed build determine which can actually be installed and used.
