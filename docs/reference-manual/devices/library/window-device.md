---
layout: default

title: Window device
description: "Opening a window to display visuals"

parent: Devices
grand_parent: Reference

permalink: /devices/window-device.html
---

![Device setup window]({{ site.img }}/reference/devices/window-device.png "score device setup")

The Window device allows to show a window in which visuals will be rendered.

Its device tree contains the following parameters:

## Window properties

* `/screen`: on which screen the window must be shown.
* `/position`: absolute position of the window on the user's viewport.
* `/size`: window size in pixels.
* `/rendersize`: the resolution at which rendering is done. If it is `[0, 0]` then the renderer is rescaled to follow the window resolution.
* `/fullscreen`: show as fullscreen. Double-clicking on the window will also trigger this.

## Mouse input

* `/cursor/scaled`: mouse cursor position in the window scaled to `[0;1]` bounds.
* `/cursor/absolute`: mouse cursor position in the window in pixels.

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

* `/key/code`: low-level key code corresponding to the current user input. One per keystroke.
* `/key/text`: high-level combined result of the user's keystrokes. For instance, a user pressing "Shift + G" will yield a capital "G" text here.