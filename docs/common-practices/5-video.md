---
layout: default

title: "Video techniques"
description: "Video in ossia score"

nav_order: 6
parent: Common practices

permalink: /common-practices/5-video.html
---

# Video techniques

## Playing videos

See the quick start guide: [[Working with video]].

## Fades

To perform a fade, a simple way is to use the Set Alpha shader filter, provided as part of the user library.

1. Add the video file.
2. Add the filter.
3. Connect one to another.
4. Connect the filter output to the viewport.
5. Add an automation to control the opacity.

Here is a complete example:

<video controls>
    <source src="{{ site.img }}/common-practices/video-fade-1.mp4" type="video/mp4">
</video>

## Making audio-reactive visuals

The core idea is to extract a parameter from the sound, and use it to modify a parameter
of a video filter.

The [[Audio utilities|Envelope]] process can be used to extract the average volume of an audio source.
The volume is often small and needs to be adjusted to fit the control values ; the [[Math expressions|Micromap]] process
allows to do that very easily.

Here is a video example:

<video controls>
    <source src="{{ site.img }}/common-practices/video-audioreactive-1.mp4" type="video/mp4">
</video>
