---
layout: default
title: "Pixel Utilities"
description: "Extract pixel values and lightness from textures"
parent: Processes
grand_parent: Reference
permalink: /processes/pixel-utilities.html
---

# Pixel Utilities


These processes convert image textures to control arrays. They do not themselves configure or transmit to physical LEDs: connect the resulting values to a suitable device address or lighting protocol.

## Lightness computer

Connect a texture to **In**. **Samples** contains values computed for its pixels. **Mode** selects Lightness, Value, Saturation, Hue, HSV, HSL, Red, Green, Blue, Alpha, RGB, RGBW or Swizzle. Multi-component modes produce interleaved components. **8-bit (* 255)** selects a 0–255-style scale rather than normalized values. **Swizzle** supplies a component arrangement when that mode is selected.

Use a suitably small source texture for an LED matrix rather than generating a large per-pixel control list unnecessarily. This is pixel conversion, not region averaging or an LED calibration system.

## Lightness sampler

Connect a texture to **In** and normalized `(x, y)` positions to **Positions**. **Samples** contains one perceptual-lightness value per position in the same order. Positions are converted to image pixels and clamped to its edges. The preview preserves the input aspect ratio and shows sampling locations; its refresh rate is separate from processing.

Use this when only a few points in a video should drive controls, instead of converting every pixel.

## Monitoring and rearrangement

- [LED View]({{ site.baseurl }}/processes/led-view.html) previews RGB/RGBW or brightness arrays and supports explicit grid sizing. It does not perform color correction or hardware output.
- [Array utilities]({{ site.baseurl }}/processes/array-utilities.html) can regroup interleaved channels, insert a constant component or reverse a sequence.
- [Video]({{ site.baseurl }}/processes/video.html) supplies moving images; [Graphics Utilities]({{ site.baseurl }}/processes/graphics-utilities.html) links texture processing tools.
