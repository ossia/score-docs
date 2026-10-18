---
layout: default

title: Serial device
description: "Controlling serial-port based hardware in ossia score"

parent: Devices
grand_parent: Reference

permalink: /devices/serial-device.html
---

# Serial device
![Device setup window]({{ site.img }}/reference/devices/serial-device.png "score device setup")

This protocol allows to communicate through custom serial port protocols defined in QML.

Multiple examples are available in the user library.

The canonical [Serial device API]({{ site.baseurl }}/reference/languages/qml-devices.html#serial-device-api) covers framing, text/raw/binary callbacks, requests, OSC and coalescing. This page keeps connection setup and a sensor tutorial. `Ossia.Serial` is a device root, distinct from the low-level [`Protocols.serial` socket factory]({{ site.baseurl }}/reference/languages/qml-protocols.html#serial-sockets).

## Connection and framing

In **Add device → Serial**, select the **Port**, match the hardware's **Baud rate**, and load or edit the QML definition. **Validate** checks that the QML component can be loaded; it does not confirm that the hardware understands the resulting bytes.

Serial is a byte stream: a read operation is not necessarily one complete message. Use `onRead` when your script must handle raw chunks, or choose explicit framing for `onMessage` / `onBinary`. For a line-based protocol, declare both properties, for example:

```qml
property string framing: "delimiter"
property string delimiter: "\r\n"
```

The **OSC** device's serial transport offers **COBS** framing. That is a separate configuration path: choose **OSC → Serial port → Framing → COBS** for hardware exchanging COBS-framed OSC packets. The Serial QML parser does not expose COBS merely because the shared socket layer supports it. See [OSC transports and framing]({{ site.baseurl }}/devices/osc-device.html#transports-and-framing).

Only one application/device should own a serial port at a time. Check operating-system permissions and close serial monitors before connecting. Port names can change between machines; review the saved port when moving a project.

## QML API

Assuming a serial device which, whenever bytes are written to it, sends back a sensor reading 
with the following textual protocol: 

```
10\r\n12\r\n17\r\n5\r\n...
```

To fetch the sensor value, a `get` message must be written by the computer to the serial port ; a complete communication session, in a serial console could for instance look like this: 

```
get
10
get
12
get
17
```

A basic QML script for processing that serial device and making the sensor value available to score under a `/sensor` address in the device explorer would look like this:

```qml
import Ossia 1.0 as Ossia

Ossia.Serial
{
  property string framing: "delimiter"
  property string delimiter: "\r\n"

  function onMessage(message) {
    return [ { address: "/sensor", value: parseInt(message) } ]; 
  }

  function createTree() 
  {
    return [ 
      {
        name: "request",
        type: Ossia.Type.Impulse,
        access: Ossia.Access.Set,
        request: "get"
      },
      {
        name: "sensor",
        type:  Ossia.Type.Int,
        access: Ossia.Access.Get,
        min: 0,
        max: 255,
        bounding: Ossia.Bounding.Clip,
        repetition_filter: Ossia.Repetitions.Filtered
      }
    ]; 
  }
}
```

Send an impulse to `deviceName:/request` to write `get` with the configured delimiter; each returned sensor reading updates `deviceName:/sensor`. The example's domain clips readings to 0–255 and filters repeated values.

For the complete callback and tree contract, see [Receiving serial data]({{ site.baseurl }}/reference/languages/qml-devices.html#receiving-serial-data), [Serial framing]({{ site.baseurl }}/reference/languages/qml-devices.html#serial-framing), and [Serial requests and listening]({{ site.baseurl }}/reference/languages/qml-devices.html#serial-requests-and-listening).

## Writing binary data

To send bytes rather than ASCII numbers, return a typed-array buffer and handle framing explicitly. The [binary-writing reference and example]({{ site.baseurl }}/reference/languages/qml-devices.html#writing-binary-data) show a value byte followed by CR/LF.

## OSC support

For hardware speaking OSC over its serial port, see the [`osc_address` and blob examples]({{ site.baseurl }}/reference/languages/qml-devices.html#osc-support). This is separate from configuring the OSC device's serial transport.

## Coalescing messages

For slow ports, [coalescing]({{ site.baseurl }}/reference/languages/qml-devices.html#coalescing-messages) combines updates at a configured interval. Use it for continuously changing values such as lights or drives, and mark action-triggering parameters `critical: true` when every message must be sent.

## Examples

Arduino's built-in examples proposes two similar sketches for serial communication: `SerialCallResponse` and `SerialCallResponseASCII`. You can find their companion QML scripts in the [user library](https://github.com/ossia/score-user-library/tree/master/Devices/Serial/Arduino/Examples_BUILT-IN/COMMUNICATION), illustrating the use of the `onRead` and `onMessage` functions respectively.