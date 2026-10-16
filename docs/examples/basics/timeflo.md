---
layout: default

title: Basic timeline
description: "Arrange a short sound composition, then let performer-triggered endings, branches and loops reshape its timing."

parent: Basics
grand_parent: Examples

permalink: /examples/basics/timeflo.html
score: /examples/basics/timeflo.zip
---

# Basic Timeline Example

![Basic Timeline]({{ site.img }}/examples/basics/timeflo.png "Timeline-based composition in ossia score")

Build a sound composition that can pause for a performer rather than following a fixed playhead from beginning to end. Audio clips and automated reverb establish the material; interactive endings, parallel branches and a loop let you decide how the piece moves through it.

## Overview

An interval gives a sound or effect a period of activity. Some intervals run for a fixed duration; others wait for you to end them. A following passage starts from that actual ending, so taking more time in one passage changes the timing of what follows.

This is useful when a sound sequence must accompany an action whose duration varies each time. The parallel branches also let one part continue while another waits, rather than making the whole composition pause together.

## Try it

Open the ZIP directly in score and configure audio output at a low level. The audio is included; Faust support is needed for the reverb. The patch credits the OLPC sample pack and Mike DiMattia.

- Play the arrangement once, then change the reverb automation. Listen for where the space opens up or becomes drier within a sound.
- Hold a waiting interval longer before using its end trigger. Notice which following sounds move with that decision and which parallel activity continues independently.
- Change B's false condition to include the otherwise inactive branch. Try the shared end trigger and watch the loop return to an earlier time sync: a condition chooses participation, while a trigger chooses when to continue.
- Replace one sound with your own, then adjust its interval to make room for the new material. Compare a fixed ending with one you can release by hand.

Use the final drum end trigger or Stop when finished.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

## Learn more

- [[Scenario]] - Timeline and scenario container reference
- [[Soundfiles]] - Audio file playback process
- [[Automation]] - Creating parameter automation curves
- [[Faust]] - Faust DSP effects like freeverb
