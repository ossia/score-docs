---
layout: default
title: QML device API
description: "QML device roots, parameter trees, Mapper globals and HTTP, WebSocket and Serial callbacks"
parent: Languages
grand_parent: Reference
nav_order: 10
permalink: /reference/languages/qml-devices.html
---

# QML device API

QML device definitions combine JavaScript functions with a QML root object imported by `import Ossia 1.0 as Ossia`. This page documents score's device runtime, not browser JavaScript or Node.js. For core syntax, see the [Qt QML reference](https://doc.qt.io/qt-6/qmlreference.html), [JavaScript in QML](https://doc.qt.io/qt-6/qtqml-javascript-topic.html) and the [JavaScript language overview]({{ site.baseurl }}/reference/languages/javascript.html).

## Root types

| Root | Purpose | Setup and worked examples |
|---|---|---|
| `Ossia.Mapper` | Persistent parameter mappings, generators and script-managed values; can use `Device` and raw `Protocols` sockets. | [Mapper device]({{ site.baseurl }}/devices/mapper-device.html) |
| `Ossia.HTTP` | Parameter writes issue outgoing HTTP requests. | [HTTP device]({{ site.baseurl }}/devices/http-device.html) |
| `Ossia.WebSockets` | Connect to an existing WebSocket server and map its messages into a parameter tree. | [WebSocket device]({{ site.baseurl }}/devices/ws-device.html) |
| `Ossia.Serial` | Map a custom serial-port protocol into a parameter tree. | [Serial device]({{ site.baseurl }}/devices/serial-device.html) |

These root types are not interchangeable with the [Protocols transport API]({{ site.baseurl }}/reference/languages/qml-protocols.html). A raw socket does not create a device tree. In particular, `Protocols.http` has a different callback contract from `Ossia.HTTP`, and `Protocols.serial` uses a different framing configuration from `Ossia.Serial`. Neither the HTTP nor WebSocket device is score's [remote-control server]({{ site.baseurl }}/in-depth/remote.html).

## Device trees

`createTree()` returns an array of node descriptions. `children` nests nodes; a node can be a container or a typed parameter. A Mapper parameter does not need a binding to exist. For example:

```qml
import Ossia 1.0 as Ossia

Ossia.Mapper {
  function createTree() {
    return [{
      name: "node",
      children: [{ name: "sensor", type: Ossia.Type.Float }]
    }];
  }
}
```

With a device named `Mapper`, the parameter is `Mapper:/node/sensor`. Common metadata and types are below; `bind`, `read`, `write` and `interval` are Mapper-specific, while the other roots add their own request and receive callbacks.

### Tree node properties

Node descriptions use the following properties. The binding and generator fields apply to `Ossia.Mapper`, not automatically to the HTTP, WebSocket or Serial roots:

| Property | Type | Description |
|---|---|---|
| `name` | `string` | **Required.** The name of the parameter node. |
| `type` | `Ossia.Type.*` | The value type (see below). |
| `children` | `array` | Child nodes to create a tree hierarchy. |
| `bind` | `string` or `array` | Address(es) of other parameters to bind to. |
| `read` | `function` | Callback when a bound parameter changes, or when `interval` fires. |
| `write` | `function` | Callback when this parameter is written to. |
| `interval` | `number` | Polling interval in milliseconds (for generator use). |
| `value` | | Default value for the parameter. |
| `min` | | Minimum value for the domain. |
| `max` | | Maximum value for the domain. |
| `access` | `Ossia.Access.*` | Access mode: `Bi`, `Get`, or `Set`. |
| `bounding` | `Ossia.Bounding.*` | Bounding mode: `Free`, `Clip`, `Wrap`, `Fold`, `Low`, `High`. |
| `repetition_filter` | `Ossia.Repetitions.*` | `Unfiltered` or `Filtered`. |
| `unit` | `string` | Unit, e.g. `"color.rgba"`, `"position.cart2D"`. If set, `type` is inferred. |
| `description` | `string` | Human-readable description of the parameter. |
| `tags` | `array` | Array of string tags. |
| `extended_type` | `string` | Extended type information. |
| `disabled` | `bool` | If `true`, the parameter is disabled. |

