---
layout: default
title: QML transport API
description: "Protocols sockets, framing, encoding, HTTP, OAuth, OSC and MIDI"
parent: Languages
grand_parent: Reference
permalink: /reference/languages/qml-protocols.html
---

# QML transport API

Use `Protocols` in the console or a [Mapper device]({{ site.baseurl }}/devices/mapper-device.html) when an external API cannot be expressed by a standard device. Mapper QML declares the device tree, then translates transport messages into `Device.write` calls. The [HTTP device]({{ site.baseurl }}/devices/http-device.html) and [WebSocket device]({{ site.baseurl }}/devices/ws-device.html) have their own `Ossia.HTTP` / `Ossia.WebSockets` tree conventions; do not mix their callbacks with raw socket callbacks below.

Backends depend on the platform and compile-time features. Keep the returned socket in a variable/property for as long as it is needed, and implement `onError` to diagnose connection failures. Opening is asynchronous; send initial data from `onOpen(socket)`, not immediately after calling the factory.

## Transport selection

Factory names below are members of `Protocols`; transport keys are case-sensitive.

| Factory | Configuration / receive path |
|---|---|
| `outboundUDP(config)` | `Transport: { Host, Port, Broadcast }`; call `write(data)`. Set `Broadcast: true` to enable broadcast sends. |
| `inboundUDP(config)` | `Transport: { Bind, Port }`; `onMessage(bytes)`. |
| `outboundTCP(config)` | `Transport: { Host, Port }`; `onMessage(bytes)` for received data. |
| `inboundTCP(config)` | `Transport: { Bind, Port }`; `onConnection(connection)`, then `connection.receive(callback)` and `connection.write(data)`. |
| `outboundWS(config)` | `Transport: { Host, Port }`; `onTextMessage(text)` and `onBinaryMessage(bytes)`. |
| `inboundWS(config)` | `Transport: { Bind, Port }`; handle connections with `onConnection`. |
| `outboundUnixDatagram`, `inboundUnixDatagram`, `outboundUnixStream`, `inboundUnixStream` | `Transport: { Path }`; require local-socket support, normally Linux/macOS. |
| `serial(config)` | `Transport: { Port, Baud, DataBits, FlowControl, Parity, StopBits }`; `Port` is a device path/name, not a UDP port. |

Common socket lifecycle callbacks are `onOpen`, `onClose` and `onError`. `onError` is the preferred spelling; older UDP/TCP/Unix/WebSocket configurations may use `onFail`. If both are supplied, `onError` wins.

```js
var connection = Protocols.outboundTCP({
  Transport: { Host: "127.0.0.1", Port: 5000 },
  Framing: { type: "line", delimiter: "\r\n" },
  onOpen: function(socket) { socket.write("STATUS"); },
  onMessage: function(bytes) { console.log(bytes.toString()); },
  onError: function(error) { console.log(error); }
});
```

This example expects a server with a CRLF-delimited command protocol on port 5000. The framing layer adds/removes the delimiter; do not append it a second time.

## Framing and encoding are different

TCP and serial are byte streams: one received chunk is not necessarily one message. `Framing` determines message boundaries; `Encoding` converts payload bytes to/from text. Use the settings required by the **other endpoint**, not an arbitrary combination.

Framing configuration uses lower-case keys:

- `{ type: "line", delimiter: "\r\n" }`: delimiter-terminated messages; omitted delimiter means newline.
- `{ type: "slip" }`, `{ type: "cobs" }`, `{ type: "stx_etx" }`: protocol-specific byte framing.
- `{ type: "size_prefix", bytes: 4, endian: "big" }`: length prefix. Supported widths are 1, 2 and 4 bytes; 4-byte big-endian is the default, and `"little"` selects little-endian where applicable.
- `{ type: "fixed_length", size: 64 }`: fixed-size receive frames, particularly useful for serial protocols.
- Omit `Framing` for raw chunks; your code must then accumulate/parse partial messages.

`Encoding: { type: "base64" }` supports Base64; alternatives are `ascii85`, `hex`, `intel_hex` (alias `ihex`) and `srec` (aliases `s_record`, `motorola`). Encoding is optional and is not encryption. UDP already supplies datagram boundaries; WebSocket already distinguishes complete text and binary messages. Do not assume every framing option applies to these transports.

## HTTP requests

Use the object form for methods, headers, JSON bodies and status codes:

```js
Protocols.http({
  url: "http://127.0.0.1:8080/api/level",
  verb: "POST",
  headers: { "Content-Type": "application/json" },
  body: JSON.stringify({ level: 0.5 }),
  onResponse: function(status, body) { console.log(status, body); },
  onError: function(message) { console.log(message); }
});
```

