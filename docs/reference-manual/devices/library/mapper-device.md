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

For the canonical language/runtime contract, see the [QML device API]({{ site.baseurl }}/reference/languages/qml-devices.html) (tree fields, value types, callbacks and `Device`) and [QML transport API]({{ site.baseurl }}/reference/languages/qml-protocols.html) (`Protocols`, framing, HTTP and OAuth). This page covers device setup and worked mappings.

## Setup and capabilities

Choose **Mapper** in **Add device**, then select a library QML definition or edit its script. The script returns an address tree from `createTree()`. Nodes can be containers or typed parameters; a parameter does not need a `bind` to exist. This makes a Mapper useful both for aliases/transforms and for script-managed intermediate values.

Mapper rebuilds bindings when other devices become available or reconnect. A missing source is not a source of live values: verify its device name and full address before relying on the mapping. Source updates change the Mapper's value without automatically writing the same value back to the source. Explicit writes to the Mapper follow its `write` rule or binding.

Mapper is a persistent device, not a timeline process: stopping playback does not disable its script or its mappings. Stop or disconnect the relevant devices when you need to prevent hardware communication outside playback.

### Libmapper is a separate protocol

**Mapper** is score's QML/JavaScript mapping device. The optional **LibmapperClient** source integration is a distinct network protocol; it does not execute these QML scripts. See [Libmapper client]({{ site.baseurl }}/devices/libmapper-device.html) for its current build and backend limitations rather than assuming it is interchangeable with Mapper.

## Script structure

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

![Mapper example]({{ site.img }}/reference/devices/mapper/mapper1.avif "Mapper binding")

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

![Mapper example]({{ site.img }}/reference/devices/mapper/mapper2.avif "Mapper binding with transforms")

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

## Using the Device object

Use `Device` when incoming data or a timer must read or write parameters directly rather than through bindings. The [Device object reference and examples]({{ site.baseurl }}/reference/languages/qml-devices.html#device-object) cover local paths, cross-device addresses, tree edits and value conversions, including:

- [Updating the Mapper's own nodes]({{ site.baseurl }}/reference/languages/qml-devices.html#writing-to-the-mappers-own-nodes).
- [Writing to other devices]({{ site.baseurl }}/reference/languages/qml-devices.html#writing-to-other-devices) and [reading their current values]({{ site.baseurl }}/reference/languages/qml-devices.html#reading-from-other-devices).
- [Combining reads and writes]({{ site.baseurl }}/reference/languages/qml-devices.html#combining-device-reads-and-writes).
- [Dispatching incoming OSC messages]({{ site.baseurl }}/reference/languages/qml-devices.html#reacting-to-incoming-network-data-and-dispatching-to-multiple-devices).

## Using the Protocols object

For devices whose APIs need custom transports, keep a raw socket in a QML property and translate its messages into device values. The [QML transport API]({{ site.baseurl }}/reference/languages/qml-protocols.html) contains the complete configuration and examples for [UDP]({{ site.baseurl }}/reference/languages/qml-protocols.html#udp-sockets), [TCP]({{ site.baseurl }}/reference/languages/qml-protocols.html#tcp-sockets), [WebSockets]({{ site.baseurl }}/reference/languages/qml-protocols.html#websockets), [Unix sockets]({{ site.baseurl }}/reference/languages/qml-protocols.html#unix-sockets), [HTTP]({{ site.baseurl }}/reference/languages/qml-protocols.html#http-requests), [OSC parsing]({{ site.baseurl }}/reference/languages/qml-protocols.html#osc-message-parsing), [MIDI]({{ site.baseurl }}/reference/languages/qml-protocols.html#midi) and [serial]({{ site.baseurl }}/reference/languages/qml-protocols.html#serial-sockets).

## Reference

The embedded API manual has moved under **Reference → Languages**:

- [Context objects]({{ site.baseurl }}/reference/languages/qml-devices.html#available-context-objects) and [Device operations]({{ site.baseurl }}/reference/languages/qml-devices.html#device-object).
- [Tree node properties]({{ site.baseurl }}/reference/languages/qml-devices.html#tree-node-properties) and [value types]({{ site.baseurl }}/reference/languages/qml-devices.html#value-types).
- [Mapper callback signatures]({{ site.baseurl }}/reference/languages/qml-devices.html#callback-signatures).
- [Transport factories]({{ site.baseurl }}/reference/languages/qml-protocols.html#transport-selection) and [socket callbacks]({{ site.baseurl }}/reference/languages/qml-protocols.html#socket-callbacks).
