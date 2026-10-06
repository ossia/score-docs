---
layout: default
title: "Combine and Spread Signals"
description: "Gather two control signals into an array and separate them again."
parent: Processes
grand_parent: Reference
nav_exclude: true
permalink: /reference/process-examples/combine-spread.html
score: "/reference/processes/combine-spread.score"
---

# Combine and Spread Signals

![LFO and automation signals entering Combine, with Spread routing the components to separate signal displays.]({{ site.baseurl }}/assets/scores/thumbnails/reference-processes-combine-spread.png)

This example groups two movements into an array, then separates them again. **Combine** brings together an LFO and an automation curve; **Spread** retrieves the individual values. The displays let you compare the group with its components.

## Try it

Start playback and compare the combined display with the two individual displays. Edit the automation curve: only the second component should follow that edit. Change the LFO waveform or rate to distinguish the first component. The saved LFO has quantification enabled, so its output is stepped rather than a perfectly smooth sine.

No external device or file is involved. This patch is for value routing; it does not merge audio channels.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

