---
layout: default

title: Plug-ins with Avendish
description: "Writing plug-ins with the Avendish API"

parent: "Plug-ins"
grand_parent: Development

permalink: /development/plugins/plugins-with-avendish.html
---

# Writing a processor with Avendish

[Avendish](https://celtera.github.io/avendish/) describes a media processor through a C++ type: members declare its inputs, outputs and controls, and a processing function performs the work. The optional `halp` helpers reduce boilerplate. Audio, MIDI, values, CPU images, GPU resources and geometry have different port contracts; choosing the right one lets score supply the corresponding cables and controls.

Start with the [upstream introduction](https://celtera.github.io/avendish/getting_started/hello_world.html) and [examples](https://github.com/celtera/avendish/tree/main/examples). Use the Avendish revision bundled with the score version you target. New interfaces in a development build need not exist in the latest released SDK.

## Create an add-on

Use the [score Avendish template](https://github.com/ossia-templates/score-avnd-simple-template/) and follow its README to initialize names and UUIDs. Keep those UUIDs stable after distributing the plug-in: documents use them to identify processes. Set the name, description and other package metadata in `addon.json`.

![Github template creation]({{ site.img }}/development/plugins/avendish/template.png "Github template")

The template's [SDK workflow](https://github.com/ossia-templates/score-avnd-simple-template/blob/main/.github/workflows/builds-sdk.yaml) is the reference for supported build jobs and artifacts. A binary for one operating system or architecture cannot be loaded on another. Install the generated package, including its manifest, in the **Packages** directory configured in score; the usual location is `Documents/ossia/score/packages/<your-addon>`.

## Build against a matching SDK

Two SDK paths serve different purposes:

- `OSSIA_SDK` points to the compiler and third-party dependency SDK used to build score.
- `SCORE_SDK` points to the exported score SDK's **`usr` directory**, containing `include` and `lib/cmake/score`. Obtain the platform/architecture SDK from the same release or development build as the application, or through the package manager's SDK entry.

![Score SDK]({{ site.img }}/development/plugins/avendish/settings.png "Score SDK download")

See [Release build]({{ site.baseurl }}/development/build/release.html#matching-the-official-sdk) for selecting the dependency SDK. The fetch script has a pinned default, not automatic latest-version selection. On Linux and Windows, use the SDK's compiler and put its `llvm/bin` first on `PATH`; Windows absolute compiler paths include `.exe`. On macOS use the Xcode toolchain expected by the SDK. Do not mix unrelated Qt/LLVM/standard-library headers with the exported SDK.

For example, after setting `SCORE_SDK` and `OSSIA_SDK` to the correct directories and selecting that compiler:

```bash
cmake -S /path/to/your-addon -B addon-build -GNinja \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_MODULE_PATH="$SCORE_SDK/lib/cmake/score" \
  -DSCORE_SDK="$SCORE_SDK" \
  -DOSSIA_SDK="$OSSIA_SDK" \
  -DCMAKE_INSTALL_PREFIX=/path/to/Documents/ossia/score/packages/your-addon
cmake --build addon-build --parallel
cmake --install addon-build
```

Restart score to load a rebuilt binary. On Windows, close score **before** replacing a loaded DLL. SDK compatibility includes the score build, architecture and compiler ABI, not just a similar-looking version number. The generated `localaddon.json` records the loadable binary and architecture; keep it with the installed files.

For development against your own score checkout, follow the template's developer-build configuration instead of combining a locally changed application with unrelated released headers. [ScoreExternalAddon.cmake](https://github.com/ossia/score/blob/master/cmake/ScoreExternalAddon.cmake) selects the supported build modes.

## Compile at run time

Current desktop development builds with the JIT plug-in support run-time compilation of source add-ons, including the Windows LLVM/MinGW path. This is separate from building score's own core plug-ins as shared libraries. It needs the compatible score headers/toolchain support; it is not a way to load arbitrary MSVC binaries into a MinGW application.

A source package in the configured Packages directory is recognized by `addon.json` with `"kind": "addon"`. Use a supported template: the run-time compiler understands selected add-on CMake declarations, not every possible CMake project. Restart after source changes rather than relying on automatic hot reload.

For a one-file compilation check:

```bash
ossia-score --no-restore --compile-node /absolute/path/to/MyProcessor.hpp
```

`--compile-node` accepts `.hpp` or `.cpp` and now wraps an **Avendish object**, registering its generated process factories. The source must identify its enclosing class or struct and contain a UUID declaration recognized by the loader, normally `halp_meta(uuid, "…")`. Use the template's real generated UUID, not the placeholder shown here. This is not an arbitrary C++ program with `main()`.

For a complete source add-on:

```bash
ossia-score --no-restore --compile-addon /absolute/path/to/your-addon
```

These developer commands compile/register and then exit; they do not install a reusable binary package. Compiler failures are reported in the log. The commands are parsed by the JIT plug-in and are not listed in the core `--help` output. Merely putting standalone headers in a library `Nodes` directory does **not** enable automatic discovery in the current implementation.

## Ports, scheduling and layouts

The links below are the API reference; the table explains how the interfaces map to score rather than duplicating their implementations.

| Need | Interface and score behavior |
|---|---|
| Variable number of ports | `halp::dynamic_port<T>` represents repeated ports of one type. Read the actual instances through its `ports` collection; do not treat it as one list-valued cable. See the [dynamic-port example](https://github.com/celtera/avendish/blob/main/examples/Tests/TestDynamicPort.hpp). |
| Time-dependent processing | Use the appropriate tick information for frames, musical time or logical time rather than a wall-clock timer. Temporal metadata controls whether the process has timeline content; it is distinct from `single_exec` (once per execution) and `process_exec` (start/stop callbacks). See [temporality concepts](https://github.com/celtera/avendish/blob/main/include/avnd/concepts/temporality.hpp) and [playback state](https://celtera.github.io/avendish/writing_processors/audio.arguments.html). |
| Files and directories | [File ports](https://celtera.github.io/avendish/advanced/port_types.file.html) and `halp::folder_port` expose file/folder controls. `halp::folder_combobox` names a sibling folder port and optional extension filter; score populates the choices at edit/load time and refreshes them when the folder changes. Its value is the selected file name, not the folder itself. See [folder combobox](https://github.com/celtera/avendish/blob/main/include/halp/folder_combobox.hpp). |
| GPU processing | Use [draw](https://celtera.github.io/avendish/gpu/draw.html) or [compute](https://celtera.github.io/avendish/gpu/compute.html) interfaces and their resource/layout contracts. Backend capabilities still apply; a C++ wrapper does not make every shader portable. |
| Scene processing | The score binding recognizes a port member carrying `ossia::scene_spec scene` and transports it through geometry ports. This is currently a **score-specific extension**, not a portable upstream Avendish scene API. See [SceneConcepts.hpp](https://github.com/ossia/score/blob/master/src/plugins/score-plugin-avnd/Crousti/SceneConcepts.hpp) for scene dirty flags and [GpuUtils.hpp](https://github.com/ossia/score/blob/master/src/plugins/score-plugin-avnd/Crousti/GpuUtils.hpp) for transport. |
| Custom controls layout | A nested `ui` structure arranges controls using [layout-based UIs](https://celtera.github.io/avendish/advanced/ui.layout.html). In addition to boxes, grids, groups and tabs, current score supports `section` (titled padded vertical group), `table` (rows under shared column titles), and `strip_detail` (summary cells selecting a detail page). See [layout.hpp](https://github.com/celtera/avendish/blob/main/include/halp/layout.hpp) and the [score binding](https://github.com/ossia/score/blob/master/src/plugins/score-plugin-avnd/Crousti/Layer.hpp). |

In score's default metadata mapping, the `temporal` tag sets `Process::ProcessFlags::SupportsTemporal`; otherwise the object gets `SupportsLasting`. A dynamic-port interface sets `DynamicPorts`. If you override `Info::flags()`, you replace that default mapping and must describe the process's capabilities yourself. Controls which change port counts are marked as changing ports by the binding. See [Metadata.hpp](https://github.com/ossia/score/blob/master/src/plugins/score-plugin-avnd/Crousti/Metadata.hpp) before overriding these flags; they describe editor/process capabilities, not a substitute for implementing timed execution.

Avendish can target other hosts, but the supported port and UI features differ between bindings. Consult the “Supported bindings” notes in the [upstream manual](https://celtera.github.io/avendish/) rather than assuming a score-specific scene or layout works everywhere.

## Qt Creator workflow

Open the add-on's `CMakeLists.txt` in Qt Creator, reuse the configured build directory, and set the run executable to the matching score application. Add a **CMake install step** to the deployment configuration so a build updates the package directory before launch.

<video controls>
    <source src="{{ site.img }}/development/plugins/avendish/addon-build.mp4" type="video/mp4">
</video>

For direct editing of a low-level graph node inside a document, see [C++ JIT]({{ site.baseurl }}/processes/cpp_jit.html); that process uses a different entry point from the Avendish object command above.