The endpoint must exist and accept this request. Headers can carry service-specific authentication such as `Authorization: "Bearer " + token`. Do not print or embed production tokens in shared scores. The older `Protocols.http(url, callback, "GET")` form provides a simpler body callback; use the object form when you need a complete request contract.

## OAuth

`import Ossia 1.0 as Ossia` exposes `Ossia.OAuth` **only when score is built with Qt NetworkAuth and a Qt version newer than 6.10.0**. It implements an OAuth2 authorization-code flow, not a universal credential store.

Configure `clientIdentifier`, optionally `clientIdentifierSharedKey`, `authorizationUrl`, `accessTokenUrl` and `requestedScopeTokens` for the actual service. Call `grant()` to start authorization, react to `granted` or `requestFailed(error)`, and use the `accessToken` property. Registration with the service and its redirect requirements remain necessary; a client ID from a different application is not a portable example.

The object also exposes `send(verb, url, config, callback)`: `config.headers` supplies custom headers and a string `config.body` supplies a raw body; authorization is added by the OAuth object. Its callback is `function(result, error)`, **not** the `Protocols.http` status/body callback. Errors expose `code`, `message` and `body`. This implementation evaluates successful response text to convert structured data, so use it only with trusted services and responses.

## Socket callbacks

Socket factories return objects, not parameter trees. Keep the object alive in a QML property or JavaScript variable. Callback availability depends on the transport:

| Callback | Receive contract |
|---|---|
| `onOpen(socket)` | Connection established; outbound TCP/WS provide the socket for initial writes. |
| `onClose()` | Connection closed. |
| `onError(error)` | Connection or transport error; preferred over the older `onFail` spelling. |
| `onMessage(bytes)` | Received bytes for UDP, TCP, Unix, serial and MIDI receive paths. |
| `onConnection(connection)` | Accepted TCP, WS or Unix stream client. |
| `onTextMessage(text)` | Outbound WebSocket text message. |
| `onBinaryMessage(bytes)` | Outbound WebSocket binary message. |

