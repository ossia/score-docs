---
layout: default
title: Switch audio and video pipelines
description: "An example showing how to switch audio and visual effects during a performance"
parent: Advanced
grand_parent: Examples
permalink: /examples/advanced/pipeline-switching.html
score: /examples/advanced/pipeline-switching.score
---

# Switch audio and video pipelines

![Separate Distortion and Chorus intervals containing their audio effect chains]({{ site.baseurl }}/assets/scores/thumbnails/examples-advanced-pipeline-switching.png)

This example demonstrates switching between audio and video effects during a generative performance. Instead of keeping every effect active, the scenario chooses which processing interval runs.

{% include try-on-web.html %}

[Download the example]({{ site.baseurl }}/assets/scores/examples/advanced/pipeline-switching.score)

## Setup

Use a score build with Synthimi/Kaboom, Airwindows and Faust, and the default shader library. Configure audio output at `audio:/out/main` and begin at a low listening level. No external media is required: pattern sequencers drive the instruments and shaders generate the visuals.

The OSC device listens on UDP 9997 and sends to `127.0.0.1:9996`. Its `/video_switch` and `/audio_switch` parameters are written inside the patch and read by scenario conditions; an external controller is not the source of the saved modulation.

## Try it

Start playback and watch the active intervals while listening. The audio alternates between chorus and distortion, while the visuals switch between Edge Blowout and Dot Screen. Move the output-window cursor to influence ParticleZoom.

Internal LFOs drive the switching, with conditions on the two switch addresses choosing an effect around a threshold of 0.5. Quantization gives the changes a musical timing: the document labels the visual changes as beat switching and the audio changes as bar switching.

Try changing the LFO rhythm or the trigger thresholds, then compare how often each effect is selected. This lets you arrange contrasting treatments without interrupting their source. Changing an effect parameter alone does not change which interval runs.
