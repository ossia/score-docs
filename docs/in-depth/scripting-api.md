---
layout: default

title: Scripting API
description: "JavaScript and QML editor API reference"

parent: In depth
has_children: true

permalink: /in-depth/scripting-api.html
---

# Scripting API

These pages describe the current development API. Older released builds may not provide every function. The console and editor scripts operate on the **current document**; a JavaScript process runs in a separate execution context, not in the console's global scope.

| Object / module | Purpose |
|---|---|
| `Score` in the console | Document editing, transport, devices and undo. In QML, `import Score as Score` exposes the editor singleton as `Score.Editor`. |
| `Controls`, `Triggers`, `Conditions` from `import Score` | Named, published controls and scenario conditions/triggers. The console exposes the same namespaces as `Score.Controls`, `Score.Triggers`, `Score.Conditions`. |
| `Device` | Live device values. Available in the console and execution scripts; Mapper devices provide additional tree-editing operations. |
| `Util` | Files, paths, time conversions and other helpers. Native dialogs belong on the GUI thread, not in a process's `tick`. |
| `View` | Editor navigation and captures; requires a GUI. |
| `Protocols` | Raw transport connections and HTTP requests in the console and Mapper scripts. |
| `System`, `Library` | System queries and package operations, subject to the installed build. |

## Score object

[Document, process and cable editing]({{ site.baseurl }}/in-depth/scripting-api/score.html) covers lookup, creation, controls, triggers, durations, presets, metadata and undo. Prefer the command-based `Score` functions for edits that should be undoable: assigning a QObject property directly does not automatically create an undo command.

## Functions operating on devices

[Devices and discovery]({{ site.baseurl }}/in-depth/scripting-api/devices.html) covers protocol enumeration, saved device settings and live values. [QML protocols]({{ site.baseurl }}/in-depth/qml-protocols.html) covers raw sockets, framing, encoding, HTTP and OAuth.

## Util object

[Files, time and utilities]({{ site.baseurl }}/in-depth/scripting-api/utilities.html) documents file operations, asynchronous pickers, environment variables and time units.

## UI

[View and interface automation]({{ site.baseurl }}/in-depth/scripting-api/view.html) documents captures, selection, prompts and process editor placement. See [Custom UI]({{ site.baseurl }}/custom-ui.html) for QML interfaces, imported forms and texture previews.

## Execution scripts

The [Javascript process]({{ site.baseurl }}/processes/javascript.html) reference describes ports, `tick`, execution state and GPU graphics. Editor APIs are not a real-time execution API: do not change the document or open dialogs from an audio-thread callback.

## Source reference

The authoritative declarations are [`EditContext.hpp`](https://github.com/ossia/score/blob/master/src/plugins/score-plugin-js/JS/Qml/EditContext.hpp), [`Utils.hpp`](https://github.com/ossia/score/blob/master/src/plugins/score-plugin-js/JS/Qml/Utils.hpp) and [`ViewContext.hpp`](https://github.com/ossia/score/blob/master/src/plugins/score-plugin-js/JS/Qml/ViewContext.hpp). Only APIs registered with the installed build are available; C++ implementation classes are not themselves JavaScript processes.
