---
layout: default

title: Audio-reactive visuals
description: "An example showing how to create visuals that respond to audio in real-time"

parent: Video Examples
grand_parent: Examples

permalink: /examples/video/audioreactive.html
score: /examples/video/audioreactive.score
---

# Audio-Reactive Visuals

<video controls>
    <source src="{{ site.img }}/examples/video/audioreactive.mp4" type="video/mp4">
</video>

This example demonstrates creating visuals that respond dynamically to audio input.

## Overview

Audio-reactive graphics are a staple of live performance and music visualization. This example shows how to analyze audio and use the results to drive visual effects. Generated percussion and live audio animate a geometric pattern, while echo and analog-style distortion give it a sense of movement.

## Tips for audio-reactive graphics

- **Smooth your signals**: Compare a quick response with the more gradual zoom animation.
- **Map ranges**: Adjust analysis gain to suit quiet or loud sources.
- **Separate sources**: Mix the generated percussion with live audio to explore their different rhythms. The trace threshold responds to live input independently of this mix.

## Live performance

This type of patch is ideal for VJ performances, concert visuals, interactive installations and music videos.

## Inputs and controls

Use a build with Faust and its standard physical-modeling library for DjembeMIDI. The synthesizer code and shaders are saved in the score; no sound file is required. Select a working audio input for the microphone branch.

Compare Stereo Mixer inputs 1 and 2 to separate the generated percussion from live audio. RMS Gain controls sensitivity; OneEuro smoothing controls how zoom follows the envelope. The second RMS's Gate determines when the microphone affects the trace threshold.

## Try it

Start playback and adjust the mixer gains before increasing RMS Gain. The patch can generate its own analysis source through DjembeMIDI, while the separate trace-threshold branch depends on live input. To replace the microphone, connect a sound-file process to the relevant audio inlet.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})

## Learn more

- [[Analysis]] - Audio analysis processes (RMS, FFT, pitch, onset)
- [[ISF Shaders]] - Interactive Shader Format effects
- [[Smooth]] - Signal smoothing for fluid animations
- [[Graphics pipeline]] - How the rendering system works
