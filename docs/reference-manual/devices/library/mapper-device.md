---
layout: default

title: Mapper device
description: "A device for mapping and combining other device's inputs / outputs"

parent: Devices
grand_parent: Reference

permalink: /devices/mapper-device.html
---

![Device setup window]({{ site.img }}/reference/devices/mapper-device.png "score device setup")

# Mapper device

The mapper device allows mapping the parameters between devices directly.  It will operate permanently, even when the score is not running.

Like other devices such as Serial, HTTP and WebSockets, it is defined in Javascript within a QML script.
The basic form is:

```qml
import Ossia 1.0 as Ossia

Ossia.Mapper
{
  function createTree() {
    return [
      {
        name: "node",
        children: [
          {
            name: "sensor"
          }
        ]
      }
    ]
  }
}
```

This does nothing interesting and only creates a tree with a single address: `Mapper:/node/sensor`


## Mapping a node of the mapper to another

This is useful to give for instance an user-readable name to another parameter. For instance, to give a name to a specific MIDI CC: 

```qml
import Ossia 1.0 as Ossia

Ossia.Mapper
{
  function createTree() {
    return [
      {
        name: "node",
        children: [
          {
            name: "sensor",
            bind: "MidiDevice:/1/control/45",
            type: Ossia.Type.Int
          }
        ]
      }
    ]
  }
}
```
Which gives: 

![Mapper example]({{ site.img }}/reference/devices/mapper/mapper1.gif "Mapper binding")

The mapping is bidirectional: 

- When `MidiDevice:/1/control/45` receives a message, it is written to `Mapper:/node/sensor`
- When `Mapper:/node/sensor` receives a message, it is written to `MidiDevice:/1/control/45`

## Custom mappings with Javascript expressions

If one wants to transform the value, for instance to rescale it, it is possible to use small JS snippets:

```qml
import Ossia 1.0 as Ossia

Ossia.Mapper
{
  function createTree() {
    return [
      {
        name: "node",
        children: [
          {
            name: "sensor",
            bind: "MidiDevice:/1/control/45",
            type: Ossia.Type.Float,
            
            // What happens when the bound parameter (MidiDevice:/1/control/45) is written to:
            //
            // When MidiDevice:/1/control/45 receives the value 64, 
            // Mapper:/node/sensor will get the value 64 / 127, roughly 0.5.
            read: function(orig, v) { return v.value / 127.; },

            // What happens when the mapper parameter (Mapper:/node/sensor) is written to:
            //
            // When Mapper:/node/sensor receives the value 0.5, 
            // MidiDevice:/1/control/45 will get the value 0.5 * 127, roughly 64.
            write: function(v) { return v.value * 127.; }
          }
        ]
      }
    ]
  }
}
```

This example will scale the 0-127 integer values of the MIDI CC to 0-1 floating point values for the Mapper.

Example:

![Mapper example]({{ site.img }}/reference/devices/mapper/mapper2.gif "Mapper binding with transforms")

## Binding to multiple parameters

`bind:` can be an array.


```qml
import Ossia 1.0 as Ossia

Ossia.Mapper
{
  function createTree() {
    return [
      {
        name: "node",
        children: [
          {
            name: "sensor",
            bind: ["MidiDevice:/1/control/45", "MidiDevice:/1/control/55"],
            type: Ossia.Type.Float,
            
            // The first parameter, `orig` is the OSC address of the parameter which 
            // was changed: it will be either "/1/control/45" or "/1/control/55".
            // The second parameter is the value.
            read: function(orig, v) { return v.value / 127.; },

            // Here we now return an array of values, one for each address:
            // for instance, if a message "0.5" is sent to Mapper:/node/sensor from within score,
            // - MidiDevice:/1/control/45 will get 0.5 * 127
            // - MidiDevice:/1/control/55 will get 0
            write: function(v) { return [v.value * 127., 0]; }
          }
        ]
      }
    ]
  }
}
```

## Writing to arbitrary parameters

Sometimes one may want to map an address to another only known at run-time, depending on a message.
For instance, imagine a case where you want to send messages `[channel, value]` to control varying MIDI channels at run-time, e.g. sending the list message `[12, 45, 127]` to `Mapper:/node/sensor` should write the CC value 127 to the CC 45 on MIDI channel 12, e.g. at the address `MidiDevice:/12/control/45`. 

