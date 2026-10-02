---
layout: default

title: StreamDiffusion
description: "Real-time image generation with StreamDiffusion (text-to-image, image-to-image)"

parent: Processes
grand_parent: Reference

permalink: /processes/streamdiffusion.html
---
# StreamDiffusion

<!-- TODO screenshot: ![StreamDiffusion]({{ site.img }}/reference/processes/streamdiffusion.png "StreamDiffusion") -->

Real-time diffusion-based image generation inside score. It can run text-to-image and
image-to-image workflows on a texture stream, making it possible to transform live video
or generate visuals on the fly. Requires the appropriate diffusion engines to be
installed (see **Engines path**).

## Image / Trigger

* **Image** — input texture used for image-to-image workflows.
* **Trigger** — fire a generation step.

## Workflow

Selects the generation mode (text-to-image, image-to-image, …).

## Prompts

* **Positive prompt** — what to generate.
* **Negative prompt** — what to avoid.

## Engines path

Path to the installed diffusion engines/models.

## Generation controls

* **Seed** — random seed for reproducibility.
* **Guidance scale** — prompt adherence strength.
* **Timesteps** — number of diffusion steps.
* **Resolution** — output size.
* **CFG type** / **Delta** — classifier-free guidance settings.
* **Add noise** / **Denoising batch** — denoising behaviour.
* **Manual mode** — step manually instead of continuously.
* **Feed previous input / output** — feed the previous frame back for temporal coherence.

## Output

The generated **texture**.

> See also [LibreDiffusion Generator](librediffusion-generator.html), the LibreDiffusion
> backend for this process.
