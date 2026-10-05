---
layout: default

title: Basic timeline
description: "A basic example showing time-based composition with audio files and effects"

parent: Basics
grand_parent: Examples

permalink: /examples/basics/timeflo.html
score: /examples/basics/timeflo.zip
---

# Basic Timeline Example

![Basic Timeline]({{ site.img }}/examples/basics/timeflo.png "Timeline-based composition in ossia score")

This archive combines a linear audio arrangement with interactive endings, a conditional branch and a loop.

## Prepare the project

Open the ZIP directly in score. Its sound processes reference the bundled `77bpm_GravitySwing Beat.wav`, `77bpm_Matter Intiated.wav`, `77bpm_Crystal Dust.wav` and `77bpm_Star Twinkles.wav`. The old process display names do not match these actual filenames. The patch credits the OLPC sample pack and Mike DiMattia.

Configure audio output and use a build with Faust available for `freeverb`. Outputs reach the parent mix at `audio:/out/main`.

## Follow the timeline

1. Start playback. After the initial interval, `Intro` plays the drum file and `Main` adds the second looping file.
2. At `Arp and effect`, the sound runs through Faust freeverb while an automation increases its Wet control. This interval waits for its end trigger instead of stopping at its drawn 24-second position.
3. Trigger the parallel waiting branch to start `Drums`, followed by `Arp`. The two branches can progress independently.
4. In the later A/B group, inspect B's `true == false` condition: it prevents the Star Twinkles and Lowpass branch from starting. Change the condition to compare it with A's Crystal Dust branch.
5. Trigger the shared end of A/B. A zero-duration interval returns to the earlier time sync and repeats the structure. Use the final drum end trigger or Stop when finished.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

## Learn more

- [[Scenario]] - Timeline and scenario container reference
- [[Soundfiles]] - Audio file playback process
- [[Automation]] - Creating parameter automation curves
- [[Faust]] - Faust DSP effects like freeverb
