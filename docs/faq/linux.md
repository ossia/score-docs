---
layout: default

title: "Running on Linux"
description: "Linux configurations options to use ossia scoreefficiently"

parent: FAQ

permalink: /faq/linux.html
---

# Basic configuration

Some basic steps are usually required on Linux systems to make the most out of ossia.

For instance, a lot of Linux capabilities are by default accessible only to the root user, e.g. through `sudo` for instance. 
It is generally not feasible to run `score` as for instance sound daemons such as JACK or PipeWire are per-user ; thus running `score` under another user would prevent access to sound output.

The way capabilities are granted to non-root users is through the groups system.

We recommend to be in the following groups (and creating them if they aren't with `groupadd "name_of_the_group"`:

 - `uucp` and / or `dialout` depending on the distribution for serial port access (including access to DMX devices such as an ENTTEC USB-DMX for instance).
 - `audio` for raw access to sound and MIDI devices (usually this one is by default).
 - `video` for cameras and anything in /dev/video.
 - `render` to be able to use direct rendering through EGLFS, without e.g. X11 or Wayland.
 - `realtime` for enabling low-latency support with e.g. JACK or PipeWire.
 - `gpio` to access GPIO pins, etc.
 - `i2c` to access other raw devices.
 - `bluetooth` to use the Bluetooth support.
 - `input` to use the raw evdev input device and for some BLE devices (Bluetooth gamepads).
 - `power` if you want to be able to control e.g. turning off a computer through score directly.

 
 This can be done in one command:
 
 ```bash
 $ sudo usermod -a -G dialout,uucp,audio,video,render,realtime,gpio,i2c,bluetooth,input,power $USER
 ```
 
 Note that it is necessary to log-out and log-in again after it as this command does not affect the current user session.

 
