---
layout: default

title: Document and process API
description: "Find and edit score objects, ports, cables, triggers and presets"
parent: Scripting API
grand_parent: In depth
permalink: /in-depth/scripting-api/score.html
---

# Document and process API

Examples use the console's `Score` object. In a GUI-thread QML interface using `import Score as Score`, call these editor functions through `Score.Editor`.

## Lookup and traversal

| Call | Result / meaning |
|---|---|
| `Score.document()`, `Score.rootInterval()` | Current document model and its root interval. |
| `Score.find(name)`, `Score.findByLabel(label)` | Find by scripting name or display label. Use distinctive names rather than relying on duplicate labels. |
| `Score.path(object)`, `Score.findByPath(path)` | Obtain and resolve an object path within the current document. This is not a device address. |
| `Score.selectedObject()`, `Score.selectedObjects()` | First selected object, or all selected objects. |
| `Score.processes(object)`, `Score.process(object, index)` | Process count and zero-based lookup for an interval or state. Index 0 is the most recently added process, not the leftmost timeline object. |
| `Score.parentProcess(object)`, `Score.parentInterval(object)` | Owning process or interval; a process or interval respectively resolves to itself. |
| `Score.startState(interval)`, `Score.endState(interval)` | Boundary states. Equivalent `startEvent` / `endEvent` and `startSync` / `endSync` access the events and time syncs. |

Check lookup results before editing: missing objects can return `null`. Handles to removed objects must not be reused. `Score.select(object)` and `Score.select([object1, object2])` update the selection.

## Creating and editing

```js
Score.withMacro(function() {
  var scenario = Score.createProcess(Score.rootInterval(), "Scenario", "");
  var box = Score.createBox(scenario, "0s", "5s", 0.3);
  Score.setName(box, "generated_interval");
  Score.setComment(box, "Generated from the console");
  var curve = Score.createProcess(box, "Automation (float)", "");
  Score.setCurvePoints(curve, [[0, 0], [0.5, 1], [1, 0]]);
});
```

`createBox(parent, start, duration, y)` requires a **Scenario process** as its parent, not an interval. `y` is the vertical position, normally between 0 and 1. Also available:

- `createState(event, y)`, `createIntervalAfter(state, duration, y)`, `createIntervalBetween(startState, endState)`.
- `createProcess(interval, name, data)`: names come from the process library; `data` supplies process-specific creation data such as a file path, not a reserved argument. `availableProcesses()`, `availableProcessesAndPresets()` and `libraryEntries(filter)` help discover installed processes and library content.
- `automate(interval, address)` creates curves for matching device parameters and returns an array of processes. `automate(interval, port)` returns one new automation and cables it to the control.
- `setSteps(process, values)` edits a Step Sequencer. `setCurvePoints(process, [[x, y], ...])` edits an automation; coordinates are normalized and must be finite.
- `messages(state)`, `setMessages(state, messages)` read and replace state messages. `replaceAddress(objects, before, after)` replaces addresses across a selection.
- `remove(object)` removes supported scenario objects, processes or cables through an undoable edit.

## Ports and cables

`inlets(process)` / `outlets(process)` return counts. `inlet(process, indexOrName)` and `outlet(process, indexOrName)` use zero-based indexes or names. `port(process, name)` searches inlets first: use the directional form if both directions share a name. `portName(port)` returns its display name.

```js
var selected = Score.parentProcess(Score.selectedObject());
if (selected) {
  var input = Score.inlet(selected, 0);
  if (input) console.log(Score.portName(input), Score.valueType(input));
}
```

- `createCable(outlet, inlet)` returns the cable. `cable(outlet, inlet)` finds an existing connection.
- `cables(port)` and `cable(port, index)` enumerate attached cables. `source(cable)` returns its outlet; `sink(cable)` returns its inlet.
- `setAddress(port, "device:/path")` assigns an address. `setPropagate(audioOutlet, false)` disables the audio connection to the parent interval. An outlet writes to its address only when it has no cable.
- `setValue(control, value)` makes an undoable control change. It converts to the control's type; vectors and list controls accept the corresponding values. A plain event inlet is not a stored control value.
- `valueType(control)`, `min(control)`, `max(control)` and `enumValues(control)` describe controls.
- `pushExecutionValue(port, value)` sends a transient value to execution and returns whether it could be sent; it does not replace a persistent control edit.

A texture **inlet model** exposes `renderSize`. For example, with `input` obtained from `Score.inlet`, `input.renderSize = Qt.size(320, 240)` sets a resolution override. This direct property edit is not an undo command, and does not apply to arbitrary value or audio ports.

## Undo, macros and gestures

