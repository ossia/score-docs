---
layout: default
title: CPU data bending
description: "Compare three Bendage image-degradation processes on the same camera input."
parent: Advanced
grand_parent: Examples
permalink: /examples/advanced/cpu-data-bending.html
score: /examples/advanced/cpu-data-bending.score
---

# CPU data bending

Compare three Bendage image-degradation processes on the same camera input.

{% include try-on-web.html %}

[Download the example]({{ site.baseurl }}/assets/scores/examples/advanced/cpu-data-bending.score)

## Run the patch

Install the Bendage add-on, select a working camera for the `Camera` device, and start playback. JPeg, Safe Word and Xlippy read `Camera:/` independently. The Grid shader places their outputs beside the unprocessed camera image and sends the mosaic to `Window:/`.

The saved JPeg Peggage value is about 89. A slow sawtooth LFO feeds two Micromaps: `10x` changes Safe Word's Fetish control, while `255x` changes Xlippy's Annoyance. Change these mappings or the LFO frequency to compare periodic modulation with manual controls.

These effects process images on the CPU; keep the input resolution modest. Without a camera, connect a video-file or shader texture to all three effects and Grid's first input. No external video is bundled.
