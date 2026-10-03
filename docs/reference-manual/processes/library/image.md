---
layout: default

title: Image process
description: "Using static images or gifs in visuals"

parent: Processes
grand_parent: Reference

permalink: /processes/image.html
---

# Image Process

![Image Process]({{ site.img }}/reference/processes/image_process.png "Image Process Example")

This process displays an image in a viewport.
Multiple image processes can display their images by outputting in a single port.

## Creating the process
The process can be created simply by dropping an image or a set of images on the score, or on an interval.

If multiple images are dropped, it will be possible to switch through those with the Index control.

If those images are GIFs, then the index allows to sift through the gif's frames.

Image decoding uses the formats provided by the installed Qt image readers. PNG, JPEG, GIF and other formats available in the build can be imported; do not assume that every installation includes HEIC, JPEG 2000 or other optional readers.

## Controls and output

- **Index** selects an image or decoded animation frame; automate it to build a slideshow or frame-stepped animation.
- **Images** edits the list of source files.
- **Opacity**, **Position**, **Scale X** and **Scale Y** control placement and visibility.
- **Tile** selects **Single**, **Clamp**, **Tile** or **Mirror** sampling outside the image.
- **Scale** selects **Original**, **Black bars**, **Fill** or **Stretch** sizing.
- **Texture Out** connects to another texture process or a [Window device]({{ site.baseurl }}/devices/window-device.html).

An image list is not a timed video stream: use Index automation to choose its timing. For codec-based playback or FFmpeg image sequences, see [Video]({{ site.baseurl }}/processes/video.html) and [Video formats and color]({{ site.baseurl }}/processes/video-formats-color.html).

## Example

Here is an example of a simple score which loops over a set of images and applies a visual effect to the output, useful for VJ purposes:

<video controls>
    <source src="{{ site.img }}/reference/processes/images-1.mp4" type="video/mp4">
</video>