Single command-based edits are already undoable: they do **not** require a surrounding macro. `withMacro(function() { ... })` groups edits into one action. Nested calls join the outer macro. If the callback errors, changes already made are committed, **not rolled back**. Manual `startMacro()` / `endMacro()` remain available but are not exception-safe; starting a second manual macro replaces the open one.

For a dragged control, repeatedly call `editValue(control, value)`, then `commitEdit()` on release. The gesture becomes one undo step. Editing another control first commits the previous gesture.

`undo()`, `redo()`, `canUndo()`, `canRedo()`, `undoIndex()`, `undoCount()`, `undoText()` and `redoText()` expose the real command stack. Do not maintain a parallel stack in JavaScript.

For state owned by your script rather than a score object, register `registerCommandHandler(name, function(payload) { ... })`, then call `pushCommand(name, undoPayload, redoPayload)`. Payloads must be JSON-serializable. Pushing immediately invokes the redo payload; register the handler again when loading the script so recovered commands can find it.

## Triggers, conditions and published names

`enableTrigger(object)` / `disableTrigger(object)` resolve an interval to its **end time sync**, or a state/event to its time sync. `enableCondition(object)` / `disableCondition(object)` operate on events; a state resolves to its event. `setExpression(object, expression)` and `expression(object)` operate on the resolved trigger or condition:

```js
var interval = Score.find("generated_interval");
if (interval) {
  Score.enableTrigger(interval);
  Score.setExpression(interval, "{ %osc:/ready% == true }");
}
```

Use an address that exists in your document. `trigger(object)` manually triggers the resolved time sync; `setAutoTrigger(timeSync, enabled)` changes automatic triggering.

`setScriptable(object, true)` publishes a supported control, process, trigger or condition in the local device's named namespace. `scriptableAddress(object)` returns its address. In the console:

```js
console.log(Score.Controls.names());
console.log(Score.Triggers.names());
```

Traverse returned names with bracket notation (names can contain spaces). Read/write value leaves as properties; call impulse leaves as functions. Namespace nodes provide `names()` and `address()`. QML scripts importing `Score` can use the `Controls`, `Triggers` and `Conditions` singletons. Publication is required: these are not every object in the score.

`references(object)` finds states, ports, events and syncs with addresses anchored to an object; `targets(object)` resolves the inverse direction. `rebind(object, from, to)` redirects anchored addresses held by an object.

## Durations and transport

A numeric score duration is in **flicks** (705,600,000 per second), not milliseconds. String durations accepted by `createBox` and `createIntervalAfter` include `"500ms"`, `"2s"`, `"1.5 min"`, `"1h"`, `"1:02.5"` and `"1:02:03.250"`. A bare numeric string is also flicks; write the unit to avoid ambiguity. Invalid or negative strings currently produce a warning and fall back to **2 seconds**: validate generated durations rather than relying on this fallback.

`setIntervalDuration`, `setIntervalMinDuration` and `setIntervalMaxDuration` take time values; use `Util.timevalFromMilliseconds(5000)` rather than guessing raw units. `setIntervalMaxInfinite(interval, true)`, `setIntervalSpeed(interval, speed)` and `setProcessLoop(process, enabled)` control other timing properties. `Util.toSeconds(object.duration)` and `Util.toMilliseconds(object.date)` convert model values where these properties exist.

`play()`, `pause()`, `resume()`, `stop()` and `reinitialize()` control the score. `play(interval)` and `stop(interval)` operate on an interval. **`scrub(milliseconds)` is a millisecond offset, not a normalized 0–1 position.** `playFromHere(milliseconds)` starts playback at that date, or seeks there during playback. `transport()` returns the transport object.

## Presets, metadata and files

`savePreset(process)` returns preset JSON; `loadPreset(process, json)` applies it through an undoable preset command. JavaScript process presets include their program, UI and persisted script state, not just inlet values.

`metadata(object)` exposes `name`, `label`, `comment` and `colorName`. `colorName` is a **skin entry name**, not an arbitrary HTML color; unknown names are ignored. Prefer `setName(object, name)` and `setComment(object, text)` for undoable changes. Direct metadata property assignments bypass these commands.

`documentMetadata()` exposes `fileName`, `author`, `creation` and `lastEdition`. `documentName()` is the title-bar name; `setDocumentName(name)` changes the next save's name but does not save a file. Use `load(path)`, `save()` or `saveAs(path)` for file operations; `serializeAsJson()` returns the current document serialization.

Source: [`EditContext.hpp`](https://github.com/ossia/score/blob/master/src/plugins/score-plugin-js/JS/Qml/EditContext.hpp), [`ParseDuration.hpp`](https://github.com/ossia/score/blob/master/src/plugins/score-plugin-js/JS/Qml/ParseDuration.hpp), and [`ModelMetadata.hpp`](https://github.com/ossia/score/blob/master/src/lib/score/model/ModelMetadata.hpp).
