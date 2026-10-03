---
layout: default
title: StreamDiffusion
description: "Generate and transform textures with the optional LibreDiffusion runtime"
parent: Processes
grand_parent: Reference
permalink: /processes/streamdiffusion.html
---

# StreamDiffusion

**StreamDiffusion** generates images from text or transforms incoming textures using diffusion-model engines. It is the process registered by the optional **LibreDiffusion** add-on; there is no separate “LibreDiffusion Generator” process in that add-on.

## Requirements and first connection

The current add-on targets **Windows and Linux**. It dynamically loads the LibreDiffusion runtime; a working CUDA-capable runtime environment and compatible exported engines are required for generation. A process appearing in the library does not prove that its runtime, GPU or model engines are available. With no runtime or no **Engines** directory selected, it produces no new generated frame.

1. Select **Workflow** to match the model engines you have installed.
2. Set **Engines** to the exported engine directory, not to an arbitrary model checkpoint file. Required files depend on the workflow; the ordinary SD paths use files such as `unet.engine`, `vae_encoder.engine` and `vae_decoder.engine` alongside text-encoding resources.
3. Set **Resolution** to a size supported by those engines and enter **Prompt +**.
4. For image-to-image workflows, connect a texture source to **In**. Route **Out** to a texture consumer in the [[Render Pipeline]].

The [LibreDiffusion add-on repository](https://github.com/ossia/score-addon-librediffusion) contains the backend integration and engine/runtime dependencies. Generation rate depends on the workflow, model, resolution and GPU; it is not guaranteed to match score's display frame rate.

## Ports

| Port | Use |
|---|---|
| In | Source texture for image-to-image workflows. |
| Control / Style | Preprocessed control map for ControlNet, style image for IP-Adapter, or inpainting mask for FLUX.2-klein inpaint. |
| Embedding | Float-array text embedding override for IMG2IMG_TURBO. Other workflows do not use this port. |
| Trigger | Declared impulse input; see the manual-mode limitation below. |
| Out | Generated output texture. |

ControlNet preprocessing is external: supply the depth, edge, pose or other map expected by the engine, not an arbitrary camera image. FLUX.2-klein inpaint uses white mask areas for regeneration and black areas for retention.

For **IMG2IMG_TURBO**, a sufficiently large **Embedding** array takes precedence. Otherwise the implementation can derive the embedding from **Prompt +** using `clip.engine` in the engine directory. If neither embedding source is available, it skips generation. The required embedding size and image dimensions are queried from the engine; do not assume every export is 512 × 512 or has the same embedding length. This workflow is distinct from **SDTURBO_IMG2IMG**.

## Generation controls

| Control | Meaning |
|---|---|
| Workflow | Model family and text-to-image/image-to-image mode. Available families include SD, SD-turbo, SDXL, V2V, FLUX.2-klein and IMG2IMG_TURBO, with ControlNet/IP-Adapter variants where offered. |
| Prompt + / Prompt - | Positive and negative prompt text. Negative-prompt use depends on the selected workflow and guidance mode. |
| Seed | Random seed. Matching it alone does not make different engines or workflows equivalent. |
| Guidance | Guidance strength; interpreted by the selected workflow. |
| Guidance type | None, Self, Full or Initialize classifier-free-guidance mode for the SD path. |
| Timesteps | Scheduler selection; see below. **Not a scalar step count.** |
| Resolution | Requested width and height in pixels for workflows that use this control. Engine-sized paths use their exported dimensions. |
| Add noise / Denoising batch | Noise and denoising-batch configuration for the SD pipeline. |
| Delta | Guidance-related delta parameter passed to the backend. |
| Feed prev. input / Feed prev. output | 0–1 blend weights for previous frames in the ordinary image-to-image input path. Not a general feedback connection for every workflow. |

When both feedback weights are nonzero, the previous-output contribution is limited to the weight left after previous-input blending; remaining weight belongs to the current input.

### Timesteps

For the **SD-family scheduler path**, enter a comma- or whitespace-separated list of scheduler indices, such as the default **`15, 25`**. This selects two entries from a 50-entry scheduler table, not “15 or 25 steps.” Indices are bounded to 0–49. An empty or unparseable list prevents setup; changing the number of selected entries can rebuild the pipeline.

**FLUX.2-klein** instead interprets this field as comma-separated FlowMatch sigma values in `(0, 1]`; use a high-to-low schedule appropriate to the model. If the field is not a usable sigma list, including the SD default `15, 25`, it falls back to the model's natural schedule. **IMG2IMG_TURBO** uses its own one-step translation path rather than the SD scheduler table.

### Workflow-specific controls

- **ControlNet scale** and **IP-Adapter scale** set conditioning strength for their respective workflows and compatible engine variants.
- **LoRA scale** adjusts runtime LoRA strength for engines exported with runtime-LoRA support. It cannot add a LoRA to an engine that lacks that support.
- **Klein quality** selects Quality or Speed transformer engines for FLUX.2-klein.
- **Interpolation exp** requests output-frame interpolation: 0 disables it, 1/2/3 request 2×/4×/8×. This depends on the supported execution path and interpolation engine; it is not extra diffusion detail.
- **Async** moves generation to a worker for supported plain SD/SDXL-family and klein workflows. ControlNet/IP-Adapter paths remain synchronous.
- **Async pacing** offers Smooth, Fresh and LowLatency presentation choices, trading buffered continuity against freshness on the supported async paths.

### Manual-mode limitation

**Manual mode** and **Trigger** are exposed controls, but the current processing implementation does not consult them to gate generation. Do not rely on them for one-image-per-trigger operation. Similarly, not every common control applies to the self-contained klein and IMG2IMG_TURBO paths.

## Troubleshooting

For an empty or unchanged output, check runtime availability, engine/workflow compatibility, supported dimensions, the scheduler field and required input textures or embeddings before changing prompts. Model-loading and generation failures are reported by the runtime; a texture cable alone cannot supply the missing engines. Start without feedback or asynchronous interpolation to isolate the basic model/input/output path.
