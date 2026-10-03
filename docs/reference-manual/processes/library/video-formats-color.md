---
layout: default
title: Video formats and color
description: "Video decoding, pixel formats, hardware acceleration and HDR workflows"
parent: Processes
grand_parent: Reference
permalink: /processes/video-formats-color.html
---

# Video formats and color

This reference describes the current development graphics/media pipeline. Features depend on the score build, FFmpeg version, graphics API, drivers and optional devices; it is not a universal codec or hardware support matrix.

## Container, codec and pixels are different

A `.mov`, `.mkv`, `.mp4`, `.mxf` or transport-stream (`.ts`, `.mts`, `.m2ts`) file is a **container**. Its video **codec** must first be decoded. The resulting **pixel format** describes how samples are laid out: RGB or YUV, packed or planar, bit depth, chroma subsampling and possibly alpha.

For example, software-decoded HEVC can produce 10-bit YUV which score uploads and converts to RGB on the GPU. This does not make the HEVC codec hardware-decoded. Conversely, a hardware decoder may still need to copy its decoded frames through CPU memory if its surfaces cannot be imported by the selected graphics backend.

## Choosing footage and playback

The [Video process]({{ site.baseurl }}/processes/video.html) offers **Auto**, **Direct (seek)** and **Frame queue** playback. Auto chooses Direct for HAP/DXV and streams classified as having every frame independently accessible; other streams use buffered playback. Long-GOP files remain expensive to scrub even when the codec is hardware-accelerated.

- **HAP** and **DXV** have dedicated compressed-texture paths. HAP variants include alpha and higher-quality variants; their use still depends on the GPU's block-compression support. They are not equivalent to H.264 hardware decoding.
- **CineForm**, ProRes, DNxHD, MJPEG and other production codecs are decoded through the available FFmpeg implementation. The decoded format, not the codec name alone, selects the subsequent GPU conversion.
- **Transport streams** can be imported as files. A live URL is better handled by a [Libav device]({{ site.baseurl }}/devices/libav-device.html) or [GStreamer device]({{ site.baseurl }}/devices/gstreamer-device.html); live sources do not acquire arbitrary timeline seeking.
- **Image sequences** are understood by FFmpeg's image-sequence demuxer when supplied a sequence path, such as `frame%04d.png`. This is different from dropping several images into an [Image process]({{ site.baseurl }}/processes/image.html), where **Index** chooses the image. A Libav input can supply the sequence path and demuxer options; dragging a still image uses the Image process instead.

## Hardware decoding

In graphics preferences, **Hardware Video Decoding** controls codec acceleration, independently of the Video process's Playback setting:

- **None** uses software codec decoding. GPU upload, pixel conversion and effects still run normally.
- **Auto** chooses candidates using the platform, codec and graphics API. The direct renderer attempts viable candidates before software fallback; the frame-queue decoder has its own platform-preferred selection.
- Explicit choices request a particular backend. Depending on build and platform, the list can include **CUDA**, **Intel QuickSync**, **VDPAU**, **VA-API**, Windows **DXVA2**, **Direct3D 11** / **Direct3D 12**, macOS **Video Toolbox**, ARM Linux **V4L2-M2M**, and **Vulkan Video**. Only choices exposed by the installed build should be expected.

A backend being listed does not guarantee that it can decode a particular profile, bit depth or resolution. Failed hardware setup can fall back to software decoding. Failed direct surface import can instead fall back to hardware decoding followed by CPU transfer and upload. Vulkan Video in particular needs compatible FFmpeg, Qt, driver and device capabilities; not every Vulkan renderer can decode video.

**Decoding threads** configures software decoders. **Auto** selects the thread model and count per codec; a numerical choice limits the pool, not the codec's threading model. More threads are not always better when several videos run together.

## Pixel formats and precision

The current conversion paths cover common 8-bit YUV 4:2:0, 4:2:2 and 4:4:4; planar 10-, 12- and selected 16-bit YUV; alpha-bearing YUV; NV12/NV21 and other semi-planar formats; packed RGB/RGBA; planar RGB and floating-point RGB. Additional paths handle palettes, grayscale, packed bit-field RGB and raw Bayer images. These are conversion capabilities, not a promise that every input protocol exposes every format.

Important distinctions:

- **P010** is 10-bit 4:2:0 with 16-bit storage lanes; **P210** is 10-bit 4:2:2; **P216** uses all 16 bits of its 4:2:2 samples. They are not interchangeable with 8-bit NV12.
- **V210** packs groups of 10-bit 4:2:2 samples into words with padded rows. Dedicated wire-format conversion serves compatible capture paths. FFmpeg can also decode V210 files to planar frames. This does not imply that `video/x-raw,format=v210` is accepted by every GStreamer input.
- **XYZ12** is the DCI X′Y′Z′ representation used by some digital-cinema material. The `xyz12le` path applies its own code-value normalization and XYZ-to-RGB conversion rather than treating it as ordinary YUV.
- Alpha must survive both the source format and the destination. A texture can contain alpha while a chosen encoder, wire format or receiving application discards it.

## HDR and color output

Correct appearance depends on more than bit depth: color primaries, matrix coefficients, transfer function and **full versus limited range** all matter. score's conversion uses available metadata to select YUV matrices and range handling, including BT.601, BT.709 and BT.2020 paths. Incorrect or missing source metadata can produce wrong brightness, contrast or hue; choosing a different decoder does not repair mislabeled footage.

The Video inspector's **Format** setting controls the texture sent downstream:

| Format | Purpose |
|---|---|
| SDR | Convert HDR content for an SDR-oriented chain, with the selected tone mapper. |
| Passthrough | Preserve the HDR-oriented representation rather than applying SDR tone mapping. The next stage must understand it. |
| Linear | Convert into linear light for processing. |
| Normalized | Linear light normalized by peak luminance. |

**Tonemap (HDR)** offers Clamp, BT.2390, BT.2446, Reinhard, Hable, ACES2, AgX, PBR Neutral and Auto. Auto resolves PQ/HDR10 to BT.2390 and HLG to Clamp in the existing SDR conversion pipeline. Tone mapping is a rendering choice, not a change to the source file.

For an SDR projection workflow, begin with SDR output and assess highlights on the actual destination. For HDR, agree on the representation through every effect and output stage. The [Window device]({{ site.baseurl }}/devices/window-device.html) separately selects its swapchain format; the operating system, monitor and graphics backend must support that mode. A floating-point texture or an HDR file alone does not establish end-to-end HDR display.

[Libav]({{ site.baseurl }}/devices/libav-device.html) and [GStreamer]({{ site.baseurl }}/devices/gstreamer-device.html) outputs expose **Input Transfer**: this describes the texture arriving from the graph (sRGB, Linear, PQ, HLG or Passthrough), not the transfer function to arbitrarily assign to the source footage. Match it to the upstream process to avoid double conversion.

## Interlacing

Distinguish a full frame with two fields already woven together from sources delivering one half-height field at a time. The latter require reconstruction. In [NDI input]({{ site.baseurl }}/devices/ndi-device.html), **Weave** retains vertical detail but can show combing on movement; **Bob** avoids combing by sacrificing vertical detail and displaying at field rate. These controls apply to separately delivered fields, not automatically to every interlaced file.

## Troubleshooting order

1. Check the file or live source's actual codec, pixel format, rate and color metadata.
2. Route directly to a known output, without effects, and compare range, colors and alpha.
3. Try software codec decoding to separate codec/driver problems from texture conversion.
4. Check the output device's format and transfer settings independently of the input.
5. For shared GPU surfaces, try the documented CPU/shared-memory route to isolate interop or DMA-BUF problems.
