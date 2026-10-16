---
layout: default
title: "Combine and Spread Signals"
description: "Carry two independent movements together, then recover each one for separate control."
parent: Processes
grand_parent: Reference
nav_exclude: true
permalink: /reference/process-examples/combine-spread.html
score: "/reference/processes/combine-spread.score"
---

# Combine and Spread Signals

![LFO and automation signals entering Combine, with Spread routing the components to separate signal displays.]({{ site.baseurl }}/assets/scores/thumbnails/reference-processes-combine-spread.png)

Group two independent movements so they can travel together without losing their identities. An LFO supplies a repeating rhythm and an automation curve supplies a drawn gesture. **Combine** packs them into an array; **Spread** separates them again. This pattern is useful when collecting several controls for a shared processing stage before sending them to different destinations.

## Try it

Start playback and compare the combined display with the two individual traces. Edit the automation curve and watch the second component change while the first continues its rhythm. Then change the LFO rate to vary only the first component. Its quantification is enabled, which explains the steps in that trace.

The array holds control values, not audio channels. No external device is needed to explore this routing pattern.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