This can be done by returning a list of address-value pairs from `write`:
```qml
[ { address: "foo:/bar", value: 123 }, etc... ]
```

In this case one must not set `bind:` or `read:` as they do not make sense: 

Example:

```qml
import Ossia 1.0 as Ossia

Ossia.Mapper
{
  function createTree() {
    return [
      {
        name: "node",
        children: [
          {
            name: "sensor",
            type: Ossia.Type.List,
            
            // What happens when the mapper parameter (Mapper:/node/sensor) is written to
            write: (v) => {
              // If v is [12, 45, 127], this gives: 
              // MidiDevice:/12/control/45
              let addr = `MidiDevice:/${v.value[0].value}/control/${v.value[1].value}`
              return [ { address: addr, value : v.value[2].value } ];
            }
          }
        ]
      }
    ]
  }
}
```

## Mapping and combining values from multiple addresses

To do this, one can simply add a custom member to the QML object.
For instance, here we combine two distinct addresses which represent an XY coordinate, in a single parameter of type Vec2.

```qml
import Ossia 1.0 as Ossia

Ossia.Mapper
{
  // Our custom member which will contain the current value for the address.
  property var xy: [0.0, 0.0]

  function createTree() {
    return [
      {
        name: "node",
        children: [
          {
            name: "sensor",
            bind: ["Millumin:/millumin/layer/x/instance", "Millumin:/millumin/layer/y/instance"],
            type: Ossia.Type.Vec2f,
            
            read: function(orig, v) {
              // Assign to xy depending on the origin
              if(orig === "/millumin/layer/x/instance")
                xy[0] = v.value;
              if(orig === "/millumin/layer/y/instance")
                xy[1] = v.value;
              
              return xy; 
            },

            // Write to the correct addresses. "v.value" is a Vec2, so two floats directly
            write: (v) => { 
              return [v.value[0], v.value[1]]; 
            }
          }
        ]
      }
    ]
  }
}
```


## Using the mapper device as a generator

The device provides an easy way to create generic generative devices with Javascript.

Here is a simple example which creates a device which gives the time.
The `interval:` property is used to define at which granularity in milliseconds the parameters will be polled.

```qml
import Ossia 1.0 as Ossia

Ossia.Mapper
{
  function createTree() {
    return [
      {
        name: "hours",
        type: Ossia.Type.Int,
        interval: 1000, // The read function() will be called every 1000 millisecond (every second)
        read: function() {
          return new Date().getHours();
        }
      },
      {
        name: "minutes",
        type: Ossia.Type.Int,
        interval: 1000,
        read: function() {
          return new Date().getMinutes();
        }
      },
      {
        name: "seconds",
        type: Ossia.Type.Int,
        interval: 200,
        read: function() {
          return new Date().getSeconds();
        }
      }
    ];
  }
}
```

## Using the Protocols object

The Mapper device scripts have access to a `Protocols` object which provides low-level networking primitives directly from QML. This allows the Mapper to communicate with external systems over UDP, TCP, WebSockets, Unix sockets, HTTP, and MIDI, going beyond the simple parameter binding mechanism.

### UDP sockets

Send raw bytes over UDP:

```qml
import Ossia 1.0 as Ossia

Ossia.Mapper
{
  property var udpSocket

  function createTree() {
    // Open an outbound UDP socket
    udpSocket = Protocols.outboundUDP({
      Transport: { Host: "127.0.0.1", Port: 9000 }
    });

    return [
      {
        name: "send",
        type: Ossia.Type.String,
        write: function(v) {
          udpSocket.write(v.value);
        }
      }
    ];
  }
}
```

Listen for incoming UDP messages:

```qml
import Ossia 1.0 as Ossia

Ossia.Mapper
{
  function createTree() {
    Protocols.inboundUDP({
      Transport: { Bind: "0.0.0.0", Port: 7000 },
      onMessage: function(bytes) {
        console.log("Received:", bytes);
      }
    });

    return [];
  }
}
```

The `Broadcast` option can be set to `true` in the Transport configuration for outbound UDP to enable broadcast sends.

### TCP sockets

Connect to a TCP server:

```qml
import Ossia 1.0 as Ossia

Ossia.Mapper
{
  property var tcpSocket

  function createTree() {
    tcpSocket = Protocols.outboundTCP({
      Transport: { Host: "127.0.0.1", Port: 5000 },
      onOpen: function(socket) {
        console.log("Connected!");
        socket.write("hello");
      },
      onClose: function() { console.log("Disconnected"); },
      onFail: function() { console.log("Connection failed"); }
    });

    return [];
  }
}
```

