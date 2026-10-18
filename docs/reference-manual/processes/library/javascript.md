---
layout: default

title: Javascript
description: "Adding, editing and using Javascript processes in ossia score"

parent: Processes
grand_parent: Reference

permalink: /processes/javascript.html
---

# Javascript support

For language syntax, imports and the different scripting contexts, see [JavaScript and QML]({{ site.baseurl }}/reference/languages/javascript.html) under **Reference → Languages**. The complete [JavaScript Process API]({{ site.baseurl }}/reference/languages/javascript-process.html) documents ports, callbacks, timing, persistent state and example programs.

## Scripting in Javascript / QML.
*score* allows to write scripts using the JavaScript language. These scripts can be used to write specific processes such as value mappers, audio generators.

*score* executes JavaScript through Qt's QML engine. Language and Qt module availability follow the Qt version bundled with the application; this is not a browser or Node.js environment. See the [JavaScript reference](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference) for language concepts.

QML is Qt's declarative object language with embedded JavaScript expressions and functions. Its object declarations and properties (`property real`, etc.) are not ordinary JavaScript syntax. See the [language overview]({{ site.baseurl }}/reference/languages/javascript.html#ecmascript-and-qml-are-different-layers) for the distinction and upstream language references.

Enter QML code or a source-file path in the Javascript code editor. File-backed scripts keep their source location so that relative imports, images and companion UIs resolve correctly.

JS can be used as a process both for intervals, and in states.
* To add a JS process to an interval, simply drag'n'drop it from the Process Library to the interval.
* To add a JS process to a state, right-click on the state in the Object Explorer, and choose "Add Process".

JS can also be used for generative graphics with Qt Quick. See the [graphics examples]({{ site.baseurl }}/reference/languages/javascript-process.html#generative-graphics); connect the texture outlet to a graphical output before playing.

## Editing code

The editor validates QML before applying it to the process. Resolve reported compilation errors before expecting the new program or its ports to be used; keep substantial code in an external source file as well as in the document.

### Files, relative resources and presets

The source location (`rootPath` internally) supplies a QML base URL, not a new JavaScript filesystem global. Use `Qt.resolvedUrl("image.png")` and relative imports next to the source file. The companion `name.ui.qml` supplies a `ScriptUI` for `name.qml`; see the [custom UI API]({{ site.baseurl }}/reference/languages/javascript-ui.html).

Source files are watched. If a saved/edited program differs from its external source, the inspector can offer an **Update** action rather than silently discarding the document's copy. An unreadable source does not replace the saved program with empty text. See [source update notices]({{ site.baseurl }}/reference/editing-workflow.html#source-update-notices). When moving projects, retain the source's neighboring assets and imported modules.

JavaScript presets include program code, companion UI and persisted script state. Plain temporary QML properties are not automatically saved as document state: see the [persistent state callbacks]({{ site.baseurl }}/reference/languages/javascript-process.html#callbacks-and-persistent-state).

### Execution and build limitations

Declare the ports and controls required by the process, then apply the code and connect its inlets and outlets to other processes or device addresses. The [port reference]({{ site.baseurl }}/reference/languages/javascript-process.html#port-types) covers messages, audio, MIDI, controls and textures.

GPU scripts use the graphics execution path; CPU scripts run with execution, not on the GUI thread. Do not open native dialogs or directly edit the document from `tick`. GPU ports need GPU JavaScript support, and the current WebAssembly build does not insert Javascript processes into the execution graph. See the canonical [execution and build limitations]({{ site.baseurl }}/reference/languages/javascript-process.html#execution-and-build-limitations).

## Language and API reference

The detailed language and API reference is under **Reference → Languages**. Go directly to a relocated section:

- <a id="general-syntax"></a>[General syntax]({{ site.baseurl }}/reference/languages/javascript-process.html#general-syntax): `import Score`, the `Script` object and execution callbacks.
- <a id="available-functions"></a>[Available functions]({{ site.baseurl }}/reference/languages/javascript-process.html#available-functions): `Device.read` and `Device.write`.
- <a id="token-object"></a>[Token object]({{ site.baseurl }}/reference/languages/javascript-process.html#token-object): model, physical and musical timing.
- <a id="properties"></a>[Token properties]({{ site.baseurl }}/reference/languages/javascript-process.html#properties).
- <a id="methods"></a>[Token methods]({{ site.baseurl }}/reference/languages/javascript-process.html#methods).
- <a id="state-object"></a>[State object]({{ site.baseurl }}/reference/languages/javascript-process.html#state-object): execution environment and audio-buffer timing.
- <a id="properties-1"></a>[Execution state properties]({{ site.baseurl }}/reference/languages/javascript-process.html#properties-1).
- <a id="example-of-a-value-mapper"></a>[Example of a value mapper]({{ site.baseurl }}/reference/languages/javascript-process.html#example-of-a-value-mapper).
- <a id="example-of-an-audio-generator"></a>[Example of an audio generator]({{ site.baseurl }}/reference/languages/javascript-process.html#example-of-an-audio-generator).
- <a id="example-of-a-midi-transposer"></a>[Example of a MIDI transposer]({{ site.baseurl }}/reference/languages/javascript-process.html#example-of-a-midi-transposer).
- <a id="port-types"></a>[Port types]({{ site.baseurl }}/reference/languages/javascript-process.html#port-types).
- <a id="properties-common-to-all-ports"></a>[Properties common to all ports]({{ site.baseurl }}/reference/languages/javascript-process.html#properties-common-to-all-ports).
- <a id="audio"></a>[Audio ports]({{ site.baseurl }}/reference/languages/javascript-process.html#audio).
- <a id="example-of-fetching-various-timings"></a>[Example of fetching various timings]({{ site.baseurl }}/reference/languages/javascript-process.html#example-of-fetching-various-timings).
- <a id="midi"></a>[MIDI ports]({{ site.baseurl }}/reference/languages/javascript-process.html#midi).
- <a id="messages"></a>[Message ports]({{ site.baseurl }}/reference/languages/javascript-process.html#messages).
- <a id="controls"></a>[Controls]({{ site.baseurl }}/reference/languages/javascript-process.html#controls).
- <a id="generative-graphics"></a>[Generative graphics]({{ site.baseurl }}/reference/languages/javascript-process.html#generative-graphics): texture output, reactive bindings and interactive widgets.
- <a id="canvas2d"></a>[Canvas2D]({{ site.baseurl }}/reference/languages/javascript-process.html#canvas2d).
- <a id="texture-input-and-render-size"></a>[Texture input and render size]({{ site.baseurl }}/reference/languages/javascript-process.html#texture-input-and-render-size).