---
layout: default

title: Remote Control
description: "Remote control through a WebSocket API"

parent: In depth

permalink: /in-depth/remote.html
---

# Remote Control

The two main ways to remote control score from the network are:

- Through OSC and OSCQuery with the [Local device]({{ site.baseurl }}/devices/local-device.html).

- Through a WebSocket API. The WebSocket API has been used to build a nice [graphical remote application](https://github.com/iscore-pfa/qml-remote).

This page describes the low-level WebSocket API used by score, so that anyone can build their custom
remotes similar to the one mentioned above..

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

#### Heartbeat sent every few milliseconds:
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

See the [Console API](console.html) for the allowed operations.
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
            { "Char": c },
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