---
layout: default

title: Custom UI
description: "Build focused QML controls and readouts for operating a score in performance or an installation."

parent: In depth

permalink: /custom-ui.html
score: /in-depth/custom-ui.score
---

# Custom UIs

It is possible to create custom control UIs for a given ossia score through QML and QtQuick, 
a GPU-accelerated UI language part of Qt.

Use a custom application UI for an installation, or give an individual Javascript process its own control interface. QML interfaces can use the editor API, Qt Quick Controls and score port bindings without putting editor operations in execution callbacks.

It is recommended to be familiar with QML, Qt Quick (for instance by going through the [QML Book](https://www.qt.io/product/qt6/qml-book)) and ossia score's [[scripting]] before 
making your own UI.

## UI objects

The [QML custom UI API]({{ site.baseurl }}/reference/languages/javascript-ui.html#ui-objects) documents `PortSource`, `PortSink` and `AddressSource`, including playback requirements and undo behavior. This tutorial uses these bindings to connect a control panel to a running score.

## Running with a custom UI

A whole-application UI can be passed as a command-line argument:

```
$ ./score --ui path/to/my/ui.qml path/to/my/document.score
```

## Per-process interfaces and placement

For an individual Javascript process, save a companion `effect.ui.qml` alongside `effect.qml`, then open it with the process's custom-UI action. Code and UI can be edited independently in the script editor. Choose **Window**, **Side panel** or **Central** placement as appropriate for your workspace.

See the [complete `ScriptUI` example and port lookup API]({{ site.baseurl }}/reference/languages/javascript-ui.html#per-process-interfaces-and-placement), including the numeric control inlet required by the example, and the [view API]({{ site.baseurl }}/reference/languages/javascript/view.html#process-editors-and-custom-interfaces) for scripted placement.

### Messages and persistent state

Use the [message bridge and persistent-state API]({{ site.baseurl }}/reference/languages/javascript-ui.html#messages-and-persistent-state) to exchange messages with the execution script or save UI state in the document and presets. The UI and execution script are separate objects, not a shared set of QML properties.

## Imported QML forms

To reuse a trusted exported QML form, see [Imported QML forms]({{ site.baseurl }}/reference/languages/javascript-ui.html#imported-qml-forms) for the complete `ImportedUi` example, root-item requirements, mappings and diagnostics.

## Graphics and texture previews

For choosing visual controls, drawing with Qt Quick `Canvas` or showing an existing texture through `TextureSource`, see [Graphics and texture previews]({{ site.baseurl }}/reference/languages/javascript-ui.html#graphics-and-texture-previews). Native process-control declarations are not visual widgets for a custom layout.

## Basic example

Give a performer a small control panel instead of the full score editor. This example pairs a shader-zoom dial with live numerical readouts and a second dial for an external OSC destination. It shows how a custom interface can expose just the controls and feedback needed to operate a piece.

[Download the example score]({{ site.scores }}{{ page.score }}).

{% include try-on-web.html %}

Save the QML below as `custom-ui.qml` beside the downloaded score, then launch:

```
$ ./score --ui custom-ui.qml custom-ui.score
```

The interface starts playback automatically. Open the score's Window output and turn the first dial to change the shader's zoom. The labels read a changing LFO amplitude, a monitored output value and a device address, so you can compare direct control with feedback from the running score.

![Custom control panel with dials and live value readouts.]({{ site.img }}/in-depth/custom-ui.avif)

The last dial writes to `OSC:/bar`, configured to send to a receiver on the local machine at UDP port 9996. Use an OSC monitor or another application listening on that port to observe it; the dial does not control the shader. No OSC receiver is needed for the shader and local readouts. Change the device's destination if your receiver is elsewhere, and allow local UDP traffic if required.

In the QML, `PortSource` connects a widget to a named process control, while `AddressSource` connects it to the device explorer. The names and addresses below match the downloadable score. When adapting the panel, change the bindings to match your own processes and devices rather than just relabelling the widgets.

```qml
import QtQuick
import QtQuick.Controls
import Score.UI as UI

Rectangle {
  color: "white"
  width: 640
  height: 480
  Component.onCompleted: Score.play();

  Column {
    Label { text: "Operating a control:" }
    Dial {
      UI.PortSource on value {
        process: "some_shader"
        port: 1
      }
    }

    Label { text: "Reading the value of a control inlet:" }
    Label {
      UI.PortSource on text {
          process: "LFO"
          port: "Ampl."
      }
    }

    Label { text: "Reading the value of any outlet by adding a value display:" }
    Label {
      UI.PortSource on text {
          process: "Value display"
          port: 0
      }
    }

    Label { text: "Reading the value of any address:" }
    Label {
      UI.AddressSource on text {
          address: "OSC:/foo"
          sendUpdates: false
      }
    }

    Label { text: "Setting the value of any address:" }
    Dial {
      UI.AddressSource on value {
          address: "OSC:/bar"
          receiveUpdates: false
      }
    }
  }
}

```
