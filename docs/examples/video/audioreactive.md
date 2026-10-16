---
layout: default

title: Audio-reactive visuals
description: "Animate a geometric pattern with percussion and live sound, from smooth zooms to sharp traces."

parent: Video Examples
grand_parent: Examples

permalink: /examples/video/audioreactive.html
score: /examples/video/audioreactive.score
---

# Audio-Reactive Visuals

<video controls>
    <source src="{{ site.img }}/examples/video/audioreactive.mp4" type="video/mp4">
</video>

Generated percussion and live sound animate a geometric pattern, while echo and analog-style distortion turn its movement into trails. The patch offers two kinds of musical response: a smoothed zoom that follows an envelope, and a trace threshold that reacts separately to the microphone.

## Shape the response

A Stereo Mixer combines the synthesized percussion with live audio for level analysis. RMS converts that sound into a control signal, and OneEuro smoothing makes the zoom follow it more gradually. A second RMS analyzes the microphone independently to control the trace threshold.

Separating these paths is useful for a performance in which a steady rhythmic source shapes the overall motion while a voice or instrument interrupts the image. Turning down the microphone in the mixer does not silence its separate trace-control path.

## Setup

Use a build with Faust and its standard physical-modeling library for DjembeMIDI. Select a working audio input for the microphone branch; the percussion is synthesized and needs no recording.

## Try it

- Start playback and compare Stereo Mixer inputs 1 and 2 separately. Listen to or watch the rhythm of the source you are analyzing before increasing RMS Gain.
- Change OneEuro smoothing and compare a zoom that follows individual accents with a more gradual movement.
- Adjust the second RMS's Gate while making quiet and loud sounds. Observe when the microphone begins to affect the trace threshold, independently of the mixed envelope.

To use recorded audio instead, connect a sound-file process to the microphone paths you want to replace.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})

## Learn more

- [[Analysis]] - Audio analysis processes (RMS, FFT, pitch, onset)
- [[ISF Shaders]] - Interactive Shader Format effects
- [[Smooth]] - Signal smoothing for fluid animations
- [[Graphics pipeline]] - How the rendering system works
