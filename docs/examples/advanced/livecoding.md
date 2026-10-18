---
layout: default
title: Livecoding processes
description: "Change a running control signal, shader image and custom interface by editing their code."
parent: Advanced
grand_parent: Examples
permalink: /examples/advanced/livecoding.html
score: /examples/advanced/livecoding.score
---

# Livecoding processes

![Independent livecoding sections for a generated image and interactive controls]({{ site.baseurl }}/assets/scores/thumbnails/examples-advanced-livecoding.png)

Change the rules of a running composition and observe the result without rebuilding the patch. Three independent sections let you reshape a control signal, edit a generated image and interact with a custom interface.

{% include try-on-web.html %}

[Download the example]({{ site.baseurl }}/assets/scores/examples/advanced/livecoding.score)

## Try it

Start playback and release the start triggers for JS, Shaders and JSui. Each section also has an interactive end, so you can run and stop the experiments independently.

- **Reshape a signal.** Open JS with its terminal-shaped editor button. An LFO passes through `Math.sin(10. * in1.value)` before reaching Signal display. Change the multiplier, then press Ctrl+Enter (Cmd+Enter on macOS) to apply it. A larger multiplier puts more oscillations across the same incoming sweep.
- **Change an image.** Open SpaceSpore's shader editor and find the ray-marching step `t += 1.8 * d;`. Change its multiplier and apply the edit: the generated form changes on the next frame. Right-click the editor button to choose a panel, separate window or central editor, including the background-render option.
- **Perform through an interface.** Open ui-example's external interface and move its controls while watching the adjacent Signal display, which also shows the incoming LFO.

Use a build with JavaScript/QML, Qt Quick UI and ISF shader support. These processes come from the default library, but the saved JS code has already been edited: it applies a sine function instead of averaging values.
