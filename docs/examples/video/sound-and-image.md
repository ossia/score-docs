---
layout: default
title: "Timed sound and image effects"
description: "An example showing how to arrange sound and video effects together on the timeline."
parent: Video Examples
grand_parent: Examples
permalink: /examples/video/sound-and-image.html
score: /examples/video/sound-and-image.zip
---

# Timed sound and image effects

![Drift LFO connected to v002 Glitch Analog above video-effect automation curves]({{ site.baseurl }}/assets/scores/thumbnails/examples-video-sound-and-image.png)

This example demonstrates arranging sound and video effects together on the timeline.

## Overview

A one-minute movie is treated with compression artifacts and analog-style distortion. Automation curves shape the effects over time, while a drifting modulation adds variation.

The accompanying audio has its own arrangement: two recordings, a short silence and a looping amen break. Automated reverberation changes the sound as the piece develops. Keeping sound and image in separate processes allows their timing and treatment to be edited independently.

## Try it

Open the ZIP directly in score. It includes `Video/out.mov`, the two spoken recordings and `Audio/000_AMEN.WAV`. Use a build with the JPeg and Aether processes and an available audio output.

Start from the beginning to compare the fixed video duration (about 60 seconds) with the audio edits. Change one automation curve at a time to separate compression artifacts, sync distortion and reverberation. Video and audio are separate processes: replacing the movie does not automatically replace the audio track.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
