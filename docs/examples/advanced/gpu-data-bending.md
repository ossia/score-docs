---
layout: default
title: GPU data bending
description: "Stretch and retain camera motion with sorting, compression-like glitches and optical-flow distortion."
parent: Advanced
grand_parent: Examples
permalink: /examples/advanced/gpu-data-bending.html
score: /examples/advanced/gpu-data-bending.score
---

# GPU data bending

Make motion linger, smear or break into compression-like artifacts. Five shader treatments appear beside a corrected camera view, letting you compare how each transforms a gesture rather than judging a glitch in isolation.

{% include try-on-web.html %}

[Download the example]({{ site.baseurl }}/assets/scores/examples/advanced/gpu-data-bending.score)

## Try it

Select an available camera in the Camera device settings, grant capture permission where required, and start playback. The camera passes through Color Controls before splitting into the different treatments, giving them a common source.

- Move, then hold still. Compare effects that rearrange the current picture with those that retain or distort its recent motion.
- Change FastMosh's update rate to explore how often fresh imagery replaces retained material.
- Adjust Sorting Smear's adaptation or Optical Flow Distort's amount and repeat the same gesture. Compare the recognizable camera movement with the distortion it leaves behind.
- Change the LFOs that reset or refresh effects to alter the rhythm of those changes.

Use a GPU graphics backend. The shaders are saved in the score; to work without a camera, connect a movie or generated texture to Color Controls.
