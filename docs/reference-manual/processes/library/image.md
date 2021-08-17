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

# Creating the process
The process can be created simply by dropping an image or a set of images on the score, or on an interval.

If multiple images are dropped, it will be possible to switch through those with the Index control.

If those images are GIFs, then the index allows to sift through the gif's frames.

Here is an example of a simple score which loops over a set of images and applies a visual effect to the output, useful for VJ purposes:

<video controls>
    <source src="{{ site.img }}/reference/processes/images-1.mp4" type="video/mp4">
</video>
