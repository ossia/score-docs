---
layout: default
title: Granular synthesis approaches
description: "Turn recordings into sustained grain clouds, MIDI-driven rhythms and tiny loops, each changing the source in its own way."
parent: Audio
grand_parent: Examples
permalink: /examples/audio/granular.html
score: /examples/audio/granular.zip
---

# Granular synthesis approaches

![Granola voices and a Faust granulator connected to shared filters and gain]({{ site.baseurl }}/assets/scores/thumbnails/examples-audio-granular.png)

Stretch the identity of a recording: leave enough of a piano or bass fragment to recognize it, or break it into a dense texture. This score puts continuous grains, MIDI-triggered grains and very short loops side by side.

## Prepare and listen

Open the ZIP directly in score; the source recordings are included. Use a build with Granola, Faust and Airwindows, select an audio output and begin at a low listening level.

Granola selects short regions of a recording and overlaps them. One voice plays continuously, another jumps around the piano under LFO control, and a third waits for MIDI notes. A Faust granulator processes a playing piano recording, while a separate drum fragment repeats as a tiny sound-file loop. Shared filters and a final Gain let these different textures meet in one mix.

## Try it

1. Mute layers to hear each approach on its own. Change Position, Duration and Density on the first Granola: listen for the transition from recognizable fragments to an overlapping cloud.
2. Slow the sample-and-hold LFO controlling the piano Granola's Position. Each new position selects different material, so the timbre jumps at each step.
3. Edit the `Jungl` pattern feeding the MIDI-triggered Granola. Leave gaps and listen to the grain texture become a rhythmic phrase instead of a continuous layer.
4. Change Grain Size, Speed and Probability in the Faust `Granulator`. It processes the same piano as the Granola piano voice, so differences come from the granulator alone.
5. Lengthen the drum sound file's 0.04-second loop. Listen for the point where a buzzing repetition becomes a recognizable drum fragment.

Use the final Gain to control the combined level, then shape the mixture with the shared filters. To adapt the score, replace one source at a time: a voice recording or field recording may reveal very different textures at the same grain settings.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

