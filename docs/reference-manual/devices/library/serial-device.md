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
  function onMessage(message) {
    return [ { address: "/sensor", value: parseInt(message) } ]; 
  }

  function createTree() 
  {
    return [ 
      {
        name: "request",
        type: Ossia.Type.Pulse,
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

Here is the complete syntax available for reading messages: the most important thing to note is that: 

* `onMessage` is to be used to process messages in text-based protocols.
* `onBinary` is to be used to process messages in binary protocols.
* `onRead` is to be used to process the raw byte stream.
* `property string delimiter: "\n\n"` and  `property string framing: "<FRAMING>"` can be used 
  to configure the framing of messages. 
  
Supported framing protocols are: 
* "none"
* "slip"
* "size"
* "delimiter" (the default, set as "\r\n")

```qml
import Ossia 1.0 as Ossia

Ossia.Serial
{
  /// Message-based processing ///

  // Option A: this function is called whenever a \r\n-delineated message is read.
  // "message" will be a string, thus this function is what you need to use for text-based protocols.
  function onMessage(message) {
    // Will log in score's message window
    console.log(message); 

    // Will set the value 123 to the address my_device:/sensor
    return [ { address: "/sensor", value: 123 } ]; 
  }

  // Option B: this function is called whenever a message is read.
  // "message" will be an ArrayBuffer containing the raw bytes.
  function onBinary(message) {
    // Will log in score's message window
    console.log(message); 

    // Will set the value 123 to the address my_device:/sensor
    return [ { address: "/sensor", value: 456 } ]; 
  }

  // The delineation can be overriden with: 
  property string delimiter: "\n\n"

  // It's possible to use other framing methods for message-based processing. 
  // The following are supported:

  // SLIP encoding: 
  property string framing: "slip" 

  // Size-prefix encoding. 
  // Each message starts with a big-endian int32 which is the size of the next message.
  property string framing: "size" 

  // Delimiter (the default)
  property string framing: "delimiter" 

  // No framing at all. It's up to the user to reconstitute messages, in the "onRead" method (see below).
  property string framing: "none" 

  /// Raw processing ///
  // Option C:
  // If doing the following, the serial processing code will not attempt to frame
  // incoming and outgoing data as messages. The function is called with whatever bytes are available
  // and it is up to the user to reassemble them with the custom protocol being used.
  // "bytes" will be an ArrayBuffer containing the raw bytes.
  function onRead(bytes) {
    // Will set the value 123 to the address my_device:/sensor
    return [ { address: "/sensor", value: 789 } ]; 
  }

  /// Creation of the tree ///
  // This function defines the shape of this device tree. 
  // Note that it is static and defined at creation.
  function createTree() 
  {
    return [ 
      // This creates a node "my_device:/request" of type "impulse"
      {
        name: "request",
        type: Ossia.Type.Pulse,
        access: Ossia.Access.Set,

        /// request: can be used to customize the serial communication.

        // Option A: the string "$val" will be replaced textually by the value of the message sent by score
        request: "message sent whenever a message is sent to this address in score"

        // Option B: the given function will be called, which will return a string which behaves the same
        request: () => {
          return Math.random() + " foo "
        }

        // Option C: same thing with an argument: 
        // it will be an object { value: /* current value */, type: /* type of the value */ } 
        request: (val) => {
          return val.value + " foo "
        }
      },

      // This creates a node "my_device:/sensor" of type "int"
      {
        name: "sensor",
        type:  Ossia.Type.Int,
        access: Ossia.Access.Get,
        min: 0,
        max: 255,
        bounding: Ossia.Bounding.Clip,
        repetition_filter: Ossia.Repetitions.Filtered

        // Here without "request:" specified, the int value of the address will be textually written to the serial port
      }
    ]; 
  }

  // These functions are called when score needs to actively listen on changes on some addresses
  function openListening(address) { }
  function closeListening(address) { }
}
```

## Writing binary data

By default, the values returned from `request` in the device tree are treated as strings and will be written to the serial port in textual, ASCII format. For instance, an "int" parameter with value 1234 will cause the actual integer to be written textually in the serial port: 123 as the bytes `0x31 0x32 0x33`, and not the single-byte value for 123, `0x7B`.

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
        uint8[1] = '\r';
        uint8[2] = '\n';
        return auint8;
  }
}
```

## OSC support

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

## Coalescing messages

In case the serial port is too slow and overflows, one can add the property: 

```
property real coalesce: 15
```

to the Serial object, to coalesce messages every 15 milliseconds for instance.

If a specific parameter must *not* be coalesced, but always sent, one can simply set `critical: true` on the node.
One will generally want to use coalescing on parameters such as lights, drives, or anything that more-or-less maps to an electrical voltage, and not for parameters that would trigger the start of an action.

In case messages use the OSC feature, then non-critical messages will get coalesced as a single bundle.

## Examples

Arduino's built-in examples proposes two similar sketches for serial communication: `SerialCallResponse` and `SerialCallResponseASCII`. You can find their companion QML scripts in the [user library](https://github.com/ossia/score-user-library/tree/master/Devices/Serial/Arduino/Examples_BUILT-IN/COMMUNICATION), illustrating the use of the `onRead` and `onMessage` functions respectively.