---
layout: default

title: "Embedded devices"
description: "How to use ossia score on embedded hardware"

parent: In depth

permalink: /in-depth/embedded.html
---

# Hardware support

*ossia score* supports running on ARM under Raspberry Pi 3 and 4. We recommend a Raspberry Pi 4 for much better performance for audio processing, as well as better support for graphics feature due to its more advanced GPU.

Other embedded boards will also likely work, they have just not been tested yet. If [Qt](https://qt.io) runs on the hardware then most likely *score* will also run -- see the following page for the reference hardware supported by Qt:

[https://doc.qt.io/QtForDeviceCreation/qtdc-supported-platforms.html](https://doc.qt.io/QtForDeviceCreation/qtdc-supported-platforms.html)

Please report to us if you try to build and run score on any other kind of exotic system !

## Running on the Raspberry Pi (Raspbian)

Raspberry Pi 3 and 4 pre-made builds are accessible on [Github Actions](https://github.com/ossia/score/actions). Pi Zero, 1, 2 can technically work but no builds are currently being made for them.

To use ossia score on the Pi, it is necessary to:

- Use an up-to-date Raspbian Buster distribution (Stretch is not supported). [You can follow this guide](http://baddotrobot.com/blog/2019/08/29/upgrade-raspian-stretch-to-buster/).
- Update the firmware to the kernel 5.10 at least: `sudo rpi-update` and reboot.
- Enable `Full KMS` OpenGL settings in `sudo raspi-config`. Launch the utility, go to `6 Advanced Options`, then `GL Driver`, then select `GL (Full KMS)` and reboot. Check [this link](https://www.raspberrypi.org/documentation/configuration/raspi-config.md) for more information on the configuration process.

If done correctly, `/boot/config.txt` should contain the following uncommented line near the end:

```
dtoverlay=vc4-kms-v3d
```

Then you are good to go. Two scripts are provided: `ossia-score-x11` and `ossia-score-eglfs`.

- `ossia-score-x11` is for running under the normal desktop environment of the Pi.
- `ossia-score-eglfs` will run the graphics pipeline full-screen, bypassing the desktop environment entirely, which can be much more efficient - you don't even need to run X11 that way. But it is mostly useful in player mode, not for the score edition as there won't be any window borders / chrome.

Note that we recommend not using the default Pi desktop environment: in our testing, switching to a lighter environment such as `i3wm` or `fluxbox` instead of the default Pi desktop made a large difference in performance and drop-outs for the scores.

## Dependencies for minimal RPi installs

If you installed an OS without any GUI on your Raspberry, some packages may be missing at first when launching score.

You can install them with the following command:

```bash
$ sudo apt install libasound2 libblkid1 libbsd0 libc6 libdbus-1-3 libdouble-conversion1 libdrm2 libevdev2 libexpat1 libffi6 libgbm1 libgcc1 libgcc-8-dev libgcrypt20 libgles2 libglib2.0-0 libgpg-error0 libgudev-1.0-0 libinput10 libjbig0 libjpeg62-turbo liblz4-1 liblzma5 libmount1 libmtdev1 libmd4c0 libpcre3 libselinux1 libstdc++6 libsystemd0 libtiff5 libtinfo6 libudev1 libuuid1 libwacom2 libwayland-client0 libwayland-cursor0 libwayland-egl1 libwayland-server0 libwebp6 libxcb1 libxcb-icccm4 libxcb-image0 libxcb-input0 libxcb-keysyms1 libxcb-randr0 libxcb-render0 libxcb-render-util0 libxcb-shape0 libxcb-shm0 libxcb-sync1 libxcb-util0 libxcb-xfixes0 libxcb-xinerama0 libxcb-xkb1 libxkbcommon0 libxkbcommon-x11-0 libzstd1 raspi-copies-and-fills zlib1g
```

## Configuring the resolution under EGLFS

* First create a `config.json` file with the following content:

```json
{
  "device": "/dev/dri/card0",
  "pbuffers": true,
  "outputs": [
    {
      /* change to HDMI2 depending on the used output */
      "name": "HDMI1",
      /* refresh rate can be specified with 1920x1080@60 for instance */
      "mode": "1280x720"
    }
  ]
}
```

* Then set the following environment variables before running `ossia-score-eglfs`:

```bash
export QT_QPA_EGLFS_KMS_ATOMIC=1
export QT_QPA_EGLFS_KMS_CONFIG=$PWD/config.json
```

## Building for the Raspberry Pi (Raspbian)

- *ossia score* build scripts: [https://github.com/ossia/score/tree/master/ci](https://github.com/ossia/score/tree/master/ci)
- *ossia* SDK build scripts (building latest Qt, FFMPEG, etc): [https://github.com/ossia/sdk/tree/master/ARM/RPi4](https://github.com/ossia/sdk/tree/master/ARM/RPi4)

They will produce binaries optimized for Pi 4, and that will also work on Pi 3.

## Arch Linux ARM

Experimental builds have been confirmed to work on Arch Linux ARM. The simplest is to use the AUR package `ossia-score`.

## Caveats

Some features are currently disabled -- namely, VST3 support as there aren't many Linux ARM VST3s.

## Performance optimization

- If possible do not use PulseAudio but instead use ALSA directly.
- If possible use a RT kernel.
- If possible run with as few processes as possible - if you can avoid running any desktop environment / X11 / Wayland it will be faster.
