---
layout: default

title: Window device
description: "Opening a window to display visuals"

parent: Devices
grand_parent: Reference

permalink: /devices/window-device.html
---

![Device setup window]({{ site.img }}/reference/devices/window-device.png "score device setup")

The Window device displays the texture routed to it. Assign it as the destination of a video process or the last effect's texture outlet.

## Output modes

The output modes are **Single Window**, **Background** and **Multi-Window Mapping**:

- **Single Window** opens a conventional output window.
- **Background** renders behind the score timeline rather than opening a separate presentation window.
- **Multi-Window Mapping** divides one rendered input among several output windows, useful for multiple displays or projectors.

**Swapchain Flag** offers **No Flag** or **sRGB**. **Swapchain Format** offers **SDR**, **HDR Extended sRGB Linear**, **HDR10** and **HDR Extended Display P3 Linear**. Availability depends on the graphics backend, OS and display. These settings do not convert an arbitrary shader chain into a correctly managed HDR pipeline; see [Video formats and color]({{ site.baseurl }}/processes/video-formats-color.html).

## Multi-window mapping workflow

1. Select **Multi-Window Mapping** and set the shared input **Resolution**.
2. Add output regions in **Input Mapping**. Each region selects a rectangle of the incoming texture.
3. Use **Desktop Layout** to place output windows on the actual desktop/screens. Input cropping and desktop placement are separate operations.
4. Configure the selected output's screen, size, position and fullscreen state. Use the lock modes to preserve aspect ratio, keep one input pixel per output pixel, or prevent accidental changes.
5. Adjust corner warping and soft-edge blend widths/gamma for overlapping projectors. Rotate each output by 0, 90, 180 or 270 degrees clockwise and mirror horizontally or vertically as needed; mirroring is applied after rotation.
6. Use the preview test cards and output identification to check placement before routing performance content.

The device tree exposes global `/rendersize` and measured `/fps`. Per-window nodes use an index prefix, such as `/0/size`, `/0/position`, `/0/fullscreen`, `/0/screen`, `/0/source/position` and `/0/source/size`. Source position and size use normalized texture coordinates. Soft edges expose `/0/blend/left/width`, `/0/blend/left/gamma` and corresponding right/top/bottom paths.

`/fps` reports actual rendering; it is not a frame-rate control. Graphics preferences provide **VSync** and **Rate (if no VSync)**, subject to the output/backend's scheduling capabilities.

The following properties describe the single-window device:

## Window properties

* `/screen`: on which screen the window must be shown.
* `/position`: absolute position of the window on the user's viewport.
* `/size`: window size in pixels.
* `/rendersize`: the resolution at which rendering is done. If it is `[0, 0]` then the renderer is rescaled to follow the window resolution.
* `/fullscreen`: show as fullscreen. Double-clicking on the window will also trigger this.
* `/fps`: measured rendering frame rate.

## Mouse input

* `/cursor/scaled`: mouse cursor position in the window scaled to `[0;1]` bounds, y down.
* `/cursor/gl`: the same with y up, as OpenGL texture coordinates.
* `/cursor/clip`: mouse cursor position in clip space, x and y in `[-1;1]`, y up: the `mouse` of [vertexshaderart.com](https://www.vertexshaderart.com).
* `/cursor/absolute`: mouse cursor position in the window in pixels.

In **Multi-Window Mapping** mode, each window has these under its index prefix (`/0/cursor/clip`...).

## Touch input

In **Single Window** and **Background** modes:

* `/touch/points`: the pointers, a list of 32 `[x, y, pressure]` in clip space, y up. Slot 0 is the mouse (pressure 1 while a button is pressed) or the first finger, then one slot per finger in the order they came down; a released slot keeps its position, with pressure 0. Writable: a value sent to it moves the pointers.
* `/touch/history`: a texture, the last 240 frames of `/touch/points`: 32 × 240 RGBA float, one column per pointer, the newest frame in the row at `v = 0`, each texel `(x, y, pressure, time)`. This is the `touch` texture of vertexshaderart.com; route it to a texture inlet as any texture address.

## Shader inputs

Shader inputs named for the pointers are bound to these addresses of the first window device by default, in ISF, Vertex Shader Art and Render Pipeline shaders alike: a `point2D` named `iMouse` to `/cursor/absolute`, a `mouse` of a Vertex Shader Art shader to `/cursor/clip`, another `point2D` whose name contains `mouse` to `/cursor/gl`, and an image named `touch` to `/touch/history`. The address shows on the inlet, where it can be changed. See [ISF pointer inputs]({{ site.baseurl }}/reference/languages/isf.html#pointer-inputs) and [VSA mouse and touch]({{ site.baseurl }}/reference/languages/vertex-shader-art.html#mouse-and-touch).

## Tablet input

* `/tablet/scaled`: tablet pen position in the window scaled to `[0;1]` bounds.
* `/tablet/absolute`: tablet pen position in the window in pixels.
* `/tablet/z`: tablet pen height. 
* `/tablet/pressure`: tablet pen pressure.
* `/tablet/rotation`: tablet pen rotation.
* `/tablet/tangential`: tablet pen tangential pressure.
* `/tablet/tilt_x` and `/tablet/tilt_y`: tablet pen tilt.

The values are extracted directly from Qt's [QTabletEvent](https://doc.qt.io/qt-6/qtabletevent.html).

## Keyboard input

* `/key/press/code` and `/key/release/code`: low-level key press and release codes.
* `/key/press/text` and `/key/release/text`: text associated with the corresponding keyboard event. A Shift + G press, for instance, carries the resulting text rather than requiring the score to combine modifier keys itself.