---
layout: default

title: Video Examples
description: "Make responsive images, grow feedback patterns and fit moving visuals to projection spaces."

parent: Examples
has_children: true

permalink: /examples/video
---

# Video Examples

Start with the kind of image you want to make: footage that reacts to a performer, patterns that grow from their own history, or a composition that spans a physical space. These patches let you isolate one technique before bringing it into a larger performance.

## Make an image respond

For a first patch, open [Video manipulation]({{ site.baseurl }}/examples/video/video-basics.html): a looping movie becomes patterned traces controlled by sound. Then choose where your image and its control should come from:

- [Camera input]({{ site.baseurl }}/examples/video/camera.html) keeps a live subject visible while sound changes its colour, blur and distortion.
- [Audio-reactive visuals]({{ site.baseurl }}/examples/video/audioreactive.html) combines generated percussion and live sound to animate a geometric pattern.
- [Camera blobs, contours and tracking]({{ site.baseurl }}/examples/video/traditional-computer-vision.html) reduces the camera view to regions, outlines and tracked positions, ready for exploring camera-based interaction.

## Compose motion and timing

- [Video transforms and fitting]({{ site.baseurl }}/examples/video/video-scale.html) separates moving an image from fitting it to a display's proportions.
- [Scrubbing video and scenario time]({{ site.baseurl }}/examples/video/video-time-jamming.html) makes speed, reversal and jumps through an arrangement playable controls.
- [Timed sound and image effects]({{ site.baseurl }}/examples/video/sound-and-image.html) composes image distortion and changing reverberation with independently editable audio and video.
- [FFmpeg input and output streams]({{ site.baseurl }}/examples/video/ffmpeg-streaming.html) sends a treated image to another application while retaining a separate local treatment.

## Let patterns develop

Begin with [Delayed shader texture feedback]({{ site.baseurl }}/examples/video/shader-texture-feedback.html) to see how repeatedly processing an earlier frame turns a moving dot into a complex trail.

- [Layered analog-style effects]({{ site.baseurl }}/examples/video/analog-effects.html) mixes fresh procedural patterns with distressed image history.
- [Reaction-diffusion geometry feedback]({{ site.baseurl }}/examples/video/2d-geometry-feedback-reaction-diffusion.html) grows organic structures by retaining simulation state instead of an image.
- [Compute-rendered Clifford attractor]({{ site.baseurl }}/examples/video/compute-image.html) accumulates points into a slowly changing mathematical form.
- [Multiple shader render targets]({{ site.baseurl }}/examples/video/multi-render-target.html) compares colour, image-derived normals and edges from the same changing source.

## Fit the work to a space

[Mapping textures to editable shapes]({{ site.baseurl }}/examples/video/video-mapping-rect.html) composes images within quads, polygons and freehand outlines. Use it when the shapes themselves are part of the composition. [Multi-projector output mapping]({{ site.baseurl }}/examples/video/video-mapping-multi-projector.html) aligns and blends an already composed image across displays. The two techniques can be combined.

## Reference and setup

See [Video]({{ site.baseurl }}/processes/video.html) for playback modes, HDR conversion and pixel formats, [ISF shaders]({{ site.baseurl }}/processes/shaders.html) for image effects, and [Compute Shaders]({{ site.baseurl }}/processes/compute-shaders.html) for GPU computation. Capture, streaming and output backends are listed under [Devices]({{ site.baseurl }}/devices.html); availability depends on platform and build. Each example notes its particular camera, package or output requirements.
