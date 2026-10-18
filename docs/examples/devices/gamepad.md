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

Play a rhythm with the buttons and reshape it with the sticks. The buttons trigger drum attacks; the sticks change the sound continuously between them.

## Prepare the controller and samples

1. Open the ZIP directly in score; the Fairlight drum kit and its samples are included.
2. Connect a gamepad. If `Gamepad` is disconnected in the Device explorer, right-click it and select your controller or choose Reconnect. Check that `/button/a`, `/button/b` and the stick axes change before starting playback. Physical button labels may differ from these standardized names.
3. Configure audio output and begin at a low level. This patch needs Deuterium, Faust and Airwindows.

## Play the patch

Press A and B during playback to play two drum sounds. Alternate them until you have a repeatable rhythm, then keep that rhythm steady while moving one stick at a time.

The left stick controls Bitcrush: horizontal movement changes Rate, and vertical movement changes Crush. Move along one axis first, then diagonally: the drums get grainier and rougher while the pattern stays the same.

The right stick controls delay time and feedback. Begin with low feedback and try short repeats, then lengthen the delay to fill the space between hits. Raise feedback cautiously and leave pauses to hear the echoes decay; changing both axes at once can make a familiar rhythm much denser.

There is no rumble mapping in this patch: the feedback to the performer is audible, not tactile.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

## Learn more

- [[Joystick device]] - Gamepad and joystick device configuration
- [[MIDI utilities]] - Converting triggers to MIDI notes
- [[Working with devices]] - General device setup guide
