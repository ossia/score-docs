---
layout: default
title: Cues, loops and exclusive playback
description: "Perform color changes and sound cues, choosing between loops, smooth transitions, overlapping clips and exclusive playback."
parent: Basics
grand_parent: Examples
permalink: /examples/basics/cues.html
score: /examples/basics/cues.zip
---

# Cues, loops and exclusive playback

![Play-once and repeating color automations beside tween comparisons and audio cue intervals]({{ site.baseurl }}/assets/scores/thumbnails/examples-basics-cues.png)

Perform a sequence of visual and sound cues without deciding every transition in advance. The visual section recalls looks, repeats a movement and eases from the current setting; the audio section either layers clips or allows only one at a time.

## Visual cues and transitions

Open the ZIP directly in score and start playback. A shader image responds to color, intensity and blur cues. No external OSC application is required.

- Alternate `Send cue 1` and `Send cue 2`. Each one jumps straight to a stored color.
- Trigger `Play once`, then `Repeat`. Let the repeating automation run through several cycles before triggering its end: it keeps going for as long as you wait.
- Fire the independent intensity cues in any order, then play the connected sequence, which enforces its own order and timing bounds.
- Set the blur manually before trying `Tween 1`, `Tween 2` and `No tween`. Look for the initial jump: Tween starts from the current value, which matters when a live operator may have changed the image.

The preview uses score's native ISF graphics. If adapting the cues to an external OSC application, the saved device listens on UDP 9997 and sends to `127.0.0.1:9996`.

## Audio cues and loops

Configure audio output and begin at a low level; the sounds are included. In `Scenario-nonexclusive`, trigger several sound intervals and listen to the layers accumulate. Repeat the same choices in `Scenario-exclusive`: starting one interval stops the others in that scenario. Use non-exclusive scenarios to build a texture and exclusive ones to replace one section with another.

Loop switches use the root interval's bar quantization. Request a switch just after a bar starts, then near its end, and listen to the common boundary at which each request takes effect. The performer chooses what comes next while quantization preserves the musical transition.

The annotations also introduce root start and stop states for initialization and shutdown cues. Try ordinary Stop, then Stop and reinitialize, and watch which settings return to a known look instead of keeping their last values.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

