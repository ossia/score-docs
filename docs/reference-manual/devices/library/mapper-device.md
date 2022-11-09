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
            
            // What happens when the bound parameter (MidiDevice:/1/control/45) is written to
            read: function(orig, v) { return v.value / 127.; },

            // What happens when the mapper parameter (Mapper:/node/sensor) is written to
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
            // was changed: it will be either "MidiDevice:/1/control/45" or "MidiDevice:/1/control/55".
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
