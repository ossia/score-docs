---
layout: default

title: Video manipulation
description: "An example showing basic video playback and effects processing"

parent: Video Examples
grand_parent: Examples

permalink: /examples/video/video-basics.html
score: /examples/video/video.zip
---

# Video Manipulation

<video controls>
    <source src="{{ site.img }}/examples/video/video.mp4" type="video/mp4">
</video>

This example demonstrates basic video playback and effects processing in ossia score.

## Overview

ossia score can play video files and apply real-time shader effects, with parameters that can be animated or controlled by audio. Here, a looping cat video becomes a patterned, audio-reactive image. Echo Trace retains parts of the moving picture, while Circular Screen adds a circular pattern that changes with the sound.

## ISF shaders

ISF (Interactive Shader Format) is a standard for video effects:
- Hundreds of free shaders available
- Parameters auto-exposed for control
- GPU-accelerated processing
- Compatible with other ISF hosts

## Working with video

To use video in your projects:

1. Drag a video file onto the timeline
2. Add ISF effects from the process library
3. Connect them with cables
4. Control parameters with automation or audio

## Files and playback

Open the ZIP directly in score. The included `cat.mov` is credited to [Andrew Kota on Pexels](https://www.pexels.com/video/the-cat-scratched-the-wood-3693815/); the score describes it as converted to HAP for looping and scrubbing. Use a build with the Airwindows YBandpass process for the audio-analysis branch.

Select a working microphone input, or use a sound-file process as the analysis source. The effects respond to this audio input, not to the Bass pattern sequencer present in the score.

## Try it

Start playback and change the video inspector's stretch mode to compare fitting behaviour. Adjust YBandpass and RMS sensitivity, then observe how sound changes the trace and circular pattern. To scrub, double-click the time ruler and drag while holding the mouse button. The main interval has a manual ending time-sync, allowing the movie to keep looping until it is triggered.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})

## Learn more

- [[Video]] - Video playback process and supported formats
- [[ISF Shaders]] - Interactive Shader Format effects
- [[Graphics pipeline]] - How rendering works in ossia score
- [[Supported protocols and formats]] - Complete list of supported video codecs
