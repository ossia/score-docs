---
layout: default

title: Remote Control
description: "Remote control through WebSockets and an optional HTTP-served web interface"

parent: In depth

permalink: /in-depth/remote.html
---

# Remote Control

The two main ways to remote control score from the network are:

- Through OSC and OSCQuery with the [Local device]({{ site.baseurl }}/devices/local-device.html).

- Through a WebSocket API. The WebSocket API has been used to build a nice [graphical remote application](https://github.com/iscore-pfa/qml-remote).

This page describes score's WebSocket control API and the optional HTTP server for a browser-based remote. They are separate from the HTTP and WebSocket **devices**, which connect a score to external services.

## Enable a browser remote

In **Remote control** settings, enable **Enabled**. Under **Web UI**, choose the folder containing the built remote application's web assets using **Web UI folder**, set **HTTP server address/port**, then enable **Enable HTTP server**. The default HTTP bind address is `0.0.0.0` and the default port is **10111**; use `127.0.0.1` for local-only access. A WebAssembly build of the remote must be supplied separately: score does not generate it from your document.

For the qml-remote build that supplies `ossia_remote.html`, open `http://<score-host>:10111/ossia_remote.html`. The HTTP server serves files from the chosen directory; it is **not a REST editing API**. The control connection uses a separate, non-TLS WebSocket listener on **10212**, for example `ws://127.0.0.1:10212`.

Keep both services on a trusted network or behind an appropriately configured firewall/tunnel. The WebSocket API includes arbitrary console-code execution and has no application authentication handshake. The Enabled checkbox must not be treated as a security boundary: the current document plugin constructs its listener independently of interval-monitoring enablement. Do not publish the ports directly to the Internet.

Browser asset availability, browser restrictions and network access are separate from the desktop score's capabilities. Serving a WebAssembly remote does not mean desktop JavaScript processes execute in score's WebAssembly build.

## Description
Exposes some properties of the score over WebSockets:
* Transport.
* Viewing and controlling triggers.
* Sending & receiving messages through the Device Explorer.
* Executing JS code in the console.

## WebSocket API description

The message format is JSON.

### Score -> client

```js
{
    "Message": "DeviceTree"
}
```


#### When a trigger starts executing:
```js
{
    "Message": "TriggerAdded",
    "Path": "/path/to/the/trigger"
}
```

#### When a trigger has finished executing:
```js
{
    "Message": "TriggerRemoved",
    "Path": "/path/to/the/trigger"
}
```

#### When an interval starts executing:
```js
{
    "Message": "IntervalAdded",
    "Path": "/path/to/the/interval",
    "Name": "machine_readable.name",
    "Label": "User-readable label",
    "Comment": "User-readable comment",
    "Speed": 1.2345
}
```

#### When an interval has finished executing:
```js
{
    "Message": "IntervalRemoved",
    "Path": "/path/to/the/interval"
}
```

#### Periodic interval update (currently every 100 ms):
```js
{
    "Intervals": [ {
        "Path": "/path/to/the/interval",
        "Progress": 0.5,
        "Speed": 1.,
        "Gain": 0.8
    }, ...
    ]
}
```


### Client -> score

#### Transport messages:

```js
{ "Message": "Play" }

{ "Message": "Pause" }

{ "Message": "Stop" }

{
    "Message": "Transport",
    "Milliseconds": 40000
}
```

#### Console control:

See the [Scripting API]({{ site.baseurl }}/in-depth/scripting-api.html) for the available operations. Only trusted clients should be allowed to use this message.
```js
{
  "Message": "Console",
  "Code": "someJSCodeToExecute()"
}
```

#### To trigger a trigger:
```js
{
    "Message": "Trigger",
    "Path": "/path/to/the/trigger"
}
```

#### To slow down or speed up an interval:
```js
{
    "Message": "IntervalSpeed",
    "Path": "/path/to/the/interval",
    "Speed": 0.5
}
```

#### To change the gain of an interval:
```js
{
    "Message": "IntervalGain",
    "Path": "/path/to/the/interval",
    "Gain": 0.5
}
```

#### To send a control message:
```js
{
    "Message": "Message",
    "Address": "device:/foo/bar@[color.rgb.r]",
    "Value": {
        "Float": 1.23
    }
}
```

or, to showcase all possible types:
```js
{
    "Message": "Message",
    "Address": "device:/foo/bar",
    "Value": {
        "Tuple": [
            { "Int": 1 },
            { "Bool": true },
            { "Char": "c" },
            { "Vec2f": [0.0, 1.1] },
            { "Vec3f": [0.0, 1.1, 1.2] },
            { "Vec4f": [0.0, 1.1, 1.3, 1.4] },
            { "Float": 1.23 },
            { "String": "foo" },
            { "Impulse": null },
        ]
    }
}
```

#### To enable / disable listening

Listening to an address means that when an address's value changes, the
new value is forwarded to the remote client.

```js
{
    "Message": "EnableListening",
    "Address": "device:/foo/bar"
}
```

and

```js
{
    "Message": "DisableListening",
    "Address": "device:/foo/bar"
}
```


#### Control surface

See [Control surface]({{ site.baseurl }}/processes/controlsurface.html).

## Published scriptable namespace

On connection, the server sends a `DeviceTree` message with a `Nodes` tree and, when the local device is available, a `Scriptable` message containing `controls`, `triggers` and `conditions` trees. These correspond to explicitly published scriptable objects, not every internal model object.

```json
{ "Message": "ScriptableRenamed", "Old": "score:/controls/old", "New": "score:/controls/new" }
```

`ScriptableRemoved` carries an `Address` for a removed published node. A new `Scriptable` snapshot is sent when the published structure changes, including restoration through undo. A remote should update its address bindings rather than retain stale names indefinitely. Use the existing `Message` and listening requests for live values, and the named namespace to discover controls. The local device's actual name determines the address prefix; do not hard-code `score` for every document.

The editor API's [Controls, Triggers and Conditions]({{ site.baseurl }}/in-depth/scripting-api/score.html#triggers-conditions-and-published-names) offers the corresponding script-side access. See [Custom UI]({{ site.baseurl }}/custom-ui.html) for an interface hosted inside score instead of in a remote client.

Source: [`RemoteControl/Settings/View.cpp`](https://github.com/ossia/score/blob/master/src/plugins/score-plugin-remotecontrol/RemoteControl/Settings/View.cpp), [`HttpServer`](https://github.com/ossia/score/tree/master/src/plugins/score-plugin-remotecontrol/RemoteControl/HttpServer), and [`Websockets/DocumentPlugin.cpp`](https://github.com/ossia/score/blob/master/src/plugins/score-plugin-remotecontrol/RemoteControl/Websockets/DocumentPlugin.cpp).