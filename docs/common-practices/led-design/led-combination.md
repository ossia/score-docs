---
layout: default
title: Combine shader LED arrays
description: "Sample three shader textures into RGB arrays, concatenate them and preview the resulting LED layout."
parent: LED design
grand_parent: Common practices
nav_exclude: true
permalink: /common-practices/led-design/led-combination.html
score: /common-practices/led-design/led-combination.score
---

# Combine shader LED arrays

![Three inputs entering Array Combiner in Append mode, with the combined colours displayed in LED View.]({{ site.baseurl }}/assets/scores/thumbnails/common-practices-led-design-led-combination.png)

Sample three shader textures into RGB arrays, concatenate them and preview the resulting LED layout.

[Download the example]({{ site.baseurl }}/assets/scores/common-practices/led-design/led-combination.score)

{% include try-on-web.html %}

## Run the preview

Start playback in nodal view. AcidAtTheDisco, color_swirl and SilverMaze each feed a Lightness computer configured for a 10×10 sample grid. Their RGB samples are normalized values, with 8-bit multiplication disabled. The first array goes directly to Array Combiner; the other two pass through Array tool before joining it.

Array Combiner uses Append with three inputs: it concatenates the sampled arrays rather than blending corresponding pixels. LED View interprets the output as RGB01. Change a Lightness computer's Size to alter its sampling density, or adjust the third branch's Array tool, saved with Brightness -0.647 and Pre-padding L 130, to see how padding and brightness affect the combined stream. Padding counts array elements; preserve RGB triplet alignment when adapting the patch to hardware.

No devices or external media are configured: the output is a preview, not DMX or a physical LED connection. A graphics backend is required for the embedded shaders. For hardware addressing and the separate shader tutorial, see [LED design]({{ site.baseurl }}/common-practices/13-led-design.html).

SilverMaze's embedded source credits Florian Berger (flockaroo), 2017, under CC BY-NC-SA 3.0; retain its attribution and consider that license when reusing the shader.
