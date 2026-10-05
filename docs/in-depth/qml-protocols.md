---
layout: default

title: QML protocols
description: "Custom transport connections, framing, encoding, HTTP and OAuth from scripts"
parent: Scripting
grand_parent: In depth
permalink: /in-depth/qml-protocols.html
---

# QML protocols

Use `Protocols` in the console or a [Mapper device]({{ site.baseurl }}/devices/mapper-device.html) when an external API cannot be expressed by a standard device. Mapper QML declares the device tree, then translates transport messages into `Device.write` calls. The [HTTP device]({{ site.baseurl }}/devices/http-device.html) and [WebSocket device]({{ site.baseurl }}/devices/ws-device.html) have their own `Ossia.HTTP` / `Ossia.WebSockets` tree conventions; do not mix their callbacks with raw socket callbacks below.

Backends depend on the platform and compile-time features. Keep the returned socket in a variable/property for as long as it is needed, and implement `onError` to diagnose connection failures. Opening is asynchronous; send initial data from `onOpen(socket)`, not immediately after calling the factory.

## Transport selection

| Factory | Configuration / receive path |
|---|---|
| `outboundUDP(config)` | `Transport: { Host, Port }`; call `write(data)`. |
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

## OSC and MIDI payloads

`Protocols.osc({ onOsc: function(address, args) { ... } })` creates an OSC parser. Feed raw packet bytes with `processMessage(bytes)`; this does not itself open an OSC socket.

`inboundMIDIDevices()` / `outboundMIDIDevices()` enumerate MIDI 1.0 port identifiers. Pass an identifier as `Transport` to `inboundMIDI` / `outboundMIDI`; input uses `onMessage(bytes)`. The corresponding MIDI 2.0 UMP calls are `inboundUMPDevices`, `outboundUMPDevices`, `inboundUMP`, `outboundUMP`. Backend support and connected hardware determine which ports exist; never assume element zero is available.

## Troubleshooting and scope

Validate QML first, then check the host/bind address, port permissions, framing and payload encoding independently. A valid QML component proves neither a reachable server nor a correct external API. Prefer loopback while developing, and avoid exposing listeners to untrusted networks. These are client/device integration APIs; for an operator's browser controlling score, see [Remote Control]({{ site.baseurl }}/in-depth/remote.html).

Source: [`qml_protocols.hpp`](https://github.com/ossia/libossia/blob/master/src/ossia-qt/qml_protocols.hpp), [`qml_protocols.cpp`](https://github.com/ossia/libossia/blob/master/src/ossia-qt/qml_protocols.cpp) and [`qml_oauth.hpp`](https://github.com/ossia/libossia/blob/master/src/ossia-qt/protocols/qml_oauth.hpp).
