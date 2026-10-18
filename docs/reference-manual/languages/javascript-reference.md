---
layout: default
title: JavaScript and QML
description: "JavaScript language, QML imports and scripting contexts in ossia score"
parent: Languages
grand_parent: Reference
nav_order: 1
permalink: /reference/languages/javascript.html
---

# JavaScript and QML

*score* embeds Qt's JavaScript and QML engines for process execution, editor automation, custom interfaces and devices. The language is shared, but **the host API depends on where the script runs**. Importing a module does not give an execution script the editor's document-editing context.

## Choose a scripting context

| Context | Canonical reference | Entry point and purpose |
|---|---|---|
| Process execution | [JavaScript Process API]({{ site.baseurl }}/reference/languages/javascript-process.html) | A QML `Script` object from `import Score`; ports, `tick(token, state)`, lifecycle callbacks, audio, MIDI and textures. See the [Javascript process]({{ site.baseurl }}/processes/javascript.html) for installation into intervals or states and editing. |
| Editor automation | [JavaScript Editor API]({{ site.baseurl }}/reference/languages/javascript-editor.html) | Scripts that inspect and edit a document through the editor's `Score` context. Detailed references cover [Score]({{ site.baseurl }}/reference/languages/javascript/score.html), [devices]({{ site.baseurl }}/reference/languages/javascript/devices.html), [utilities]({{ site.baseurl }}/reference/languages/javascript/utilities.html), [views]({{ site.baseurl }}/reference/languages/javascript/view.html) and [examples]({{ site.baseurl }}/reference/languages/javascript/examples.html). |
| Custom process interfaces | [QML custom UI API]({{ site.baseurl }}/reference/languages/javascript-ui.html) | A companion `ScriptUI`, controls and messages between UI and execution objects; the UI is not the execution object. |
| QML devices | [QML device API]({{ site.baseurl }}/reference/languages/qml-devices.html) | Device trees and JavaScript callbacks in a device context. |
| QML protocols | [QML protocol API]({{ site.baseurl }}/reference/languages/qml-protocols.html) | Protocol-specific roots, configuration and message handling. |

## ECMAScript and QML are different layers

