---
layout: default

title: View and interface API
description: "Editor navigation, captures, prompts and process UI placement"
parent: Scripting API
grand_parent: In depth
permalink: /in-depth/scripting-api/view.html
---

# View and interface API

[Back to the Scripting API]({{ site.baseurl }}/in-depth/scripting-api.html) · [Examples]({{ site.baseurl }}/in-depth/scripting-api/examples.html#prompt-and-view-navigation)

`View` operates on score's editor, not on a process's texture output. It is available in the console and process UI engine. With no GUI, view navigation has no effect and captures requiring a view fail.

## Navigate and capture

| Call | Action |
|---|---|
| `View.zoom(x, y)`, `View.scroll(x, y)` | Zoom or scroll the current scenario view. |
| `View.setZoomRatio(ratio)` | Set the timeline zoom ratio. |
| `View.centerOn(process)` | Center on a process. |
| `View.goToInterval(interval)` | Navigate into an interval. |
| `View.fit()`, `View.recenter()` | Fit or recenter the view. |
| `View.setNodal(enabled)`, `View.isNodal()` | Set or query dataflow view mode. |
| `View.grabScene(path)` | Save the currently visible scene region, respecting scroll and zoom, without main-window panels. |
| `View.grabMainWindow(path)` | Save the main application window. |
| `View.grabScreen(path)` | Capture the primary screen, subject to platform capture permissions. |
| `View.grabWidget(widget, path)` | Capture a particular QWidget. |

Capture functions return a boolean indicating success. They save to disk; they do not return a texture or a `QImage`. For a stable frame, navigate first and capture after the GUI has processed the update.

```js
var panel = View.panel("Device Explorer");
if (panel) console.log(View.grabWidget(panel, "/tmp/devices.png"));
```

`View.panels()` lists panel display names and widget class names. `View.panel(name)` accepts either, case-insensitively; class names avoid translated-label differences. `View.child(parent, className)` finds the first descendant of a Qt class, for instance a `QTreeView`. Returned widgets belong to score: do not destroy them. Only Qt-exposed slots/properties are callable from JavaScript.

## Process editors and custom interfaces

```js
var process = Score.parentProcess(Score.selectedObject());
if (process && Score.hasProcessScriptEditor(process)) {
  Score.setProcessScriptEditorPlacement(process, "Side panel");
  Score.showProcessScriptEditor(process, true);
}
```

`setProcessScriptEditorPlacement(process, placement)` and `setProcessUIPlacement(process, placement)` accept exactly `"Window"`, `"Side panel"`, `"Central"` or `""` for the user's default. They configure the script editor and custom UI independently. The side panel docks in the editor; central placement uses the center area; window placement detaches it.

Use `hasProcessUI(process)` / `showProcessUI(process, visible)` for custom interfaces and `hasProcessScriptEditor(process)` / `showProcessScriptEditor(process, visible)` for code editors. A process must actually supply the corresponding interface.

See [Custom UI]({{ site.baseurl }}/custom-ui.html) for `ScriptUI`, port bindings and imported forms, and [Editing workflow]({{ site.baseurl }}/reference/editing-workflow.html) for interactive placement controls.

## Prompt forms

`Score.prompt(configuration)` opens a form and returns an array in widget order, or `undefined` if cancelled:

```js
var answer = Score.prompt({
  title: "Create controls",
  widgets: [
    { name: "Name", type: "lineedit", init: "Control" },
    { name: "Count", type: "spinbox", min: 1, max: 16, init: 4 },
    { name: "Enabled", type: "checkbox", init: true }
  ]
});
if (answer !== undefined) console.log(answer);
```

The form also supports `textfield` and floating-point `slider` widgets. For file and color pickers use the asynchronous [Util dialogs]({{ site.baseurl }}/in-depth/scripting-api/utilities.html#asynchronous-native-dialogs) instead.

Source: [`ViewContext.hpp`](https://github.com/ossia/score/blob/master/src/plugins/score-plugin-js/JS/Qml/ViewContext.hpp), [`ViewContext.cpp`](https://github.com/ossia/score/blob/master/src/plugins/score-plugin-js/JS/Qml/ViewContext.cpp) and [`EditContext.ui.cpp`](https://github.com/ossia/score/blob/master/src/plugins/score-plugin-js/JS/Qml/EditContext.ui.cpp).
