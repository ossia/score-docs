---
layout: default

title: Bitfocus Companion Device
description: "Integration with Bitfocus Companion for streaming and broadcast control"

parent: Devices
grand_parent: Reference

permalink: /devices/companion-device.html
---
# Bitfocus Companion Device

![Companion Device]({{ site.img }}/reference/devices/bitfocus/companion-device.png "Bitfocus Companion Integration")

Bitfocus Companion provides modules for controlling streaming, broadcast and AV equipment. score can **host Companion modules directly**, exposing their actions, feedback and variables in the Device explorer. A separate Companion application or Stream Deck is not required for this module-hosting workflow.

The host behavior described below follows the current development implementation. Compatibility depends on the individual module, its runtime requirements and the target equipment; a module in the package is not a guarantee that every Companion feature is implemented by score.

## Requirements

### Software
- ossia score with Companion package installed from the package manager in the settings
- Compatible software or hardware controllers you want to use.

### Package Installation
1. Open the Package Manager from the settings
2. Search for "Bitfocus" in the remote packages list
3. Install the **Bitfocus Companion Modules** package.
4. Restart ossia score

![Bitfocus Example]({{ site.img }}/reference/devices/bitfocus/bitfocus.png "Installed Bitfocus package")

## Device Setup

### 1. Add Companion Device in score

1. Right-click in **Device Explorer**
2. Select **Add Device**
3. Choose **Bitfocus** from protocols
4. Select the actual device or protocol in the list. If the list is empty, check that the package is installed.
5. Configure the selected module's connection fields, such as host, credentials or product. These fields are supplied by the module, not a universal Companion server address.

![Bitfocus Example]({{ site.img }}/reference/devices/bitfocus/christie.png "Setting up a Companion-compatible device")


## Available Controls

The tree is generated from the module's definitions. Categories are singular in addresses and appear only when the module supplies them:

| Address shape | Use |
|---|---|
| `Device:/action/actionId` | Send a pulse to execute an action. |
| `Device:/action/actionId/optionId` | Set an option consumed by that action, using the option's type and available choices. |
| `Device:/feedback/feedbackId` | Read the latest result reported by the module's feedback subscription. |
| `Device:/feedback/feedbackId/optionId` | Configure the feedback subscription. Changing an option updates the subscription. |
| `Device:/variable/variableId` | Read a variable published by the module. |

Use the actual IDs shown in the tree; action descriptions may be more readable than their address names. For a multi-option action, set its options first, then send the pulse to its parent action address. For an action with exactly one exposed option, writing that option also executes the action; avoid an extra pulse unless you intend to execute it twice.

Feedback is data, not a rendered Companion button. Boolean feedback becomes a boolean parameter; other feedback may carry values or style data. Variables and feedback are supplied by the module and should not be treated as generic writable remote settings. A module may publish no feedback until it has connected, or may change its definitions after configuration.

## Host and project requirements

The package contains the modules and may provide their Node.js runtimes. score selects a packaged runtime matching the module's requested major version when available, otherwise it looks for `node` (`node.exe` on Windows) on the executable search path. Missing runtime or module dependencies can prevent connection.

The module configuration is saved with the device. Keep the corresponding module package installed on machines that open the project. Treat projects and exported device files containing connection credentials as sensitive; do not assume that export removes secrets.

This is not an import of Companion button pages, layouts or an entire Companion project. Build score states and processes around the exposed actions and values. The module owns the address tree, so manually adding arbitrary children does not add new module functionality.

## Related Documentation

- [OSC Device]({{ site.baseurl }}/devices/osc-device.html) - Direct OSC communication
- [Control Surface]({{ site.baseurl }}/processes/controlsurface.html) - UI control surfaces to control specific modules in the timeline.
- [Remote Control]({{ site.baseurl }}/in-depth/remote.html) - score remote control