Create a TCP server and accept connections:

```qml
import Ossia 1.0 as Ossia

Ossia.Mapper
{
  function createTree() {
    Protocols.inboundTCP({
      Transport: { Bind: "0.0.0.0", Port: 5000 },
      onOpen: function() { console.log("Server started"); },
      onConnection: function(socket) {
        console.log("New client connected");
        socket.onClose = function() { console.log("Client disconnected"); };
        socket.receive(function(bytes) {
          console.log("Received:", bytes);
        });
      },
      onClose: function() { console.log("Server closed"); }
    });

    return [];
  }
}
```

### WebSockets

Connect to a WebSocket server:

```qml
import Ossia 1.0 as Ossia

Ossia.Mapper
{
  property var ws

  function createTree() {
    ws = Protocols.outboundWS({
      Transport: { Host: "127.0.0.1", Port: 8080 },
      onTextMessage: function(msg) { console.log("Text:", msg); },
      onBinaryMessage: function(msg) { console.log("Binary:", msg); }
    });

    return [];
  }
}
```

Create a WebSocket server:

```qml
import Ossia 1.0 as Ossia

Ossia.Mapper
{
  function createTree() {
    Protocols.inboundWS({
      Transport: { Bind: "0.0.0.0", Port: 8080 },
      onConnection: function(socket) {
        console.log("Client connected");
      }
    });

    return [];
  }
}
```

### Unix sockets (Linux / macOS)

On systems that support Unix domain sockets, datagram and stream variants are available:

```qml
// Outbound datagram
Protocols.outboundUnixDatagram({ Transport: { Path: "/tmp/my_socket" } });

// Inbound datagram
Protocols.inboundUnixDatagram({
  Transport: { Path: "/tmp/my_socket" },
  onMessage: function(bytes) { console.log(bytes); }
});

// Outbound stream
Protocols.outboundUnixStream({ Transport: { Path: "/tmp/my_socket" } });

// Inbound stream (server)
Protocols.inboundUnixStream({
  Transport: { Path: "/tmp/my_socket" },
  onConnection: function(socket) { /* ... */ }
});
```

### HTTP requests

Perform HTTP requests:

```qml
import Ossia 1.0 as Ossia

Ossia.Mapper
{
  function createTree() {
    return [
      {
        name: "fetch",
        type: Ossia.Type.String,
        interval: 5000,
        read: function() {
          Protocols.http(
            "http://api.example.com/data",
            function(response) { console.log(response); },
            "GET"
          );
        }
      }
    ];
  }
}
```

The third argument is the HTTP verb (`"GET"`, `"POST"`, etc.).

### OSC message parsing

The `Protocols.osc` function creates an OSC message processor that can decode raw OSC bytes received from a UDP or other socket:

```qml
import Ossia 1.0 as Ossia

Ossia.Mapper
{
  function createTree() {
    var oscParser = Protocols.osc({
      onOsc: function(address, args) {
        console.log("OSC:", address, args);
      }
    });

    Protocols.inboundUDP({
      Transport: { Port: 9000 },
      onMessage: function(bytes) {
        oscParser.processMessage(bytes);
      }
    });

    return [];
  }
}
```

### MIDI

List available MIDI ports and open them directly:

```qml
import Ossia 1.0 as Ossia

Ossia.Mapper
{
  function createTree() {
    // List available MIDI input and output ports
    var inputs = Protocols.inboundMIDIDevices();
    var outputs = Protocols.outboundMIDIDevices();

    for(var i = 0; i < inputs.length; i++)
      console.log("Input:", JSON.stringify(inputs[i]));

    // Open the first available input
    if(inputs.length > 0) {
      Protocols.inboundMIDI({
        Transport: inputs[0],
        onMessage: function(bytes) {
          console.log("MIDI in:", bytes);
        }
      });
    }

    // Open the first available output
    if(outputs.length > 0) {
      var midiOut = Protocols.outboundMIDI({
        Transport: outputs[0]
      });
      // midiOut.write(...) can be used to send MIDI bytes
    }

    return [];
  }
}
```

MIDI 2.0 (UMP) equivalents are also available: `Protocols.inboundUMPDevices()`, `Protocols.outboundUMPDevices()`, `Protocols.inboundUMP(...)`, and `Protocols.outboundUMP(...)`.

