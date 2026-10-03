---
layout: default
title: Sink
description: "Run a GPU process chain at a requested rate without displaying its image"
parent: Processes
grand_parent: Reference
permalink: /processes/sink.html
---

# Sink

**Sink**, in **Visuals / Utilities**, runs the video processes connected to it without opening a window or displaying their images. Use it when a GPU process produces useful data but its image is not connected to an output—for example, an image-analysis process with a data outlet. This process is available in current development builds.

## Ports and control

| Port | Purpose |
|---|---|
| Texture inlet | Connect the image output of the GPU chain that must execute. |
| **Rate** | Requested frames per second: 1–120, initially 30. Can be controlled through its inlet. |

Sink has no output ports. The effective rate is capped by the rendering rate configured in settings; requesting 120 does not override a lower global rate or guarantee that an expensive shader will reach it.

## Workflow

1. Add Sink from the process library.
2. Cable the final image outlet of the chain to its texture inlet.
3. Connect the producing process's separate data outlet to the process or address that consumes that data.
4. Start playback and adjust **Rate** to the frequency needed for the analysis.

Set the texture inlet's size override when the chain needs a specific processing resolution. Leave it on **Auto** when it should use automatic sizing. Sink is an execution endpoint, not a recorder, image preview, geometry renderer or GPU-to-CPU conversion process. To inspect the image, also use a display output; to render geometry, first connect it to an appropriate renderer.

## Related pages

- [[Graphics pipeline]]: Output-driven rendering, size controls and backend limits.
- [[ISF Shaders]] and [[Compute Shaders]]: GPU processes that can feed Sink.
- [[Shader cookbook]]: Small source-based shader recipes.
