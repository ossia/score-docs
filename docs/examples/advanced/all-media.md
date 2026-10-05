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

This patch crosses between MIDI, audio, values, geometry and textures. It uses score's native Geometry Loader, Geometry filter and Model Display pipeline, not Qt Quick 3D.

## Open the project

Open the ZIP directly in score. The graph loads the bundled `goblet.obj`, `PianoVib97_2.wav` and `Data/Oberheim_DmxKit/drumkit.xml` with its samples. It also needs Deuterium, Faust and Airwindows support.

## Trace the branches

1. Start playback. Geometry Loader sends the goblet through the `Twist` geometry filter to Model Display. Graph Paper generates its texture; a color automation changes the background color, and a float automation expanded to `[x,x,x]` changes model rotation.
2. Follow the piano sound into three RMS analyzers. Their value outputs control Convergence, Echo Trace and the geometry twist. Smooth and Micromap scale one envelope, with Signal display showing the result.
3. A Pattern sequencer plays the Oberheim drum kit. Its audio passes through parallel RingModulator and Faust delay paths, then further Airwindows processing before joining an RMS input. A second pattern is converted from note indices into delay-time values by Midi filter and `x-14.75`.
4. Follow Model Display → Convergence → Echo Trace → Edges to `Window:/`. Change an analyzer's gain and compare the visual reaction.

The saved audio branches feed analysis rather than an audible parent output: an active audio graph does not imply that it is routed to speakers. To listen, explicitly route a chosen sound output to the parent mix or an audio device and lower the level first. The root audio destination is `audio:/out/main`.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})

## Learn more

- [[Graphics pipeline]] - How video and 3D rendering works
- [[Object loader]] - Loading 3D mesh files
- [[Model display]] - Rendering 3D objects
- [[Analysis]] - Audio analysis processes (RMS, FFT, etc.)
- [[ISF Shaders]] - Interactive Shader Format effects
