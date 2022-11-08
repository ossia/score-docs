---
layout: default

title: Art-Net device
description: "Controlling ArtNet and DMX peripherals in ossia score"

parent: Devices
grand_parent: Reference

permalink: /devices/artnet-device.html
---

# Art-Net device

![Device setup window]({{ site.img }}/reference/devices/artnet/artnet-1.png "score device setup")

It is possible to communicate through DMX with ossia score, in order to control and automate light fixtures.

The [user library]({{ site.baseurl }}/in-depth/library.html) contains a built-in fixture library that can be added.
The fixture library is based on [Open Fixture Library](https://open-fixture-library.org) and uses the same JSON format.

![Device setup window]({{ site.img }}/reference/devices/artnet/artnet-2.png "score device setup")


If no fixtures are added, then the device will instead provide the 512 raw DMX channels.

Otherwise, each fixture will appear as a node of the device.

# Custom fixtures

It is possible to add your custom fixtures, following the OFL format in the user library. To do so:

- Create a `fixtures` folder somewhere.
- Inside it, add a `manufacturers.json` file with the fixture brands you want to add.

For instance:

```json
{
  "$schema": "https://raw.githubusercontent.com/OpenLightingProject/open-fixture-library/master/schemas/manufacturers.json",
  "my_custom_fixtures": {
    "name": "My custom fixtures"
  }
}
```

- Create a subfolder `my_custom_fixtures`
- Add your fixtures JSON files to the folder.