**JavaScript** is the programming language standardized as ECMAScript: expressions, functions, objects, arrays and built-ins such as `Math` and `JSON`. The [ECMAScript specification](https://tc39.es/ecma262/) defines the language; the [MDN JavaScript reference](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference) explains its syntax and built-ins. Neither reference defines score's ports or callbacks.

**QML** is Qt's declarative object language, with JavaScript expressions and functions embedded in it. Declarations such as `Script { ... }`, `property real phase: 0`, `id: output` and reactive property bindings are QML, not ordinary ECMAScript object syntax. A process program is a QML document, not a standalone browser or Node.js script. Consult the [QML reference](https://doc.qt.io/qt-6/qmlreference.html), [QML syntax basics](https://doc.qt.io/qt-6/qtqml-syntax-basics.html), and the [QML Book](https://www.qt.io/product/qt6/qml-book/ch01-meetqt-meet-qt).

For example, this process declares a QML output object and assigns a JavaScript function to the execution callback:

```qml
import Score

Script {
  ValueOutlet { id: output }
  tick: function(token, state) {
    output.value = token.position();
  }
}
```

Here `Script`, `ValueOutlet`, `token.position()` and the callback invocation are score APIs, not JavaScript built-ins.

## Qt runtime and restrictions

Language features and installed QML modules follow the **Qt version bundled with score**, not the newest ECMAScript specification or the Qt version installed elsewhere on the computer. Qt documents its supported language baseline and version-specific additions in the [JavaScript host environment](https://doc.qt.io/qt-6/qtqml-javascript-hostenvironment.html) and [supported objects and functions](https://doc.qt.io/qt-6/qtqml-javascript-functionlist.html).

- This is not a web browser: do not assume `window`, `document`, an HTML DOM or browser APIs exist. Qt Quick's `Canvas` is a QML item, not an HTML canvas.
- This is not Node.js: Node's `require`, filesystem/process APIs and npm package resolution are not supplied by the QML host. A package that relies on them is not made compatible merely by using JavaScript.
- Qt supplies its own [QML global object](https://doc.qt.io/qt-6/qtqml-javascript-qmlglobalobject.html), including the `Qt` facilities, and QML-specific scope rules. JavaScript inside a `.qml` file cannot add undeclared globals; declare local variables or QML properties. Use explicit QML object IDs rather than assuming browser-like `this` behavior.
- A Qt module must be available in the score build to be imported. Importing `QtQuick` supplies visual types; it does not move process execution onto the GUI thread. GPU ports require GPU JavaScript support. See [execution and build limitations]({{ site.baseurl }}/reference/languages/javascript-process.html#execution-and-build-limitations), including the current WebAssembly limitation.

## Imports, modules and resource locations

A QML module import such as `import Score` makes QML types available. Process scripts require it for `Script` and ports; add `import QtQuick` when using Qt Quick items or types. Prefer qualified imports when names overlap, for example `import Score as Score` and `import QtQuick.Controls as QQC`, then use `Score.Script` and `QQC.Button`.

A JavaScript helper is imported into a QML document with a namespace, for example `import "helpers.js" as Helpers`; its functions are then called as `Helpers.functionName(...)`. The qualifier begins with an uppercase letter. This QML import syntax is not ECMAScript's `import { name } from ...` syntax. Qt also supports ECMAScript modules in `.mjs` files; use ECMAScript `import` and `export` within that module context, not at the top of a QML object definition.

Imported resources have scope rules of their own. In particular, a `.pragma library` helper does not inherit the importing QML document's imports, and a JavaScript resource with its own imports also does not inherit them. Do not assume a helper has access to a particular process's object IDs or host objects. See Qt's [JavaScript resource imports](https://doc.qt.io/qt-6/qtqml-javascript-imports.html), [JavaScript resources](https://doc.qt.io/qt-6/qtqml-javascript-resources.html) and [scope and naming resolution](https://doc.qt.io/qt-6/qtqml-documents-scope.html) for the exact rules.

For file-backed processes, the source location supplies the QML base URL: neighboring imports and assets resolve relative to that source file. `Qt.resolvedUrl("image.png")` resolves a resource URL; the internal `rootPath` is not a JavaScript filesystem global. Keep companion files and imported modules with the source when moving a project. The companion `name.ui.qml` provides the custom UI for `name.qml`; see the process's [files, relative resources and presets]({{ site.baseurl }}/processes/javascript.html#files-relative-resources-and-presets) workflow.

## Execution reference contents

The [complete process execution reference]({{ site.baseurl }}/reference/languages/javascript-process.html) preserves the process API and examples:

- [Script syntax]({{ site.baseurl }}/reference/languages/javascript-process.html#general-syntax), [callbacks and persistence]({{ site.baseurl }}/reference/languages/javascript-process.html#callbacks-and-persistent-state), and [device read/write]({{ site.baseurl }}/reference/languages/javascript-process.html#available-functions).
- [Token timing fields and methods]({{ site.baseurl }}/reference/languages/javascript-process.html#token-object) and [execution state]({{ site.baseurl }}/reference/languages/javascript-process.html#state-object).
- [Ports]({{ site.baseurl }}/reference/languages/javascript-process.html#port-types), [audio]({{ site.baseurl }}/reference/languages/javascript-process.html#audio), [MIDI]({{ site.baseurl }}/reference/languages/javascript-process.html#midi), [messages]({{ site.baseurl }}/reference/languages/javascript-process.html#messages) and [controls]({{ site.baseurl }}/reference/languages/javascript-process.html#controls).
- [Value mapping]({{ site.baseurl }}/reference/languages/javascript-process.html#example-of-a-value-mapper), [audio generation]({{ site.baseurl }}/reference/languages/javascript-process.html#example-of-an-audio-generator), [MIDI transposition]({{ site.baseurl }}/reference/languages/javascript-process.html#example-of-a-midi-transposer) and [timing examples]({{ site.baseurl }}/reference/languages/javascript-process.html#example-of-fetching-various-timings).
- [Generative graphics]({{ site.baseurl }}/reference/languages/javascript-process.html#generative-graphics), [Canvas2D]({{ site.baseurl }}/reference/languages/javascript-process.html#canvas2d), and [texture input and render size]({{ site.baseurl }}/reference/languages/javascript-process.html#texture-input-and-render-size).
