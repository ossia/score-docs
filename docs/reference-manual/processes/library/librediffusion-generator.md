---
layout: default

title: LibreDiffusion Generator
description: "Real-time image generation through the LibreDiffusion backend"

parent: Processes
grand_parent: Reference

permalink: /processes/librediffusion-generator.html
---
# LibreDiffusion Generator

<!-- TODO screenshot: ![LibreDiffusion Generator]({{ site.img }}/reference/processes/librediffusion-generator.png "LibreDiffusion Generator") -->

Generates images in real time using the [LibreDiffusion](https://github.com/ossia)
backend. It exposes the same StreamDiffusion workflow as the
[StreamDiffusion](streamdiffusion.html) process — text-to-image and image-to-image on a
texture stream — provided by the `score-addon-librediffusion` add-on.

## Inputs

* **Image** — input texture for image-to-image.
* **Trigger** — run a generation step.
* **Positive / negative prompt** — generation guidance.
* **Engines path** — location of the installed diffusion engines.

## Generation controls

Seed, guidance scale, timesteps, resolution, CFG type, add-noise, denoising batch, manual
mode, delta, and feed-previous-input/output — see [StreamDiffusion](streamdiffusion.html)
for the full description of each control.

## Output

The generated **texture**.
