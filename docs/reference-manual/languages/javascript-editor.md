---
layout: default

title: JavaScript editor API
description: "JavaScript and QML editor API reference"

parent: Languages

grand_parent: Reference
permalink: /reference/languages/javascript-editor.html
---

<a id="scripting-api"></a>

# JavaScript editor API

For core language syntax and execution contexts, see [JavaScript and QML]({{ site.baseurl }}/reference/languages/javascript.html).

The console and editor scripts operate on the current document; a JavaScript process runs in a separate execution context.

| Object / module | Purpose |
|---|---|
| `Score` in the console | Document editing, transport, devices and undo. In QML, `import Score as Score` exposes the editor singleton as `Score.Editor`. |
| `Controls`, `Triggers`, `Conditions` from `import Score` | Named, published controls and scenario conditions/triggers. The console exposes the same namespaces as `Score.Controls`, `Score.Triggers`, `Score.Conditions`. |
| `Device` | Live device values. Available in the console and execution scripts; Mapper devices provide additional tree-editing operations. |
| `Util` | Files, paths, time conversions and other helpers. Native dialogs belong on the GUI thread, not in a process's `tick`. |
| `View` | Editor navigation and captures; requires a GUI. |
| `Protocols` | Raw transport connections and HTTP requests in the console and Mapper scripts. |
| `System`, `Library` | System queries and package operations, subject to the installed build. |

## Examples

[JavaScript editor examples]({{ site.baseurl }}/reference/languages/javascript/examples.html) walks through document editing, ports, triggers and conditions, devices, files and network connections.

## Score object

[Document, process and cable editing]({{ site.baseurl }}/reference/languages/javascript/score.html) covers lookup, creation, controls, triggers, durations, presets, metadata and undo. Prefer the command-based `Score` functions for edits that should be undoable: assigning a QObject property directly does not automatically create an undo command.

## Functions operating on devices

[Devices and discovery]({{ site.baseurl }}/reference/languages/javascript/devices.html) covers protocol enumeration, saved device settings and live values. [QML protocols]({{ site.baseurl }}/reference/languages/qml-protocols.html) covers raw sockets, framing, encoding, HTTP and OAuth.

## Util object

[Files, time and utilities]({{ site.baseurl }}/reference/languages/javascript/utilities.html) documents file operations, asynchronous pickers, environment variables and time units.

## UI

[View and interface automation]({{ site.baseurl }}/reference/languages/javascript/view.html) documents captures, selection, prompts and process editor placement. See the [QML custom UI API]({{ site.baseurl }}/reference/languages/javascript-ui.html) for QML interfaces, imported forms and texture previews, and the [Custom UI tutorial]({{ site.baseurl }}/custom-ui.html) for setup.

## Execution scripts

The [JavaScript execution API]({{ site.baseurl }}/reference/languages/javascript-process.html) reference describes ports, `tick`, execution state and GPU graphics. Editor APIs are not a real-time execution API: do not change the document or open dialogs from an audio-thread callback.

## Source reference

The authoritative declarations are [`EditContext.hpp`](https://github.com/ossia/score/blob/master/src/plugins/score-plugin-js/JS/Qml/EditContext.hpp), [`Utils.hpp`](https://github.com/ossia/score/blob/master/src/plugins/score-plugin-js/JS/Qml/Utils.hpp) and [`ViewContext.hpp`](https://github.com/ossia/score/blob/master/src/plugins/score-plugin-js/JS/Qml/ViewContext.hpp). C++ implementation classes are not themselves JavaScript processes.
