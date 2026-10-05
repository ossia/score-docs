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

Start with the [upstream introduction](https://celtera.github.io/avendish/getting_started/hello_world.html) and [examples](https://github.com/celtera/avendish/tree/main/examples). Use the Avendish revision bundled with your score version.

## Create an add-on

Use the [score Avendish template](https://github.com/ossia-templates/score-avnd-simple-template/) and follow its README to initialize names and UUIDs. Keep those UUIDs stable after distributing the plug-in: documents use them to identify processes. Set the name, description and other package metadata in `addon.json`.

![Github template creation]({{ site.img }}/development/plugins/avendish/template.png "Github template")

The template's [SDK workflow](https://github.com/ossia-templates/score-avnd-simple-template/blob/main/.github/workflows/builds-sdk.yaml) builds the platform packages. Install the generated package and manifest in the Packages directory configured in score, usually `Documents/ossia/score/packages/<your-addon>`.

## Build against a matching SDK

- `OSSIA_SDK` is the compiler and dependency SDK used to build score itself, available from [ossia/sdk](https://github.com/ossia/sdk/releases).
- The score SDK supplies headers for run-time JIT add-ons. For an external CMake build, `SCORE_SDK` points to its exported `usr` directory, containing `include` and `lib/cmake/score`. Obtain it from the matching application build or the package manager's SDK entry.

![Score SDK]({{ site.img }}/development/plugins/avendish/settings.png "Score SDK download")

See [Release build]({{ site.baseurl }}/development/build/release.html#matching-the-official-sdk) for dependency SDK setup. On Linux and Windows, put its `llvm/bin` first on `PATH`; on macOS, use Xcode. Official Windows builds use llvm-mingw. MSYS2 CLANG64 is the development alternative; MSVC is only needed for exceptional Qt WebEngine builds.

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

Restart score after rebuilding a binary. On Windows, close score before replacing its DLL. Match the score build, architecture and compiler ABI, and keep the generated `localaddon.json` with the installed files.

For your own score checkout, use the template's developer-build configuration. [ScoreExternalAddon.cmake](https://github.com/ossia/score/blob/master/cmake/ScoreExternalAddon.cmake) selects the SDK or developer build mode.

## Compile at run time

Desktop builds with the JIT plug-in compile source add-ons at run time on Linux, macOS and Windows (llvm-mingw). Install the matching score SDK through the package manager.

Place a source package with `"kind": "addon"` in its `addon.json` in the configured Packages directory. Use an add-on template supported by the run-time compiler, and restart score after source changes.

For a one-file compilation check:

```bash
ossia-score --no-restore --compile-node /absolute/path/to/MyProcessor.hpp
```

`--compile-node` accepts an Avendish object in a `.hpp` or `.cpp` file. Declare its class or struct and a UUID with `halp_meta(uuid, "...")`, using the UUID generated for your processor.

For a complete source add-on:

```bash
ossia-score --no-restore --compile-addon /absolute/path/to/your-addon
```

These commands compile and register the processor, then exit, reporting compiler errors in the log. They are provided by the JIT plug-in and do not appear in the core `--help` output. Standalone headers in a library `Nodes` directory are not discovered automatically.

## Ports, scheduling and layouts

The following interfaces map to score's ports and controls:

| Need | Interface and score behavior |
|---|---|
| Variable number of ports | `halp::dynamic_port<T>` represents repeated ports of one type. Read the actual instances through its `ports` collection; do not treat it as one list-valued cable. See the [dynamic-port example](https://github.com/celtera/avendish/blob/main/examples/Tests/TestDynamicPort.hpp). |
| Time-dependent processing | Use the appropriate tick information for frames, musical time or logical time rather than a wall-clock timer. Temporal metadata controls whether the process has timeline content; it is distinct from `single_exec` (once per execution) and `process_exec` (start/stop callbacks). See [temporality concepts](https://github.com/celtera/avendish/blob/main/include/avnd/concepts/temporality.hpp) and [playback state](https://celtera.github.io/avendish/writing_processors/audio.arguments.html). |
| Files and directories | [File ports](https://celtera.github.io/avendish/advanced/port_types.file.html) and `halp::folder_port` expose file/folder controls. `halp::folder_combobox` names a sibling folder port and optional extension filter; score populates the choices at edit/load time and refreshes them when the folder changes. Its value is the selected file name, not the folder itself. See [folder combobox](https://github.com/celtera/avendish/blob/main/include/halp/folder_combobox.hpp). |
| GPU processing | Use the [draw](https://celtera.github.io/avendish/gpu/draw.html) or [compute](https://celtera.github.io/avendish/gpu/compute.html) interfaces and the shader language supported by the selected backend. |
| Scene processing | A port member carrying `ossia::scene_spec scene` transports scene data through geometry ports. This is a score-specific extension. See [SceneConcepts.hpp](https://github.com/ossia/score/blob/master/src/plugins/score-plugin-avnd/Crousti/SceneConcepts.hpp) for dirty flags and [GpuUtils.hpp](https://github.com/ossia/score/blob/master/src/plugins/score-plugin-avnd/Crousti/GpuUtils.hpp) for transport. |
| Custom controls layout | A nested `ui` structure arranges controls using [layout-based UIs](https://celtera.github.io/avendish/advanced/ui.layout.html). In addition to boxes, grids, groups and tabs, score supports `section` (titled padded vertical group), `table` (rows under shared column titles), and `strip_detail` (summary cells selecting a detail page). See [layout.hpp](https://github.com/celtera/avendish/blob/main/include/halp/layout.hpp) and the [score binding](https://github.com/ossia/score/blob/master/src/plugins/score-plugin-avnd/Crousti/Layer.hpp). |

In score's default metadata mapping, the `temporal` tag sets `Process::ProcessFlags::SupportsTemporal`; otherwise the object gets `SupportsLasting`. A dynamic-port interface sets `DynamicPorts`. If you override `Info::flags()`, you replace that default mapping and must describe the process's capabilities yourself. Controls which change port counts are marked as changing ports by the binding. See [Metadata.hpp](https://github.com/ossia/score/blob/master/src/plugins/score-plugin-avnd/Crousti/Metadata.hpp) before overriding these flags; they describe editor/process capabilities, not a substitute for implementing timed execution.

Other hosts support different ports and layouts; see the “Supported bindings” notes in the [upstream manual](https://celtera.github.io/avendish/).

## Qt Creator workflow

Open the add-on's `CMakeLists.txt` in Qt Creator, reuse the configured build directory, and set the run executable to the matching score application. Add a CMake install step so building updates the package directory before launch.

<video controls>
    <source src="{{ site.img }}/development/plugins/avendish/addon-build.mp4" type="video/mp4">
</video>

For direct editing of a low-level graph node inside a document, see [C++ JIT]({{ site.baseurl }}/processes/cpp_jit.html); that process uses a different entry point from the Avendish object command above.
