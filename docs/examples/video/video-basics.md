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

The looping `cat.mov` video feeds Echo Trace and Circular Screen, whose output is sent to `Window:/`. Microphone audio at `audio:/in/main` passes through Airwindows YBandpass and RMS. That envelope controls Echo Trace threshold and Circular Screen scale and sharpness; an LFO also changes RMS Gain.

## Files and playback

Open the ZIP directly in score. The included `cat.mov` is credited to [Andrew Kota on Pexels](https://www.pexels.com/video/the-cat-scratched-the-wood-3693815/); the score describes it as converted to HAP for looping and scrubbing. Use a build with the Airwindows YBandpass process for the audio-analysis branch.

Select a working microphone input, or connect a sound-file process to YBandpass. A Bass pattern sequencer is present but has no outgoing cable in this saved graph; it is not the audio source for RMS.

## Try it

Start playback and change the video inspector's stretch mode to compare fitting behaviour. Adjust YBandpass and RMS sensitivity, then observe how sound changes the trace and circular pattern. To scrub, double-click the time ruler and drag while holding the mouse button. The main interval has a manual ending time-sync, allowing the movie to keep looping until it is triggered.

[Download this example]({{ site.scores }}{{ page.score }})

## Learn more

- [[Video]] - Video playback process and supported formats
- [[ISF Shaders]] - Interactive Shader Format effects
- [[Graphics pipeline]] - How rendering works in ossia score
- [[Supported protocols and formats]] - Complete list of supported video codecs