### Value types

The `Ossia.Type` constants are:

| Constant | Description |
|---|---|
| `Ossia.Type.Float` | Floating-point number. |
| `Ossia.Type.Int` | 32-bit integer. |
| `Ossia.Type.Bool` | Boolean. |
| `Ossia.Type.String` | String. |
| `Ossia.Type.Vec2f` | 2D float vector. |
| `Ossia.Type.Vec3f` | 3D float vector. |
| `Ossia.Type.Vec4f` | 4D float vector. |
| `Ossia.Type.Impulse` | Impulse (no value). |
| `Ossia.Type.List` | List of values. |
| `Ossia.Type.Map` | Key-value map. |

## Mapper callbacks

Mapper runs continuously, even when timeline playback is stopped. Bindings are rebuilt when other devices become available or reconnect. Source updates change the Mapper value without automatically writing the same value back to the source; explicit writes to the Mapper follow its `write` rule or binding. Missing sources do not provide live values.

### Callback signatures

The `read` and `write` callbacks receive values as JS objects with a `.value` property:

```js
// read: called when a bound address changes
// - orig: the OSC address string of the source that changed
// - v: an object with a .value property
read: function(orig, v) { return v.value / 127.; }

// read (generator mode, no bind): called on each interval tick
// - no arguments
read: function() { return new Date().getSeconds(); }

// write: called when this mapper parameter is written to
// - v: an object with a .value property
write: function(v) { return v.value * 127.; }

// write returning address-value pairs (for unbound parameters):
write: function(v) {
  return [ { address: "foo:/bar", value: v.value } ];
}
```


A single `bind` address aliases that source parameter. An array of bindings makes `orig` identify the source that changed, for example `"/1/control/45"`, while `write(v)` returns one value per binding in order. With no `bind` or `read`, `write(v)` can return an array of `{ address, value }` pairs to route a write to addresses chosen at runtime. Lists contain typed elements: a list argument's first element is accessed as `v.value[0].value`; vector elements are bare numbers such as `v.value[0]`.

