---
layout: default
title: Sequencing audio effects
description: "Make contrasting musical sections from one drum pattern by scheduling distortion, echo, reverb and other treatments."
parent: Audio
grand_parent: Examples
permalink: /examples/audio/more-audiofx.html
score: /examples/audio/more-audiofx.score
---

# Sequencing audio effects

![Jungle drum pattern routed to successive effect intervals across the timeline]({{ site.baseurl }}/assets/scores/thumbnails/examples-audio-more-audiofx.png)

A repeating drum part moves from clear attacks to crushed, echoing and distorted versions of itself. The rhythm stays in place while its treatment changes.

## One interval per effect

The drum generator runs across the piece, but each effect lives in its own interval. As the timeline activates successive intervals, the same source receives a different treatment, without any change to the drum part.

After the final section, playback returns to the ring-modulation section and repeats the last two treatments. The drum source has its own interactive end, so the score is not a fixed-length export.

## Listen and edit

Use a build with Kaboom, BarrVerb and Airwindows. No samples or external device are required. Configure audio output and start at a low volume.

1. Watch the active effect interval while listening. Which treatments leave the drum attacks recognizable, and which turn the pattern into a texture?
2. Lower Bitcrush's Rate to change the grain of the sound, or cautiously vary Echo's Feedback to change how much one hit spills into the next. The opening section is unprocessed, for reference.
3. Move an interval boundary. The same effect can feel like an accent or a sustained section depending on when it arrives and how long it lasts.
4. Trigger the end of `Drums` to stop the source, or stop the transport to finish. Its drawn 68-second endpoint does not fire automatically.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