Outbound sockets expose `write(data)`. For accepted TCP and Unix stream clients, register `connection.receive(callback)` and send with `connection.write(data)`; see the server example below. Do not substitute the device-tree callbacks of `Ossia.WebSockets`, `Ossia.HTTP` or `Ossia.Serial` for these callbacks: those root types are documented in the [QML device API]({{ site.baseurl }}/reference/languages/qml-devices.html#root-types).

## Transport examples

These QML examples use `Ossia.Mapper` to keep their sockets alive. Add a [Mapper device]({{ site.baseurl }}/devices/mapper-device.html) to run them; the remote endpoint or hardware must implement the corresponding protocol.

### UDP sockets

Send raw bytes over UDP:

```qml
import Ossia 1.0 as Ossia

Ossia.Mapper
{
  // Open an outbound UDP socket as a QML property
  property var udpSocket: Protocols.outboundUDP({
    Transport: { Host: "127.0.0.1", Port: 9000 }
  })

  function createTree() {
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
  property var udpIn: Protocols.inboundUDP({
    Transport: { Bind: "0.0.0.0", Port: 7000 },
    onMessage: function(bytes) {
      console.log("Received:", bytes);
    }
  })

  function createTree() {
    return [];
  }
}
```

### TCP sockets

Connect to a TCP server:

```qml
import Ossia 1.0 as Ossia

Ossia.Mapper
{
  property var tcpSocket: Protocols.outboundTCP({
    Transport: { Host: "127.0.0.1", Port: 5000 },
    onOpen: function(socket) {
      console.log("Connected!");
      socket.write("hello");
    },
    onClose: function() { console.log("Disconnected"); },
    onError: function(error) { console.log("Connection failed:", error); }
  })

  function createTree() {
    return [];
  }
}
```

Create a TCP server and accept connections:

```qml
import Ossia 1.0 as Ossia

Ossia.Mapper
{
  property var tcpServer: Protocols.inboundTCP({
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
  })

  function createTree() {
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
  property var ws: Protocols.outboundWS({
    Transport: { Host: "127.0.0.1", Port: 8080 },
    onTextMessage: function(msg) { console.log("Text:", msg); },
    onBinaryMessage: function(msg) { console.log("Binary:", msg); }
  })

  function createTree() {
    return [];
  }
}
```

Create a WebSocket server:

```qml
import Ossia 1.0 as Ossia

Ossia.Mapper
{
  property var wsServer: Protocols.inboundWS({
    Transport: { Bind: "0.0.0.0", Port: 8080 },
    onConnection: function(socket) {
      console.log("Client connected");
    }
  })

  function createTree() {
    return [];
  }
}
```

### Unix sockets

On systems that support Unix domain sockets (normally Linux/macOS), datagram and stream variants are available:

```qml
import Ossia 1.0 as Ossia

Ossia.Mapper
{
  // Outbound datagram
  property var unixOut: Protocols.outboundUnixDatagram({
    Transport: { Path: "/tmp/my_socket" }
  })

  // Inbound datagram
  property var unixIn: Protocols.inboundUnixDatagram({
    Transport: { Path: "/tmp/my_socket" },
    onMessage: function(bytes) { console.log(bytes); }
  })

  // Outbound stream
  property var unixStreamOut: Protocols.outboundUnixStream({
    Transport: { Path: "/tmp/my_stream" }
  })

  // Inbound stream (server)
  property var unixStreamIn: Protocols.inboundUnixStream({
    Transport: { Path: "/tmp/my_stream" },
    onConnection: function(socket) {
      socket.receive(function(bytes) { console.log("Unix stream:", bytes); });
    }
  })

  function createTree() { return []; }
}
```

### Periodic HTTP requests

The older `Protocols.http(url, callback, verb)` form invokes `callback(body)` without a status argument. This Mapper example schedules a request every five seconds; the asynchronous callback logs the response rather than returning it as the parameter value:

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

`Protocols.osc({ onOsc: function(address, args) { ... } })` only creates a parser: `processMessage(bytes)` feeds a packet into it and does not itself open an OSC socket.

The `Protocols.osc` function creates an OSC message processor that can decode raw OSC bytes received from a UDP or other socket:

```qml
import Ossia 1.0 as Ossia

Ossia.Mapper
{
  property var oscParser: Protocols.osc({
    onOsc: function(address, args) {
      console.log("OSC:", address, args);
    }
  })

  property var udpIn: Protocols.inboundUDP({
    Transport: { Port: 9000 },
    onMessage: function(bytes) {
      oscParser.processMessage(bytes);
    }
  })

  function createTree() {
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
  // List available MIDI input and output ports
  property var midiInputs: Protocols.inboundMIDIDevices()
  property var midiOutputs: Protocols.outboundMIDIDevices()

  // Open the first available input (if any)
  property var midiIn: midiInputs.length > 0
    ? Protocols.inboundMIDI({
        Transport: midiInputs[0],
        onMessage: function(bytes) {
          console.log("MIDI in:", bytes);
        }
      })
    : null

  // Open the first available output (if any)
  property var midiOut: midiOutputs.length > 0
    ? Protocols.outboundMIDI({ Transport: midiOutputs[0] })
    : null

  function createTree() {
    // midiOut.write(...) can be used to send MIDI bytes
    return [];
  }
}
```

MIDI 2.0 (UMP) equivalents are also available: `Protocols.inboundUMPDevices()`, `Protocols.outboundUMPDevices()`, `Protocols.inboundUMP(...)`, and `Protocols.outboundUMP(...)`.

Pass the port identifier returned by enumeration as `Transport`. Backend support and connected hardware determine which ports exist; never assume element zero is available.

### Serial sockets

`Protocols.serial(config)` opens a low-level serial socket. `Transport` accepts `Port`, `Baud`, `DataBits`, `FlowControl`, `Parity` and `StopBits`; `Port` is a device path/name rather than a network port number. Use `onMessage(bytes)` for received payloads and `write(data)` for sends. Match these settings to the hardware and configure stream boundaries with the [Framing object](#framing-and-encoding-are-different).

This is not the `Ossia.Serial` root's `framing` string: its separate [Serial device API]({{ site.baseurl }}/reference/languages/qml-devices.html#serial-device-api) has different recognized names and tree callbacks. See [Serial device setup]({{ site.baseurl }}/devices/serial-device.html) for port ownership and permissions.

## Troubleshooting and scope

Validate QML first, then check the host/bind address, port permissions, framing and payload encoding independently. A valid QML component proves neither a reachable server nor a correct external API. Prefer loopback while developing, and avoid exposing listeners to untrusted networks. These are client/device integration APIs; for an operator's browser controlling score, see [Remote Control]({{ site.baseurl }}/in-depth/remote.html).

Source: [`qml_protocols.hpp`](https://github.com/ossia/libossia/blob/master/src/ossia-qt/qml_protocols.hpp), [`qml_protocols.cpp`](https://github.com/ossia/libossia/blob/master/src/ossia-qt/qml_protocols.cpp) and [`qml_oauth.hpp`](https://github.com/ossia/libossia/blob/master/src/ossia-qt/protocols/qml_oauth.hpp).