For a generator, omit `bind`, set `interval` in milliseconds, and return the generated value from `read()`. A QML `property var` can hold state shared between callbacks, such as two source values combined into a vector. See the [Mapper tutorials]({{ site.baseurl }}/devices/mapper-device.html#mapping-a-node-of-the-mapper-to-another) for aliases, scaling, multiple bindings, dynamic destinations, XY combinations and clock generators.

## Available context objects

Mapper scripts have access to `Device` for parameter reads, writes and tree edits, and `Protocols` for raw transport connections. The complete socket, framing, encoding, HTTP, OAuth, OSC and MIDI contract lives in the [QML transport API]({{ site.baseurl }}/reference/languages/qml-protocols.html).

## Device object

The `Device` object allows reading and writing values to any parameter across all devices in the current *score* document.

```js
// Read the current value of a parameter
let val = Device.read("OSCdevice:/sensor/x");

// Write a value to a parameter
Device.write("OSCdevice:/sensor/x", 0.5);

// Add a new parameter node to the mapper device
Device.addNode("/my/new/parameter", "float");

// Remove a parameter node
Device.removeNode("/my/new/parameter", "float");
```

Value conversion helpers:

```js
Device.asArray(v)  // Convert a value to an array
Device.asColor(v)  // Convert a value to a color (RGBA)
Device.asVec2(v)   // Convert a value to a Vec2
Device.asVec3(v)   // Convert a value to a Vec3
Device.asVec4(v)   // Convert a value to a Vec4
Device.toValue(v)  // Unwrap a typed { type, value } object into a plain JS value
```

`toValue` recursively unwraps typed list and map elements; an impulse becomes `undefined`, while an already unwrapped value is returned unchanged.


`Device.read(address)` reads a current parameter value; `Device.write(address, value)` writes one. In a Mapper, an unqualified address such as `"/foo"` refers to that Mapper's own tree; use `"DeviceName:/path"` for another device. `Device.addNode(address, type)` and `Device.removeNode(address, type)` edit only the script's own device tree. The second argument is a type string, as in the `"float"` examples above.

### Writing to the mapper's own nodes

This is useful when incoming network data or a timer should update a parameter exposed by the mapper itself:

```qml
import Ossia 1.0 as Ossia

Ossia.Mapper
{
  property var udpIn: Protocols.inboundUDP({
    Transport: { Port: 9000 },
    onMessage: function(bytes) {
      // Parse the raw bytes and write the result to the mapper's own node
      var val = parseInt(bytes);
      Device.write("/parsed_sensor", val);
    }
  })

  function createTree() {
    return [
      {
        name: "parsed_sensor",
        type: Ossia.Type.Int
      }
    ];
  }
}
```

### Writing to other devices

The mapper can push values to any device parameter known to *score*:

```qml
import Ossia 1.0 as Ossia

Ossia.Mapper
{
  function createTree() {
    return [
      {
        name: "trigger",
        type: Ossia.Type.Float,

        // When Mapper:/trigger is written to, forward the value
        // to two different devices at once
        write: function(v) {
          Device.write("Lights:/dimmer/1", v.value);
          Device.write("OSCdevice:/fx/intensity", v.value * 100);
        }
      }
    ];
  }
}
```

### Reading from other devices

Use `Device.read` to query the current value of any parameter:

```qml
import Ossia 1.0 as Ossia

Ossia.Mapper
{
  function createTree() {
    return [
      {
        name: "snapshot",
        type: Ossia.Type.Float,
        interval: 500,
        read: function() {
          // Poll a parameter from another device every 500ms
          return Device.read("OSCdevice:/sensor/temperature");
        }
      }
    ];
  }
}
```

### Combining Device reads and writes

A common pattern is to read several parameters, combine them, and write the result somewhere:

```qml
import Ossia 1.0 as Ossia

Ossia.Mapper
{
  function createTree() {
    return [
      {
        name: "average",
        type: Ossia.Type.Float,
        interval: 100,
        read: function() {
          var a = Device.read("SensorA:/value");
          var b = Device.read("SensorB:/value");
          var avg = (a + b) / 2.0;

          // Write the computed average to a light controller
          Device.write("Lights:/master", avg);

          // Also expose it on this mapper node
          return avg;
        }
      }
    ];
  }
}
```

### Reacting to incoming network data and dispatching to multiple devices

This example listens for OSC messages over UDP and routes them to different devices depending on the OSC address:

```qml
import Ossia 1.0 as Ossia

Ossia.Mapper
{
  property var oscParser: Protocols.osc({
    onOsc: function(address, args) {
      if(address === "/sensor/x")
        Device.write("Millumin:/millumin/layer/x/instance", args[0]);
      else if(address === "/sensor/y")
        Device.write("Millumin:/millumin/layer/y/instance", args[0]);
      else if(address === "/sensor/button")
        Device.write("/button_state", args[0]); // write to the mapper's own node
    }
  })

  property var udpIn: Protocols.inboundUDP({
    Transport: { Port: 7000 },
    onMessage: function(bytes) { oscParser.processMessage(bytes); }
  })

  function createTree() {
    return [
      { name: "button_state", type: Ossia.Type.Bool }
    ];
  }
}
```

## HTTP device API

Use `Ossia.HTTP` and `createTree()`. A parameter's `request` is a URL string or a function returning a URL; pushing a value to that parameter sends the request. `answer(body, value)` receives response text and the parameter's current value, then returns an array of device-local `{ address, value }` updates.

- A string `request` may contain `$val`, replaced by the sent value. A function `request(value)` receives a typed object such as `{ type: Ossia.Type.Int, value: 123 }`; construct a URL using `value.value` and escape query components with `encodeURIComponent`.
- Requests are GET by default. Set `method: "post"` and `requestData` (a string or function) for a POST body. This device's tree API is not a generic arbitrary-method/header client.
- `onRead(bytes)` or `onReadString(text)` receives chunks as they arrive. Chunk boundaries are not message boundaries, and these callbacks consume reply data; do not assume a subsequent `answer` also receives the complete body.
- No automatic polling interval is implied by a tree entry. Schedule requests from the score or your script when required.

For arbitrary HTTP methods, custom headers, status codes or bearer authorization, use the [object form of `Protocols.http`]({{ site.baseurl }}/reference/languages/qml-protocols.html#http-requests), for example in a Mapper. Keep credentials out of shared scores. See the [HTTP setup example]({{ site.baseurl }}/devices/http-device.html#setup) for a complete request/answer tree.

## WebSocket device API

Use `Ossia.WebSockets` and `createTree()`. The root `host` property can supply the server address, for example `property string host: "ws://127.0.0.1:8080"`.

| Callback / property | Contract |
|---|---|
| `onConnected()` | Called on connection; returns device-local `{ address, value }` updates. |
| `onDisonnected()` | Called on disconnection; returns tree updates. The spelling deliberately preserves the implementation's missing “c”. |
| `onMessage(message)` | Receives a server message; return an array of `{ address, value }` updates. Parse JSON explicitly if needed. |
| Parameter `request(value)` | Receives a typed object such as `{ type: Ossia.Type.Int, value: 123 }`; its return value is sent when not `undefined`. |
| Parameter `request` string | Sends text, replacing `$val` with the parameter value. |
| Parameter `openListening()` / `closeListening()` | Called when score starts / stops listening on the node; return a remote message when needed, or `undefined` to send nothing. |
| Root `processFromJson: true` | Match incoming JSON against the declared tree and update parameters in C++; replaces manual `onMessage` handling for that path. It does not discover an API or create the tree. |

A function-valued `request` currently sends a **binary WebSocket message**, whereas a string-valued `request` sends text. The peer must accept the corresponding message kind. The connection, disconnection and receive callbacks return local updates, not arbitrary remote commands. For explicit text/binary receive callbacks or a listening server, use [Protocols WebSockets]({{ site.baseurl }}/reference/languages/qml-protocols.html#websockets).

The [WebSocket device tutorial]({{ site.baseurl }}/devices/ws-device.html#sample-code) includes a complete road-traffic server/client and the user-library script for generating a tree from sample JSON.

## Serial device API

Use `Ossia.Serial` and `createTree()` to define the initial tree. Select the actual port and baud rate in the [Serial device dialog]({{ site.baseurl }}/devices/serial-device.html#connection-and-framing). The root callbacks below return arrays of device-local `{ address, value }` updates.

### Receiving serial data

Choose one receive callback rather than declaring all three: the implementation gives `onMessage` precedence over `onBinary`, and `onBinary` over `onRead`.

| Callback | Input and behavior |
|---|---|
| `onMessage(message)` | A framed text message as a string. |
| `onBinary(message)` | A framed binary message as an ArrayBuffer. |
| `onRead(bytes)` | Raw available bytes as an ArrayBuffer, with no framing; reconstruct messages in the script. Incoming chunk boundaries are not message boundaries. |

For example, a text callback can parse a sensor value:

```js
function onMessage(message) {
  console.log(message);
  return [{ address: "/sensor", value: parseInt(message) }];
}
```

A binary or raw callback instead reads the bytes of its buffer, for example `new Uint8Array(message)` or `new Uint8Array(bytes)`, and returns the same update shape. Do not install a text callback when choosing the raw receive path.

### Serial framing

Framing is configured on the root, not in a `Protocols` configuration object:

```qml
property string framing: "delimiter"
property string delimiter: "\r\n"
```

Recognized names are:

| `framing` | Meaning |
|---|---|
| `"delimiter"` | Delimiter-terminated messages; set `delimiter` explicitly, e.g. `"\r\n"` or `"\n\n"`. |
| `"slip"` | SLIP framing. |
| `"osc-slip"` | SLIP framing with OSC message handling. |
| `"size"` | Each message starts with a big-endian 32-bit size prefix. |

Do not use `"none"` or `"cobs"` as an assumed raw-framing mode: unrecognized names take the parser's fallback branch. For raw input and output, choose `onRead` without `onMessage` or `onBinary`; the parser then disables framing. The [OSC device's serial COBS transport]({{ site.baseurl }}/devices/osc-device.html#transports-and-framing) and the [raw `Protocols.serial` factory]({{ site.baseurl }}/reference/languages/qml-protocols.html#serial-sockets) are separate configuration paths.

### Serial requests and listening

A tree node's `request` customizes outgoing data:

- A string is sent when the parameter receives a message from score; `$val` is textually replaced with the value.
- A function with no arguments can generate a request, e.g. `request: () => Math.random() + " foo "`.
- A function `request(val)` receives `{ value, type }`, for example `request: (val) => val.value + " foo "`.
- Without `request`, a numeric parameter is written textually to the port.

The root also accepts `openListening(address)` and `closeListening(address)`, called when score needs to start or stop actively listening for changes on an address.

### Writing binary data

By default, the values returned from `request` in the device tree are treated as strings and will be written to the serial port in textual, ASCII format. For instance, an "int" parameter with value 123 will cause the actual integer to be written textually in the serial port: 123 as the bytes `0x31 0x32 0x33`, and not the single-byte value for 123, `0x7B`.

If one wants actual binary data to be written, it is necessary to use a Javascript Typed Array, such as Uint8Array.
Note that in this case the framing also must be handled manually, to enable for more control.

Here is an example which will write a single byte delimited by `\r\n`. 

```js
{
  name: "request",
  type: Ossia.Type.Int,
  access: Ossia.Access.Set,
  min: 0,
  max: 127,
  request: (val) => {
        let auint8 = new ArrayBuffer(3);
        let uint8 = new Uint8Array(auint8);
        uint8[0] = val.value; // An integer between 0 and 127
        uint8[1] = 0x0D; // CR
        uint8[2] = 0x0A; // LF
        return auint8;
  }
}
```

### OSC support

If the target device reads OSC natively on its serial port, it is possible to implement support for it quite easily: 

```qml
import Ossia 1.0 as Ossia

Ossia.Serial
{
  function createTree() 
  {
    return [ 
      {
        name: "foo",
        type: Ossia.Type.Int,
        access: Ossia.Access.Set,
        osc_address: "/foo"
      },
      {
        name: "foo_but_as_list",
        type: Ossia.Type.List,
        access: Ossia.Access.Set,
        osc_address: "/foo"
      }
    ]; 
  }
}
```

In the above case, sending messages to `foo` and `foo_but_as_list` will both be translated directly as OSC messages, for instance `/foo 1` or `/foo 10 "blah" True`.

If setting `extended_type` to for instance `u8Blob` then a list would be translated in a blob containing a sequence of u8 values.

### Coalescing messages

In case the serial port is too slow and overflows, one can add the property: 

```
property real coalesce: 15
```

to the Serial object, to coalesce messages every 15 milliseconds for instance.

If a specific parameter must *not* be coalesced, but always sent, one can simply set `critical: true` on the node.
One will generally want to use coalescing on parameters such as lights, drives, or anything that more-or-less maps to an electrical voltage, and not for parameters that would trigger the start of an action.

In case messages use the OSC feature, then non-critical messages will get coalesced as a single bundle.

## Sources and runtime scope

The device roots are Qt/QML integrations; available backends depend on score's build and platform. QML validation only proves that the component can load, not that an external device or API is reachable. The setup pages above cover connection diagnostics and hardware requirements.

Source: libossia's [`qml_engine_functions.hpp`](https://github.com/ossia/libossia/blob/master/src/ossia-qt/qml_engine_functions.hpp), [`qml_context.hpp`](https://github.com/ossia/libossia/blob/master/src/ossia-qt/qml_context.hpp), [`qml_plugin.cpp`](https://github.com/ossia/libossia/blob/master/src/ossia-qt/qml_plugin.cpp), [`http_protocol.hpp`](https://github.com/ossia/libossia/blob/master/src/ossia-qt/http/http_protocol.hpp), [`ws_generic_client_protocol.cpp`](https://github.com/ossia/libossia/blob/master/src/ossia-qt/websocket-generic-client/ws_generic_client_protocol.cpp), and [`serial_protocol.cpp`](https://github.com/ossia/libossia/blob/master/src/ossia-qt/serial/serial_protocol.cpp).