### Common socket callbacks

All socket types support these callbacks in their configuration object:

| Callback | Description |
|---|---|
| `onOpen` | Called when the connection is established. For outbound TCP/WS, receives the socket object as argument. |
| `onClose` | Called when the connection is closed. |
| `onError` | Called when an error occurs. |
| `onMessage` | Called when data is received (inbound UDP, Unix datagram, MIDI). |
| `onConnection` | Called when a client connects (inbound TCP, WS, Unix stream). Receives the client socket. |
| `onTextMessage` | Called on text WebSocket messages (outbound WS). |
| `onBinaryMessage` | Called on binary WebSocket messages (outbound WS). |

All outbound sockets expose a `write(...)` method to send data.

## Reference

### Available context objects

Mapper device scripts have access to the following global objects:

| Object | Description |
|---|---|
| `Device` | Read and write parameters on any device in the current document. |
| `Protocols` | Create raw network sockets (UDP, TCP, WebSocket, Unix, MIDI) and perform HTTP requests. |

### Device object

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
Device.toValue(v)  // Convert a JS value to an ossia value
```

### Protocols object

#### Socket functions

| Function | Transport config | Description |
|---|---|---|
| `Protocols.outboundUDP(config)` | `Host`, `Port`, `Broadcast` | Send UDP datagrams. |
| `Protocols.inboundUDP(config)` | `Bind`, `Port` | Receive UDP datagrams. |
| `Protocols.outboundTCP(config)` | `Host`, `Port` | Connect to a TCP server. |
| `Protocols.inboundTCP(config)` | `Bind`, `Port` | Listen for TCP connections. |
| `Protocols.outboundWS(config)` | `Host`, `Port` | Connect to a WebSocket server. |
| `Protocols.inboundWS(config)` | `Bind`, `Port` | Listen for WebSocket connections. |
| `Protocols.outboundUnixDatagram(config)` | `Path` | Send Unix datagrams (Linux/macOS). |
| `Protocols.inboundUnixDatagram(config)` | `Path` | Receive Unix datagrams (Linux/macOS). |
| `Protocols.outboundUnixStream(config)` | `Path` | Connect to a Unix stream socket (Linux/macOS). |
| `Protocols.inboundUnixStream(config)` | `Path` | Listen on a Unix stream socket (Linux/macOS). |

#### MIDI functions

| Function | Description |
|---|---|
| `Protocols.inboundMIDIDevices()` | List available MIDI input ports. |
| `Protocols.outboundMIDIDevices()` | List available MIDI output ports. |
| `Protocols.inboundMIDI(config)` | Open a MIDI input port. |
| `Protocols.outboundMIDI(config)` | Open a MIDI output port. |
| `Protocols.inboundUMPDevices()` | List available MIDI 2.0 (UMP) input ports. |
| `Protocols.outboundUMPDevices()` | List available MIDI 2.0 (UMP) output ports. |
| `Protocols.inboundUMP(config)` | Open a MIDI 2.0 (UMP) input port. |
| `Protocols.outboundUMP(config)` | Open a MIDI 2.0 (UMP) output port. |

#### Other functions

| Function | Description |
|---|---|
| `Protocols.http(url, callback, verb)` | Perform an HTTP request. `verb` is `"GET"`, `"POST"`, etc. |
| `Protocols.osc(config)` | Create an OSC message parser. Set `onOsc` callback, call `.processMessage(bytes)`. |

### Tree node properties

Each object returned by `createTree()` supports the following properties:

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
| `access` | `Ossia.access.*` | Access mode: `Bi`, `Get`, or `Set`. |
| `bounding` | `Ossia.bounding.*` | Bounding mode: `Free`, `Clip`, `Wrap`, `Fold`, `Low`, `High`. |
| `repetition_filter` | `Ossia.repetition_filter.*` | `Unfiltered` or `Filtered`. |
| `unit` | `string` | Unit, e.g. `"color.rgba"`, `"position.cart2D"`. If set, `type` is inferred. |
| `description` | `string` | Human-readable description of the parameter. |
| `tags` | `array` | Array of string tags. |
| `extended_type` | `string` | Extended type information. |
| `disabled` | `bool` | If `true`, the parameter is disabled. |

### Value types (`Ossia.Type`)

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
