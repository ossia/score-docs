---
layout: default

title: Video manipulation
description: "Turn a looping movie into sound-responsive traces and circular patterns."

parent: Video Examples
grand_parent: Examples

permalink: /examples/video/video-basics.html
score: /examples/video/video.zip
---

# Video Manipulation

<video controls>
    <source src="{{ site.img }}/examples/video/video.mp4" type="video/mp4">
</video>

A looping cat movie leaves traces and breaks into a circular pattern as sound changes its treatment. The movie file itself is never modified.

## Audio analysis to shader controls

The movie passes through Echo Trace, which retains parts of earlier images, and Circular Screen, which adds a patterned surface. A microphone-analysis branch filters the sound with YBandpass and measures its level with RMS; those changing values control the visual effects. The Bass pattern sequencer is not the source of this response.

The same footage reacts differently to a voice, an instrument or a recording. The ISF shaders expose their parameters as inlets, so audio analysis can be replaced by automation when a composed sequence is more appropriate.

## Setup

Open the ZIP directly in score and select a working microphone input. Use a build with the Airwindows YBandpass process. To work without a microphone, connect a sound-file process in place of the live analysis source.

The movie is credited to [Andrew Kota on Pexels](https://www.pexels.com/video/the-cat-scratched-the-wood-3693815/) and is converted to HAP for looping and scrubbing.

## Try it

- Start playback, make sound, and adjust RMS sensitivity until quiet and loud sounds produce visibly different treatments. Move YBandpass's frequency to choose which part of the sound drives that response.
- Change the Video inspector's stretch mode to either preserve the movie's proportions or fill the output.
- Double-click the time ruler and drag while holding the mouse button to scrub. Drag smoothly, then jump, and watch how Echo Trace's trails differ.

The main interval has a manual ending time-sync: the movie keeps looping until you trigger it.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})

## Learn more

- [[Video]] - Video playback process and supported formats
- [[ISF Shaders]] - Interactive Shader Format effects
- [[Graphics pipeline]] - How rendering works in ossia score
- [[Supported protocols and formats]] - Complete list of supported video codecs
