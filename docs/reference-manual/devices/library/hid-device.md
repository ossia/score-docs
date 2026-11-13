---
layout: default

title: HID Device
description: "Generic USB HID devices: keyboards, pads, custom controllers"

parent: Devices
grand_parent: Reference

permalink: /devices/hid-device.html
---
# HID Device

Reads and writes any USB HID device, from the description the device gives of its reports. Use it for controllers that score has no dedicated device for. Joysticks and MIDI controllers have their own devices.

## Requirements

On Linux, read and write access to the device's `/dev/hidraw*` node. For instance, in `/etc/udev/rules.d/70-hid.rules`, with the device's vendor id:

```
SUBSYSTEM=="hidraw", ATTRS{idVendor}=="0fd9", TAG+="uaccess"
```

Then run `sudo udevadm control --reload-rules && sudo udevadm trigger`, and plug the device in again.

## Device setup

1. In the **Device Explorer**, click **+** and choose **Hardware ▸ HID**.
2. Pick the device from the list.

When the device is unplugged, it comes back on its own once it is plugged in again.

## Available controls

| Address | |
|---|---|
| `/info/…` | Manufacturer, product, serial, ids |
| `/input/…` | One address per input field: keys, axes, buttons |
| `/output/…` | One address per output field: LEDs, for instance |
| `/raw/input` | Each input report, as bytes |
| `/raw/output` | Writes an output report |
| `/raw/feature/send`, `/raw/feature/get`, `/raw/feature/value` | Feature reports |

The fields come from the device's report descriptor, which is only read on Linux. Elsewhere, only the raw reports are available.

## Scripting

`Protocols.hid` talks to a HID device from a script:

```js
const dev = Protocols.hid({
  Transport: { VendorId: 0x0fd9, ProductId: 0x0080 },
  onOpen: d => console.log("open", d.product()),
  onReport: bytes => console.log(bytes),
  onError: e => console.log(e)
});
dev.write([0x02, 0x00]);
```

- `Transport`: `Path`, or `VendorId` / `ProductId`, with optional `Serial`, `Interface` and `UsagePage`.
- The device has `write(bytes)`, `sendFeatureReport(bytes)`, `getFeatureReport(id, length)`, `reportDescriptor()`, `path()`, `serial()`, `product()` and `close()`.
- `Protocols.hidDevices()` lists the connected devices.
- `Protocols.renderImage({ Width, Height, Background, Text, TextColor, Image, Format, … })` draws an image and encodes it. Format is `jpeg`, `png`, `bmp`, `rgb`, `bgr`, `rgba` or `rgb565`. Use it to send images to devices with screens.
