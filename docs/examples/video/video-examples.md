---
layout: default

title: Video Examples
description: "Examples demonstrating video processing in ossia score"

parent: Examples
has_children: true

permalink: /examples/video
---

# Video Examples

These examples demonstrate video playback, shader effects, and audio-reactive visuals in ossia score.

Start with [Video manipulation]({{ site.baseurl }}/examples/video/video-basics.html), [Camera input]({{ site.baseurl }}/examples/video/camera.html), or [Audio-reactive visuals]({{ site.baseurl }}/examples/video/audioreactive.html).

For current playback modes, HDR conversion and pixel-format handling, see [Video]({{ site.baseurl }}/processes/video.html). For shader-based processing, see [ISF shaders]({{ site.baseurl }}/processes/shaders.html) and [Compute Shaders]({{ site.baseurl }}/processes/compute-shaders.html). Capture, streaming and output backends are listed under [Devices]({{ site.baseurl }}/devices.html); availability is platform- and build-dependent.

## Playback and live inputs

- [Video manipulation]({{ site.baseurl }}/examples/video/video-basics.html): a looping movie with microphone-controlled shaders.
- [Camera input]({{ site.baseurl }}/examples/video/camera.html): process live capture with audio-reactive effects.
- [Audio-reactive visuals]({{ site.baseurl }}/examples/video/audioreactive.html): combine generated percussion and microphone analysis.
- [Video transforms and fitting]({{ site.baseurl }}/examples/video/video-scale.html): compare transform, extend and fit modes.
- [Scrubbing video and scenario time]({{ site.baseurl }}/examples/video/video-time-jamming.html): control speed, tempo and playback position.
- [Timed sound and image effects]({{ site.baseurl }}/examples/video/sound-and-image.html): arrange separate audio and video tracks.
- [FFmpeg input and output streams]({{ site.baseurl }}/examples/video/ffmpeg-streaming.html): receive, process and resend local UDP video.

## GPU effects and feedback

- [Layered analog-style effects]({{ site.baseurl }}/examples/video/analog-effects.html): combine procedural sources, grain and feedback.
- [Delayed shader texture feedback]({{ site.baseurl }}/examples/video/shader-texture-feedback.html): accumulate distortion across frames.
- [Reaction-diffusion geometry feedback]({{ site.baseurl }}/examples/video/2d-geometry-feedback-reaction-diffusion.html): preserve simulation state in GPU geometry.
- [Compute-rendered Clifford attractor]({{ site.baseurl }}/examples/video/compute-image.html): generate an image directly from a compute shader.
- [Multiple shader render targets]({{ site.baseurl }}/examples/video/multi-render-target.html): inspect separate outputs from one shader.

## Analysis and projection mapping

- [Camera blobs, contours and tracking]({{ site.baseurl }}/examples/video/traditional-computer-vision.html): CPU image analysis followed by GPU point drawing.
- [Mapping textures to editable shapes]({{ site.baseurl }}/examples/video/video-mapping-rect.html): quads, polygons, soft edges and texture selection.
- [Multi-projector output mapping]({{ site.baseurl }}/examples/video/video-mapping-multi-projector.html): source regions, perspective transforms and edge blending across displays.
