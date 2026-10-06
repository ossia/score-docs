---
layout: default
title: Data visualization and sonification
description: "An example showing how to visualize data and turn it into sound"
parent: Advanced
grand_parent: Examples
permalink: /examples/advanced/data-visualization.html
score: /examples/advanced/data-visualization.zip
---

# Data visualization and sonification

![Imported data feeding expression-based audio and a GPU history graph]({{ site.baseurl }}/assets/scores/thumbnails/examples-advanced-data-visualization.png)

This example demonstrates visualization and sonification of the same data. A changing curve becomes a history of points on screen and a control for synthesized sound, offering different ways to explore its variations.

{% include try-on-web.html %}

[Download the example]({{ site.baseurl }}/assets/scores/examples/advanced/data-visualization.zip)

## Setup

Open the ZIP directly in score. The greenhouse-gas data's Data_value column has already been imported as an Automation; the original CSV is not bundled and is not needed for playback.

Use a compute-capable graphics backend and Airwindows for TapeDelay2. The history visualization uses embedded shaders originating in the `score-csf-testers` library package. It runs through score's native compute and rendering processes, not Qt Quick 3D.

## Try it

Start playback at a low listening level. Watch the point history grow as the imported curve plays, and compare its movement with the changing sound. The statistical displays offer another view of the data, including its mean, variance and consecutive differences.

- Adjust the smoothing to compare short-term fluctuations with a steadier musical gesture.
- Change the point size or color treatment to make different aspects of the history visible.
- Replace the imported curve with your own data and compare what becomes apparent by looking and listening.

The sound is synthesized from the curve rather than a recording of the original data source. Calibrators map statistical variations into usable control ranges for color and delay settings. The GPU history also depends on a delayed feedback connection; keep it when adapting the visualization.
