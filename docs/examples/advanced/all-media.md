---
layout: default

title: Multi-media patching
description: "An example showing how to patch any content type: audio, video, MIDI, textures, geometries"

parent: Basics
grand_parent: Examples

permalink: /examples/basics/all-media.html
score: /examples/basics/all-media.zip
---

# Multi-media Patching

<video controls>
    <source src="{{ site.img }}/examples/basics/all-media.mp4" type="video/mp4">
</video>

This example demonstrates ossia score's ability to patch together diverse media types including audio, video, 3D geometries, and textures in a unified workflow.

## Overview

ossia score allows you to manage audio, video, data and 3D, and process them all using the same cable-based patching system. Here, sound analysis animates a textured goblet and influences video effects. MIDI patterns, automations and audio envelopes become complementary ways of controlling the image.

The example uses score's native geometry and rendering processes, not Qt Quick 3D.

## Try it

Open the ZIP directly in score. It includes the goblet model, piano sample and drum kit; Deuterium, Faust and Airwindows support are also needed.

- Start playback and watch the model and effects respond to the audio analysis.
- Change an analyzer's gain to adjust the visual response, or alter the smoothing to make movement more gradual.
- Edit the color and rotation automations to combine composed movement with sound-driven changes.
- Try replacing a sound or changing a MIDI pattern and compare the resulting image.

The saved audio branches feed analysis rather than an audible output. To listen, explicitly route a chosen sound output to the parent mix or an audio device and lower the level first. The root audio destination is `audio:/out/main`.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})

## Learn more

- [[Graphics pipeline]] - How video and 3D rendering works
- [[Object loader]] - Loading 3D mesh files
- [[Model display]] - Rendering 3D objects
- [[Analysis]] - Audio analysis processes (RMS, FFT, etc.)
- [[ISF Shaders]] - Interactive Shader Format effects
