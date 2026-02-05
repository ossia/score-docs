---
layout: default

title: Video manipulation
description: "An example showing basic video playback and effects processing"

parent: Video Examples
grand_parent: Examples

permalink: /examples/video/video-basics.html
---

# Video Manipulation

<video controls>
    <source src="{{ site.img }}/examples/video/video.mp4" type="video/mp4">
</video>

This example demonstrates basic video playback and effects processing in ossia score.

## Overview

ossia score can play video files and apply real-time shader effects, with parameters that can be animated or controlled by audio.

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

## Try it

Open this example to see video effects in action. Try adjusting the effect parameters!

[Download this example]({{ site.scores }}/examples/video/video.score)

## Learn more

- [[Video]] - Video playback process and supported formats
- [[ISF Shaders]] - Interactive Shader Format effects
- [[Graphics pipeline]] - How rendering works in ossia score
- [[Supported protocols and formats]] - Complete list of supported video codecs
