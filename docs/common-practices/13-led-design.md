---
layout: default

title: LED design
description: "Turn shader images or generated arrays into LED patterns, preview them and prepare hardware output."

nav_order: 13
parent: Common practices

permalink: /common-practices/13-led-design.html
score: /common-practices/led-design/led-with-shaders.score
---

# LED design

Design a moving field of light either as an image or as a list of colour values. Shaders are a useful starting point when you want textures, turbulence or other image-based effects; arrays give you direct control over the rhythm and ordering of individual channels. Both approaches can be previewed before connecting LEDs.

*score* provides authoring tools for RGB data and connections to LED hardware through DMX or directly through SPI. Choose a technique below, then adapt its output to your controller's channel layout.

## Tools of the trade
### List of useful devices

- [[Art-Net Device]]: when created without any fixture, the raw DMX channels will be available, as well as the ability to send raw messages to the whole device.

### List of useful objects

Most of the objects useful for LED shows are in the process library, in the `Control > Mappings` and `Control > Generators` categories.

- [[Array utilities|Array tool]]
- [[Array utilities|Array combiner]]
- [[Array utilities|Array recombiner]]
- [[Array utilities|Array flattener]]
- [[Math expressions|Arraygen]]
- [[Math expressions|Arraymap]]

To generate LED content from shaders, one can use the [[Pixel utilities|Lightness Computer]] object which will convert an input texture into a series of pixels.

To visualize LED output, one can use the [[Pixel utilities|LED View]] process.

## Controlling LEDs from a shader

![LEDs with shaders]({{ site.img }}/common-practices/led-design/led-shaders.png "LEDs with shaders")

[Download the example score here]({{ site.scores }}{{ page.score }}).

{% include try-on-web.html %}

Turn an animated texture into a low-resolution field of light. In the downloadable patch, an electric-noise shader supplies the image and [[Pixel utilities|Lightness Computer]] samples it on a 10×10 grid. Its RGB values feed both an LED preview and a device output, so the same pattern can be studied on screen before it reaches a physical installation.

Start playback and compare the preview while changing the shader's zoom or colour. Change Lightness Computer's Size to explore how much of the image's detail survives at a coarser sampling resolution. The enabled 8-bit conversion produces channel values for the preview's RGB mode.

The saved device uses sACN and points to the local machine, not your LED controller. Before connecting hardware, configure its destination and universe, check the RGB channel order and keep the sample count within the available channels. The shader needs a graphics backend; no external image is required. Its embedded source credits nimitz under CC BY-NC-SA 3.0, which matters when reusing it.

## Creating LEDs from generative array computations

![LEDs with arrays]({{ site.img }}/common-practices/led-design/led-arrays.png "LEDs with arrays")

[Download the array example]({{ site.scores }}/common-practices/led-design/led-with-arrays.score).

Use expressions when the pattern should grow from timing, repetition or another numerical data source rather than a texture. In the [array example]({{ site.baseurl }}/common-practices/led-design/led-with-arrays.html), differently phased sine waves become sections of a changing colour strip. It generates the values without shader rendering.

For a design in which you want independent red, green and blue channels, the general workflow is:

1. Generate equally sized arrays for R, G and B, optionally adding W for RGBW. [[Math expressions|Arraygen]] can calculate one value per element.
2. Use [[Array utilities|Array combiner]] in Intersperse mode to turn separate colour arrays into consecutive pixels: `[R, R, R]`, `[G, G, G]` and `[B, B, B]` become `[R, G, B, R, G, B, R, G, B]`.
3. Use [[Array utilities|Array tool]] to adjust gain, constrain the output range or add spacing before sending the result onward.

The downloadable array patch explores a different arrangement: Append joins whole arrays end to end. Compare the two approaches when deciding whether each generator should control a colour channel or a section of the strip.

For a complete patch, see [Generate LED arrays with expressions]({{ site.baseurl }}/common-practices/led-design/led-with-arrays.html).


## Combining multiple LED strips in one array

![Combine LED strips in one arrays]({{ site.img }}/common-practices/led-design/led-combine.png "Combine LED strips in one arrays")

[Download the combination example]({{ site.scores }}/common-practices/led-design/led-combination.score).

Give different sections of an installation their own animation while sending one continuous list of colours. The [combination example]({{ site.baseurl }}/common-practices/led-design/led-combination.html) samples three shaders, then joins their arrays with [[Array utilities|Array combiner]] in Append mode. It places the sections one after another rather than blending their images.

Use [[Array utilities|Array tool]] on an individual section to change its brightness or add dark spacing without altering the others. Padding is counted in channel values, not pixels: use multiples of three for complete RGB pixels and check the final length against your hardware layout.

See [Combine shader LED arrays]({{ site.baseurl }}/common-practices/led-design/led-combination.html) for a downloadable patch and its routing.
