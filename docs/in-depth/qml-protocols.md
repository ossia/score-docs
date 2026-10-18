---
layout: default

title: QML protocols
description: "Custom transport connections, framing, encoding, HTTP and OAuth from scripts"
parent: Scripting
grand_parent: In depth
permalink: /in-depth/qml-protocols.html
---

# QML protocols

Custom QML transports let a script communicate with an API that cannot be represented by a standard device. The complete runtime reference now lives under **Reference → Languages**:

- [QML transport API]({{ site.baseurl }}/reference/languages/qml-protocols.html): `Protocols` factories, socket callbacks, framing, encoding, HTTP, OAuth, OSC and MIDI.
- [QML device API]({{ site.baseurl }}/reference/languages/qml-devices.html): root types, parameter trees, `Device` operations and device-specific callbacks.

Use a [Mapper device]({{ site.baseurl }}/devices/mapper-device.html) for custom sockets and persistent mappings. Use the [HTTP]({{ site.baseurl }}/devices/http-device.html), [WebSocket]({{ site.baseurl }}/devices/ws-device.html) or [Serial]({{ site.baseurl }}/devices/serial-device.html) device when its tree-oriented API matches your hardware or service. These roots have their own callback contracts; do not copy raw socket callbacks into them.

## Transport selection

Start with the [transport factory table]({{ site.baseurl }}/reference/languages/qml-protocols.html#transport-selection), then the [socket lifecycle]({{ site.baseurl }}/reference/languages/qml-protocols.html#socket-callbacks) and [worked examples]({{ site.baseurl }}/reference/languages/qml-protocols.html#transport-examples). Backend availability depends on the platform and build.

## Framing and encoding are different

TCP and serial need explicit message-boundary handling. Use the [framing and encoding reference]({{ site.baseurl }}/reference/languages/qml-protocols.html#framing-and-encoding-are-different) to match the other endpoint. The Serial device root has its own [framing names]({{ site.baseurl }}/reference/languages/qml-devices.html#serial-framing).

## HTTP requests

For arbitrary methods, headers, JSON bodies and response status codes, see [`Protocols.http`]({{ site.baseurl }}/reference/languages/qml-protocols.html#http-requests). For parameter-driven requests with local tree updates, see the separate [HTTP device API]({{ site.baseurl }}/reference/languages/qml-devices.html#http-device-api).

## OAuth

The [OAuth reference]({{ site.baseurl }}/reference/languages/qml-protocols.html#oauth) documents the build requirements, authorization-code flow, callback shape and trusted-response caveat. Register your own service application and keep tokens out of shared scores.

## OSC and MIDI payloads

See [OSC packet parsing]({{ site.baseurl }}/reference/languages/qml-protocols.html#osc-message-parsing) and [MIDI / UMP enumeration and ports]({{ site.baseurl }}/reference/languages/qml-protocols.html#midi). An OSC parser does not open a socket; a MIDI port must exist before it can be opened.

## Troubleshooting and scope

Validate QML first, then diagnose addresses, permissions, framing and encoding independently using the [transport troubleshooting guide]({{ site.baseurl }}/reference/languages/qml-protocols.html#troubleshooting-and-scope). Begin with loopback and avoid exposing listeners to untrusted networks. For an operator's browser controlling score rather than a client/device integration, see [Remote Control]({{ site.baseurl }}/in-depth/remote.html).
