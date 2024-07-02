---
layout: default

title: "Supported protocols and formats"
description: "With which protocols, files, software, hardware is score compatible ?"

parent: Reference

permalink: /reference/protocols-and-formats.html
---

This page lists all the systems, file formats, etc... that *score* is able to inter-operate with.

# Operating systems

*score* works on Linux, macOS, Windows, and partially on the web platform.

Its development mainly happens on an [ArchLinux](https://archlinux.org/) system.
As *score* is built with [Qt](https://qt-project.org), it should be portable to [any system where Qt runs](https://doc.qt.io/qt-5/qpa.html).

# Network protocols

* OSC (Open Sound Control): the standard intermedia protocol. It is implemented through a [heavily modified version](https://github.com/jcelerier/oscpack) of Ross Bencina's oscpack library.
  * Documented [here]({{ site.baseurl }}/devices/osc-device.html).
* [OSCQuery](https://vdmx.vidvox.net/blog/oscquery):
  * Documented [here]({{ site.baseurl }}/devices/oscquery-device.html).
* [Minuit](https://github.com/Minuit/minuit).
  * Documented [here]({{ site.baseurl }}/devices/minuit-device.html).
* HTTP.
  * Documented [here]({{ site.baseurl }}/devices/http-device.html).
* WebSockets.
  * Documented [here]({{ site.baseurl }}/devices/websockets-device.html).
* CoAP.
  * Documented [here]({{ site.baseurl }}/devices/coap-device.html).
* MQTT.
  * Documented [here]({{ site.baseurl }}/devices/mqtt-device.html).


# Lighting protocols

* [Art-Net](https://art-net.org.uk/) / DMX: the standard for lighting fixtures. Support is implemented through [libartnet](https://github.com/OpenLightingProject/libartnet), which has been integrated inside libossia. *score* is able to load fixtures definitions in the [open-fixture-library](https://github.com/OpenLightingProject/open-fixture-library) format.
  * Documented [here]({{ site.baseurl }}/devices/artnet-device.html).
* [s.ACN / E1.31](https://wiki.openlighting.org/index.php/E1.31) is supported.
* ENTTEC DMX USB Pro devices are supported (Mk1 and Mk2).
* DMX input and output are both supported.

# Hardware protocols

* Serial port: *score* can read/write directly through serial ports, either directly or through Bluetooth. Support is currently based on the Qt SerialPort library but is being ported to ASIO to allow it to run in environments that cannot use Qt.
  * Documented [here]({{ site.baseurl }}/devices/serial-device.html).
* Game pads: they are supported through the [SDL2](https://libsdl.org) gamepad library. Most gamepads and joysticks should work without issue.
  * Documented [here]({{ site.baseurl }}/devices/joystick-device.html).
* Wiimotes: they are supported through the [WiiUse](https://github.com/wiiuse/wiiuse) library.
  * Documented [here]({{ site.baseurl }}/devices/wiimote-device.html).
* [LeapMotion / UltraLeap](https://www.ultraleap.com/): they are supported through the UltraLeap SDK (Gemini / Hyperion) which must be installed on the target computer.
  * Documented [here]({{ site.baseurl }}/devices/leapmotion-device.html).
* GPIOs, ADCs, PWMs etc.: they are supported through the [SimpleIO library](https://github.com/pmunts/libsimpleio) which is a simple wrapper over the raw kernel access. This feature is only available on Linux with the relevant hardware, for instance on Raspberry Pi. 
  * Documented [here]({{ site.baseurl }}/devices/rawio-device.html).
* BLE: Bluetooth Low Energy devices are supported through the [SimpleBLE](https://github.com/OpenBluetoothToolbox/SimpleBLE). Both reading advertisments / beacons / manufacturer data and GATT services is supported.
  * Documented [here]({{ site.baseurl }}/devices/ble-device.html).
* GPS: *score* can connect to a [gpsd](https://gpsd.gitlab.io/gpsd/) server and expose the GPS data.
  * Documented [here]({{ site.baseurl }}/devices/gps-device.html).
* [Phidgets](https://www.phidgets.com): they are supported through an implementation in libossia. Note that *score* must be built from source with the Phidgets API for the Phidgets protocol to be enabled.

# Audio systems

* [JACK](https://jackaudio.org): support is implemented in libossia.
* [PulseAudio](https://www.freedesktop.org/wiki/Software/PulseAudio/): experimental support is implemented in libossia.
* [PipeWire](https://pipewire.org): implemented in libossia and in score.
* [ALSA](https://alsa-project.org), the native Linux backend, supported through [PortAudio](https://www.portaudio.com/). A direct implementation is also provided for instance for working with as low latency as possible on embedded devices, but it only supports output, not duplex / input.
* CoreAudio: the native macOS backend, supported through PortAudio.
* MME, WASAPI, WDMKS: the native Windows backends, supported through [PortAudio](https://www.portaudio.com/).
* [ASIO](https://www.steinberg.net/en/company/technologies.html): the low-latency pro-audio Windows backend developed by [Steinberg](https://www.steinberg.net), supported through [PortAudio](https://www.portaudio.com/).
* [SDL](https://libsdl.org): support is implemented in libossia. It is mainly used to provide audio for the WebAssembly build of *score*.

# Video protocols

* [Spout](https://spout.zeal.co/) is supported on Windows.
  * Documented [[Spout|here]].
* [Syphon](http://syphon.v002.info/) is supported on macOS.
  * Documented [[Syphon|here]].
* [Shmdata](https://gitlab.com/sat-metalab/shmdata/) is supported on Linux and macOS.
  * Documented [[Shmdata|here]].
* [NDI](https://www.newtek.com/ndi/) is supported on Windows, Linux and macOS.

# Transport synchronisation

* [JACK](https://jackaudio.org) transport: *score* can act as a master or a slave.

# MIDI

All the MIDI support in *score* comes from the [libremidi](https://github.com/jcelerier/libremidi) library:

For real-time communication, the following implementations are provided:
* [ALSA](https://alsa-project.org), through either the raw or sequencer API.
* [JACK](https://jackaudio.org).
* [PipeWire](https://pipewire.org).
* The native operating systems MIDI API: MME for Windows, CoreMIDI for macOS.
* [WebMIDI](https://www.w3.org/TR/webmidi/).

In addition, *score* is able to load Standard MIDI files (SMF).

See the [[MIDI|MIDI documentation]] for more information.

# Audio file formats

*score* uses [FFMPEG](https://ffmpeg.org/) for its audio needs.

It should support most codecs and formats listed [at this page](https://ffmpeg.org/general.html#Audio-Codecs).
Every standard format (AIFF, MP3, OGG Vorbis, FLAC, etc) should be supported without issues.

*score* handles WAV files in a specific way, through the [dr_wav](https://github.com/mackron/dr_libs/) library, to allow for memory-mapping the data for large files.

*score* is able to read ACID tags to devise for instance BPM info from sound files.

See the [sound file process documentation]({{ site.baseurl }}/processes/soundfile.html) for more information.

# Video file formats

*score* uses [FFMPEG](https://ffmpeg.org/) for its video needs.

It should support most codecs and formats listed [at this page](https://ffmpeg.org/general.html#Video-Codecs).
In particular, H.264, H.265, Apple ProRes, etc. should be supported.

[HAP codecs](https://hap.video) are handled in a different way: for maximum performance, decoding is done by *score* (which allows doing it on the graphics card, while FFMPEG's HAP decoding happens on the CPU which defeats the point of the codec).

See the [video process documentation]({{ site.baseurl }}/processes/video.html) for more information.

## Hardware decoding
*score* can use OS video decoding APIs through FFMPEG. This allows for instance to decode H264 video on a Raspberry Pi 4 and apply live effects on it with only 15% CPU usage.

Supported APIs are:

* DXVA2 / D3D11 on Window.
* VideoToolbox on macOS.
* V4L2-M2M on Raspberry Pi and embedded.

If one builds *score* from source with a custom FFMPEG version, it is also possible to have CUDA and QuickSync support.

## Hardware rendering
*score* will try to render some common video texture formats on the GPU with shaders instead of converting them to RGB on the CPU, for maximum performance.
Make sure that your video frames are in one of these pixel formats: if so, decoding won't take CPU time.

- RGB, RGBA, ARGB, ABGR and any variation thereof, planar or packed, 8 bits (int) or 32 bits (float)
- YUV420P, YUV422P
- NV12
- YUYV422, UYVY422
- HAP, HAP-Q, HAP-M

# Image file formats

*score* uses Qt's [QImage](https://doc.qt.io/qt-6/qimage.html) for decoding images. The supported formats are PNG, GIF, JPEG.

See the [image process documentation]({{ site.baseurl }}/processes/image.html) for more information.

# 3D file formats

*score* can load `.obj` files.

# Graphics APIs

*score* uses [Qt RHI](https://www.qt.io/blog/graphics-in-qt-6.0-qrhi-qt-quick-qt-quick-3d) as graphics abstraction for the video pipeline. It is able to use OpenGL ES 2.0, Vulkan, Metal, and Direct 3D 11 in a very efficient way.

*score* shaders are written with the [Interactive Shader Format](https://isf.video) specification.

See the [[shader|shader process documentation]] for more information on how to write *score* shaders.
See the [[graphics pipeline|general video documentation]] for general information on the *score* graphics rendering pipeline.

# Audio plug-ins

*score* supports the following audio plug-in systems:

* [Steinberg VST3](https://www.steinberg.net/en/company/technologies/vst3.html) on all platforms.
  * Documented [here]({{ site.baseurl }}/processes/audio-plugins.html#vst3).
* [LV2](https://lv2plug.in) on Linux. Note that currently this requires building *score* on your own computer or use a Linux distro package.
  * Documented [here]({{ site.baseurl }}/processes/audio-plugins.html#lv2).
* [JSFX](https://www.cockos.com/jsfx/) is embedded in *score* through [ysfx](https://github.com/jpcima/ysfx).
  * Documented [here]({{ site.baseurl }}/processes/audio-plugins.html#jsfx).
* [Faust](https://faust.grame.fr/), the Faust programming language developed by GRAME. *score* embeds the Faust compiler and libraries.
  * Documented [here]({{ site.baseurl }}/processes/faust.html).
* [Pure Data](https://puredata.info/) is embedded in *score* through [libpd](https://github.com/libpd/libpd).
  * Documented [here]({{ site.baseurl }}/processes/puredata.html).
* It is possible to write simple audio instruments and effects with the [various math-expression processes]({{ site.baseurl }}/processes/exprtk.html).
* It is possible to write simple audio instruments and effects with [the JavaScript process]({{ site.baseurl }}/processes/javascript.html).
* It is possible to write more advanced instruments and effects in C++ with [the C++ JIT process]({{ site.baseurl }}/processes/cpp_jit.html).