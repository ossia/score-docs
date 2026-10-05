---
layout: default

title: Device explorer
description: "How to use the device explorer in ossia score"

parent: Panels
grand_parent: Reference

permalink: /panels/explorer.html
---

# Device explorer

The device explorer (shortcut: {% include shortcut.html content="Ctrl+Shift+D" %})  is where external devices and hardware can be interacted with and added to a score.

![Device explorer]({{ site.img }}/reference/panels/explorer.png "Device explorer")

## Add a device

Choose **Add device** from the context menu, or use {% include shortcut.html content="Ctrl+B" %} with the explorer active. In the dialog:

- **Protocols** lists the protocols available in this build. Select one, then choose a discovered device or library definition where offered, and complete its settings.
- **Presets** lists `.device` files found beneath the library's `packages` directory. A preset contains a device definition and its saved tree; it still requires the relevant protocol, packages and hardware.
- **Filter** fields narrow the protocol, device and preset lists. The protocol filter receives focus when the dialog opens; keyboard navigation can select a result without scrolling through the entire list.

Some protocols offer a Default device as well as named hardware. For example, Default Joystick selects an available controller. Select named hardware when a project requires a particular device.

## Devices during playback

You can **add and import devices while the score is playing**. Use the explorer context menu or Add device shortcut if the toolbar's editing menu is disabled.

This does not unlock every edit: **Remove**, device **Edit**, namespace refresh, learning, disconnect/reconnect and address-structure edits remain restricted while playback is running. Stop playback before changing or removing an existing device. Commands also depend on protocol capabilities: a discovered hardware tree may not permit adding arbitrary addresses even while stopped.

## Browse, filter and inspect values

Expand a device to browse its address tree. The search field filters the chosen column case-insensitively; clearing it restores the earlier expansion state. This filters the view, not the underlying device namespace.

Select a parameter to inspect its value, type, access and other attributes in the bottom panel. The tree and inspector use value-type-aware editors, including booleans, numbers, vectors, lists and maps. A read-only input is not a writable hardware control; the protocol's access mode matters.

Expanded branches are listened to for updates, and refresh/reconnect preserves expansion for addresses that still exist. Monitoring during playback also depends on the execution listening setting; a display that is not updating does not by itself establish that no messages are arriving.

Useful context-menu actions include:

| Action | Purpose |
|---|---|
| **Refresh namespace** | Ask an explorable device for its current tree. Not every protocol supports discovery. |
| **Refresh value** | Request the selected parameter's value when supported. |
| **Learn** | Capture incoming addresses for protocols supporting learning. |
| **Find usage** | Locate uses of an address in the document before changing its setup. |
| **Disconnect / Reconnect** | Release or reopen a connection without deleting its device definition. |

## Export and import

Select a device root and choose **Export device** to save a `.device` file. To reuse it, choose **Import device** from the context menu on empty explorer space and select the file. This workflow is not limited to OSC devices.

Export saves the device definition and tree, not an installer for its protocol or a bundle of every external dependency. On another computer, review device names, ports, paths, credentials and hardware identities. A file referring to an unavailable protocol cannot be instantiated. Treat exported configurations containing credentials as sensitive.

Device presets are different from [saving and recalling parameter states]({{ site.baseurl }}/quick-start/saving-and-recalling-devices-state.html): one recreates a device setup, while the other records values to send during a score.

See [Working with devices]({{ site.baseurl }}/quick-start/working-with-devices.html) for the basic workflow and the [Devices reference]({{ site.baseurl }}/devices.html) for protocol-specific requirements.
