---
layout: default
title: Livecoding processes
description: "An example showing live coding with JavaScript, shaders and custom interfaces"
parent: Advanced
grand_parent: Examples
permalink: /examples/advanced/livecoding.html
score: /examples/advanced/livecoding.score
---

# Livecoding processes

![SpaceSpore shader and an LFO-driven JavaScript interface in separate scenario intervals]({{ site.baseurl }}/assets/scores/thumbnails/examples-advanced-livecoding.png)

This example demonstrates livecoding in score: changing a process's behavior while the composition runs. It brings together JavaScript data processing, shader visuals and a custom interactive interface.

{% include try-on-web.html %}

[Download the example]({{ site.baseurl }}/assets/scores/examples/advanced/livecoding.score)

## Try it

Start playback and release the start triggers for JS, Shaders and JSui. Each branch also has an interactive end, so you can run and stop the experiments independently.

- Open JS with its terminal-shaped editor button. Change the multiplier in its sine expression and watch the Signal display. Press Ctrl+Enter (Cmd+Enter on macOS) to apply the code.
- Open SpaceSpore's shader editor and experiment with the generated image. Right-click the editor button to choose a panel, separate window or central editor, including the background-render option.
- Open ui-example's external interface and try its custom controls while watching the adjacent Signal display.

These processes use presets from the default library. The JS process has been changed from its original average.qml preset; the saved code, rather than the preset name, determines its behavior. The custom interface uses Qt Quick for UI, while the visual branch uses an ISF shader, not Qt Quick 3D.
