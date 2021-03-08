---
layout: default
title: "Embedded devices"

parent: Advanced
nav_order: 1

permalink: /docs/advanced/embedded.html
category: "site-score"

description: "Running score on embedded devices, such as the Raspberry Pi"

tag: "Hardware"
visible: true
---

# Hardware support

ossia score supports running on ARM under Raspberry Pi 3 and 4. We recommend a Raspberry Pi 4 for much better performance for audio processing, as well as better support for graphics feature due to its more advanced GPU.

Other embedded boards will also likely work, they have just not been tested yet. If [Qt](https://qt.io) runs on the hardware then most likely score will also run - see the following page for the reference hardware supported by Qt:

[https://doc.qt.io/QtForDeviceCreation/qtdc-supported-platforms.html](https://doc.qt.io/QtForDeviceCreation/qtdc-supported-platforms.html)

Please report to us if you try to build and run score on any other kind of exotic system !

## Running on the Raspberry Pi

There are pre-made builds for Raspberry Pi 3 and 4 accessible on [Github Actions](https://github.com/ossia/score/actions).

Pi Zero, 1, 2 can technically work but no builds are currently being made for them.

To use ossia score on the Pi, it is necessary to:

- Use an up-to-date Raspbian Buster distribution (Stretch is not supported). [You can follow this guide](http://baddotrobot.com/blog/2019/08/29/upgrade-raspian-stretch-to-buster/).
- Update the firmware to the kernel 5.10 at least: `sudo rpi-update` and reboot.
- Enable `Full KMS` OpenGL settings in `sudo raspi-config`. Launch the utility, go to `6 Advanced Options`, then `GL Driver`, then select `GL (Full KMS)` and reboot. Check [this link](https://www.raspberrypi.org/documentation/configuration/raspi-config.md) for more information on the configuration process.

Then you are good to go. Two scripts are provided: `ossia-score-x11` and `ossia-score-eglfs`.
`ossia-score-x11` is for running under the normal desktop environment of the Pi.
`ossia-score-eglfs` will run the graphics pipeline full-screen, bypassing the desktop environment entirely, which can be much more efficient - you don't even need to run X11 that way. But it is mostly useful in player mode, not for the score edition as there won't be any window borders / chrome.

Note: we recommend not using the default Pi desktop environment: in our testing, switching to a lighter environment such as `i3wm` or `fluxbox` instead of the default Pi desktop made a large difference in performance and drop-outs for the scores.

## Building for the Raspberry Pi

- ossia score build scripts: [https://github.com/ossia/score/tree/master/ci](https://github.com/ossia/score/tree/master/ci)

- ossia SDK build scripts (building latest Qt, FFMPEG, etc): [https://github.com/ossia/sdk/tree/master/ARM/RPi4](https://github.com/ossia/sdk/tree/master/ARM/RPi4)

They will produce binaries that are optimized for Pi 4, but will also work on Pi 3.

## Caveats

Some features are currently disabled - namely, VST3 support as there aren't many Linux ARM VST3s.

## Performance optimization

- If possible do not use PulseAudio but instead use ALSA directly.
- If possible use a RT kernel.
- If possible run with as few processes as possible - if you can avoid running any desktop environment / X11 / Wayland it will be faster.