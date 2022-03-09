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

To fetch the sensor value, a `get` message must be written by the computer to the serial port ; a complete communication sessop, in a serial console could for instance look like this: 

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

Here is the complete syntax available: the most important thing to note is that: 

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
