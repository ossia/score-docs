---
layout: default

title: Multi-media patching
description: "Use sound analysis, MIDI patterns and automation to animate a textured 3D object and video effects."

parent: Basics
grand_parent: Examples

permalink: /examples/basics/all-media.html
score: /examples/basics/all-media.zip
---

# Multi-media Patching

<video controls>
    <source src="{{ site.img }}/examples/basics/all-media.mp4" type="video/mp4">
</video>

A textured goblet moves and changes treatment under the influence of sound, MIDI patterns and automation. The patch brings these different kinds of material into one composition: musical activity becomes visual motion, while composed curves provide another layer of control.

## Connect media through control

Audio analysis converts sound into values that can animate geometry and influence video effects. MIDI patterns create the musical activity, and smoothing shapes how quickly the resulting visual response changes. Colour and rotation automations add gestures that do not depend on the audio.

The transferable idea is not that every cable carries the same thing. Audio, MIDI, textures and geometry retain their roles, while analysis and control values connect them. Rendering uses score's native geometry processes.

## Try it

Open the ZIP directly in score. Use a build with Deuterium, Faust and Airwindows support, configure an audio output, and begin at a low listening level.

- Start playback and watch the model and effects respond. Change an analyzer's gain to compare small and exaggerated visual gestures.
- Alter the smoothing and compare immediate accents with gradual movement.
- Edit the colour or rotation automation, then change a MIDI pattern. Notice which gestures are composed directly and which follow the changed musical activity.

Sound serves two roles here: it provides audible material and control signals for the image. The Dirt effect is routed to the parent audio mix, while other branches feed analysis. When adapting the patch, decide which branches should be heard as well as measured.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})

## Learn more

- [[Graphics pipeline]] - How video and 3D rendering works
- [[Object loader]] - Loading 3D mesh files
- [[Model display]] - Rendering 3D objects
- [[Analysis]] - Audio analysis processes (RMS, FFT, etc.)
- [[ISF Shaders]] - Interactive Shader Format effects
