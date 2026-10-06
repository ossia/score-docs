---
layout: default
title: Combine shader LED arrays
description: "Combine several shader animations into one LED preview."
parent: LED design
grand_parent: Common practices
nav_exclude: true
permalink: /common-practices/led-design/led-combination.html
score: /common-practices/led-design/led-combination.score
---

# Combine shader LED arrays

![Three inputs entering Array Combiner in Append mode, with the combined colours displayed in LED View.]({{ site.baseurl }}/assets/scores/thumbnails/common-practices-led-design-led-combination.png)

This example combines three shader animations into a single LED pattern. Each image supplies a section of the colour array, letting you build a longer sequence from several visual sources.

[Download the example]({{ site.baseurl }}/assets/scores/common-practices/led-design/led-combination.score)

{% include try-on-web.html %}

## Run the preview

Start playback in nodal view. Lightness computer samples each shader on a 10×10 grid, and **Array Combiner** joins the resulting arrays. Its Append mode places them one after another rather than blending corresponding pixels. The samples are normalized, with 8-bit multiplication disabled, so **LED View** uses RGB01.

Try changing a Lightness computer's Size to alter the sampling density. The second and third branches also have **Array tool** processes: adjust their brightness or padding to change the balance and spacing of the pattern. Padding counts array elements, not pixels; preserve RGB triplet alignment when adapting the example to hardware.

No devices or external media are configured: the output is a preview, not DMX or a physical LED connection. A graphics backend is required for the embedded shaders. For hardware addressing and the separate shader tutorial, see [LED design]({{ site.baseurl }}/common-practices/13-led-design.html).

SilverMaze's embedded source credits Florian Berger (flockaroo), 2017, under CC BY-NC-SA 3.0; retain its attribution and consider that license when reusing the shader.
