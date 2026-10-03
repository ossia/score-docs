---
layout: default

title: HTTP device
description: "Using HTTP APIs as a basis for a device"

parent: Devices
grand_parent: Reference

permalink: /devices/http-device.html
---

# HTTP device

The HTTP device maps score parameters to HTTP requests using QML. It is an **outgoing API client**, not the HTTP server used by score's remote-control interface.

![Device setup window]({{ site.img }}/reference/devices/http-device.png "score device setup")

## Setup

Add a device, choose **HTTP**, enter a **Name**, and provide QML code. The **Validate** button checks QML syntax/component loading and displays diagnostics below the editor; it does not send a request or prove the remote API works.

The root is `Ossia.HTTP`. Its `createTree()` returns parameter descriptions with `name`, `type` and optional `children`. A parameter's `request` is a URL string or a function returning a URL; pushing a value to that parameter sends the request.

```qml
import Ossia 1.0 as Ossia

Ossia.HTTP {
  function createTree() {
    return [
      {
        name: "refresh",
        type: Ossia.Type.Impulse,
        request: "http://127.0.0.1:8080/status",
        answer: function(body, value) {
          return [{ address: "/status", value: body }];
        }
      },
      { name: "status", type: Ossia.Type.String }
    ];
  }
}
```

This expects an HTTP service at the given URL. Send an impulse to `deviceName:/refresh`; on a successful reply, its text updates `deviceName:/status`. An `answer(body, value)` callback receives response text and the parameter's current value, then returns an array of `{ address, value }` updates within this device.

## Request and response options

- A string `request` may contain `$val`, replaced by the sent value. A function `request(value)` receives a typed object such as `{ type: Ossia.Type.Int, value: 123 }`; construct a URL using `value.value` and escape query components with `encodeURIComponent`.
- Requests are GET by default. Set `method: "post"` and `requestData` (a string or function) for a POST body. This device's tree API is not a generic arbitrary-method/header client.
- `onRead(bytes)` or `onReadString(text)` receives chunks as they arrive. Chunk boundaries are not message boundaries, and these callbacks consume reply data; do not assume a subsequent `answer` also receives the complete body.
- No automatic polling interval is implied by a tree entry. Schedule requests from the score or your script when required.

For arbitrary HTTP methods, custom headers, status-code handling or bearer authorization, use the object form of `Protocols.http` in a [Mapper device]({{ site.baseurl }}/devices/mapper-device.html), documented in [QML protocols]({{ site.baseurl }}/in-depth/qml-protocols.html#http-requests). Keep credentials out of shared scores.

If nothing arrives, check the server URL and method independently of QML validation, then inspect script/network diagnostics. This device does not expose a listening HTTP endpoint. To serve a browser operator interface, see [Remote Control]({{ site.baseurl }}/in-depth/remote.html).

Source: [`HTTPProtocolSettingsWidget.cpp`](https://github.com/ossia/score/blob/master/src/plugins/score-plugin-protocols/Protocols/HTTP/HTTPProtocolSettingsWidget.cpp) and libossia's [`http_protocol.hpp`](https://github.com/ossia/libossia/blob/master/src/ossia-qt/http/http_protocol.hpp).