---
layout: default

title: Gamepad control
description: "Perform drum hits with gamepad buttons while the sticks reshape their texture and echoes."

parent: Device Examples
grand_parent: Examples

permalink: /examples/devices/gamepad.html
score: /examples/devices/gamepad.zip
---

# Gamepad Control

![Gamepad button and stick mappings for drums, bitcrushing and delay]({{ site.img }}/examples/devices/gamepad.png "Gamepad controller setup in ossia score")

Play a rhythm with the buttons and reshape it with the sticks. A gamepad puts two kinds of musical action under your thumbs: deliberate drum attacks and continuous changes to the sound between them. The same small controller can act as both percussion instrument and effects surface.

## Prepare the controller and samples

1. Open the ZIP directly in score; the Fairlight drum kit and its samples are included.
2. Connect a gamepad. If `Gamepad` is disconnected in the Device explorer, right-click it and select your controller or choose Reconnect. Check that `/button/a`, `/button/b` and the stick axes change before starting playback. Physical button labels may differ from these standardized names.
3. Configure audio output and begin at a low level. This patch needs Deuterium, Faust and Airwindows.

## Play the patch

Press A and B during playback to play two drum sounds. Alternate them until you have a repeatable rhythm, then keep that rhythm steady while exploring one stick at a time. This makes the effect of each gesture easier to hear.

The left stick controls Bitcrush: horizontal movement changes Rate, and vertical movement changes Crush. Move along one axis first, then diagonally. Compare changes in grain and roughness without changing the drum pattern.

The right stick controls delay time and feedback. Begin with low feedback and try short repeats, then lengthen the delay to fill the space between hits. Raise feedback cautiously and leave pauses to hear the echoes decay; changing both axes at once can make a familiar rhythm much denser.

There is no rumble mapping in this patch: the feedback to the performer is audible, not tactile.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

## Learn more

- [[Joystick device]] - Gamepad and joystick device configuration
- [[MIDI utilities]] - Converting triggers to MIDI notes
- [[Working with devices]] - General device setup guide
