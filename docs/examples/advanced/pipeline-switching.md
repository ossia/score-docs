---
layout: default
title: Switch audio and video pipelines
description: "Alternate audio and visual treatments on musical boundaries without stopping their sources."
parent: Advanced
grand_parent: Examples
permalink: /examples/advanced/pipeline-switching.html
score: /examples/advanced/pipeline-switching.score
---

# Switch audio and video pipelines

![Chorus and distortion placed in separate selectable processing intervals]({{ site.baseurl }}/assets/scores/thumbnails/examples-advanced-pipeline-switching.png)

Let a generative performance alternate between contrasting treatments: chorus and distortion for sound, Edge Blowout and Dot Screen for the image. Instead of leaving every effect active, the scenario selects which processing interval runs while the sources continue.

{% include try-on-web.html %}

[Download the example]({{ site.baseurl }}/assets/scores/examples/advanced/pipeline-switching.score)

## How the switching works

Internal LFOs write control values that scenario conditions compare around a threshold of 0.5. Quantization places the resulting changes on musical boundaries: the score labels the visual changes as beat switching and the audio changes as bar switching.

Sources, treatments and switch times are set in different places. Changing an effect parameter alters its sound or appearance; changing the switching control determines when that effect runs.

## Setup

Use a build with Synthimi/Kaboom, Airwindows and Faust, plus the default shader library. Configure an audio output and begin at a low listening level. Pattern sequencers drive the instruments and shaders generate the visuals, so no external media is required.

The saved switching is generated inside the patch, not by an external controller. If adapting it for OSC control, the device listens on UDP 9997 and sends to `127.0.0.1:9996`; its `/video_switch` and `/audio_switch` parameters are the controls read by the scenario.

## Try it

- Start playback and watch the active intervals while listening. The visual treatment can switch on any beat; the audio treatment only on a bar.
- Change an LFO's rhythm: each threshold crossing takes effect at the next quantized boundary.
- Move a condition's threshold away from 0.5 to keep one treatment selected longer than the other.
- Move the output-window cursor to influence ParticleZoom without changing the selected effect pipeline.
