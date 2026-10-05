---
layout: default

title: Devices and discovery API
description: "Protocol discovery, device settings and live parameter access"
parent: Scripting API
grand_parent: In depth
permalink: /in-depth/scripting-api/devices.html
---

# Devices and discovery API

[Back to the Scripting API]({{ site.baseurl }}/in-depth/scripting-api.html) · [Examples]({{ site.baseurl }}/in-depth/scripting-api/examples.html#device-snapshots-discovery-and-live-values)

## Existing devices and settings

`Score.device(name)` returns a device object. `Score.deviceSettings(name)` returns its saved configuration as a JavaScript object containing `Name`, `Protocol` and protocol-specific fields. This is the same serialization accepted by `createDevice(name, protocolUuid, settings)`; use it rather than inventing settings keys.

```js
var settings = Score.deviceSettings("myOSC");
console.log(JSON.stringify(settings));
// Once a different, unused name and suitable ports have been chosen:
// Score.createDevice("otherOSC", settings.Protocol, settings);
```

`availableProtocols()` lists the installed protocol factories. Availability depends on the build, platform and add-ons. A missing factory cannot be created just by supplying its UUID.

Common helpers:

```js
// Listen on local UDP port 9000; send to 127.0.0.1:9001.
Score.createOSCDevice("myOSC", "127.0.0.1", 9000, 9001);
Score.createAddress("myOSC:/level", "float");
Score.connectOSCQueryDevice("remote", "ws://127.0.0.1:5678");
```

`createQMLWebSocketDevice(name, qmlText)` and `createQMLSerialDevice(name, serialPort, qmlText)` create scripted devices. `setUnit(address, unit)` changes an existing parameter's unit, for example `"color.rgba"`, `"position.cart2D"` or `""` to clear it.

`disconnectDevice(name)` and `reconnectDevice(name)` retain the device in the tree and can be used during playback. `removeDevice(name)` deletes it through a command and is refused while playing.

`deviceToJson(name)` and `deviceToOSCQuery(name)` export a tree as JSON text. `iterateDevice(name, function(address, value) { ... })` visits its parameters, not arbitrary node objects. `setDeviceLearn(name, enabled)` toggles learning on devices that support it.

## Discovery is a subscription

`enumerateDevices()` creates an enumerator, not a completed array. Pass a protocol's user-visible name or UUID, or a list of these, to limit discovery. Enable it with `enumerate = true` and keep a reference while discovery is needed:

```js
var discovery = Score.enumerateDevices(["OSC", "OSCQuery"]);
if (discovery) {
  discovery.deviceAdded.connect(function(factory, category, name, settings) {
    console.log(category, name);
  });
  discovery.enumerate = true;
}
// Later: discovery.enumerate = false;
```

`devices` contains discovered identifiers with `category`, `name`, `settings` and `protocol`. `deviceAdded(factory, category, name, settings)` / `deviceRemoved(factory, name)` report changes. In QML, `Score.UI.DeviceEnumerator` exposes `deviceType`, `deviceTypes` and `enumerate` for the same purpose. Discovery finds advertised or locally enumerable devices; it does not scan every possible IP address.

`Score.listenDevice(name)` returns a listener with `message(address, value)` and `parameterCreated(address)` signals. The QML `Score.UI.DeviceListener` type provides a configurable listener with a `listen` property.

## Live values

```js
var level = Device.read("myOSC:/level");
Device.write("myOSC:/level", 0.5);
```

These operations exchange values, not undoable editor changes. `Device.asArray`, `asColor`, `asVec2`, `asVec3` and `asVec4` convert Qt/ossia value representations. Mapper scripts additionally expose `toValue` to unwrap typed values and operations to edit their own tree; see [Mapper device]({{ site.baseurl }}/devices/mapper-device.html).

See [QML protocols]({{ site.baseurl }}/in-depth/qml-protocols.html) for low-level transport APIs, and [Remote Control]({{ site.baseurl }}/in-depth/remote.html) for controlling score itself over a network.

Source: [`EditContext.device.cpp`](https://github.com/ossia/score/blob/master/src/plugins/score-plugin-js/JS/Qml/EditContext.device.cpp), [`DeviceEnumerator.hpp`](https://github.com/ossia/score/blob/master/src/plugins/score-plugin-js/JS/Qml/DeviceEnumerator.hpp).
