---
layout: default

title: Supported protocols and formats
description: "With which protocols, files, software, hardware is score compatible ?"

parent: Reference

permalink: /reference/protocols-and-formats.html
---

This page summarizes the systems and file formats that *score* can interoperate with. Availability depends on the operating system, build options, installed add-ons and external runtimes. Newer features described here refer to current development builds, not necessarily the latest stable release.

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
  * Documented [here]({{ site.baseurl }}/devices/ws-device.html).
* CoAP.
  * Documented [here]({{ site.baseurl }}/devices/coap-device.html).
* MQTT.
  * Documented [here]({{ site.baseurl }}/devices/mqtt-device.html).
* LSL (Lab Streaming Layer), through the optional LSL add-on.
  * Documented [here]({{ site.baseurl }}/devices/lsl-device.html).

* [Bitfocus Companion modules]({{ site.baseurl }}/devices/companion-device.html) expose supported module controls through a device; the module's own dependencies and configuration still apply.
* [Spatialization]({{ site.baseurl }}/devices/spatgris-device.html), provided by the SpatGRIS add-on, is a device integration for external spatial-audio software.

The optional [Libmapper client]({{ site.baseurl }}/devices/libmapper-device.html) is a separate integration from the scriptable [Mapper device]({{ site.baseurl }}/devices/mapper-device.html). Its current source integration has a build-interface mismatch; do not treat it as an available working protocol in an ordinary installation.

[Tracking protocols]({{ site.baseurl }}/devices/tracking-device.html) records the TUIO, PSN, RTTrP, OpenTrackIO and optional OpenXR implementations. The tracking add-on is disabled in the audited checkout, so this source inventory is **not** a list of working devices available in that build.

# Lighting protocols

* [Art-Net](https://art-net.org.uk/) / DMX: the standard for lighting fixtures. Support is implemented through [libartnet](https://github.com/OpenLightingProject/libartnet), which has been integrated inside libossia. *score* is able to load fixtures definitions in the [open-fixture-library](https://github.com/OpenLightingProject/open-fixture-library) format.
  * Documented [here]({{ site.baseurl }}/devices/artnet-device.html).
* **LED Strip Support**: Comprehensive support for LED strips including NeoPixel (WS2812), individual LED control, and strip/pane/volume layouts through Art-Net. Supports RGB, RGBW, and specialized diode configurations (Warm/Cold White, Amber, UV).
* [s.ACN / E1.31](https://wiki.openlighting.org/index.php/E1.31) is supported.
* ENTTEC DMX USB Pro devices are supported (Mk1 and Mk2).
* DMX input and output are both supported.

# Hardware protocols

* Serial port: *score* can read and write serial ports, including Bluetooth connections exposed by the operating system as serial ports.
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
* [Phidgets]({{ site.baseurl }}/devices/phidgets-device.html) has an optional Phidget22 integration in libossia. The audited wrapper contains a stale include path; establish a compatible enabled build before relying on its discovered hardware channels. See the reference for channel activation and input/output limitations.
* [CAN / DBC]({{ site.baseurl }}/devices/can-device.html) receives and decodes CAN signals through Linux SocketCAN. It is receive-only and requires a DBC database; it does not provide CAN transmission or CANopen control services.

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
* [Sh4lt](https://gitlab.com/sh4lt/sh4lt) provides shared-memory video input and output when built with the Sh4lt backend. See the [Sh4lt device]({{ site.baseurl }}/devices/sh4lt-device.html); the wider Sh4lt library's data types are not a promise that every type is exposed by this device.
* [NDI](https://ndi.video/) video input and output require the NDI add-on and a loadable NDI runtime. Platform and format support depend on that runtime and build.
  * See the [NDI device]({{ site.baseurl }}/devices/ndi-device.html), including PTZ controls for compatible cameras.

* [PipeWire video]({{ site.baseurl }}/devices/pipewire-device.html) provides input and output on Linux builds with that backend. It is distinct from the PipeWire audio and MIDI backends.
* [GStreamer]({{ site.baseurl }}/devices/gstreamer-device.html) bridges user-defined media pipelines; capabilities depend on the GStreamer runtime and installed elements.
* [FFmpeg / libav]({{ site.baseurl }}/devices/libav-device.html) provides media-device input and output for supported files and streams. Available codecs, muxers and network protocols depend on the FFmpeg build.
* [Camera and screen capture]({{ site.baseurl }}/devices/camera-device.html) use platform-specific capture backends.
* [GPhoto2 DSLR]({{ site.baseurl }}/devices/gphoto-device.html) provides camera live-view preview and device-reported configuration when libgphoto2, its camera driver and suitable hardware are available.

# Transport synchronisation

* [JACK](https://jackaudio.org) transport: *score* can act as a master or a slave.
* [Timecode Synchronizer]({{ site.baseurl }}/processes/timecode-synchronizer.html) follows an incoming time position. Musical pulse generation and timestamp synchronization are different operations; choose the process appropriate to the source.
* [MIDI Sync Out]({{ site.baseurl }}/processes/midi-sync.html) sends MIDI clock, transport messages and timecode. [MIDI Sync In]({{ site.baseurl }}/processes/midi-timecode-input.html) decodes incoming synchronization into control values; it does not automatically make the whole score follow an external transport.

# MIDI

All the MIDI support in *score* comes from the [libremidi](https://github.com/jcelerier/libremidi) library:

For real-time communication, the following implementations are provided:
* [ALSA](https://alsa-project.org), through either the raw or sequencer API.
* [JACK](https://jackaudio.org).
* [PipeWire](https://pipewire.org).
* The native operating systems MIDI API: MME for Windows, CoreMIDI for macOS.
* [WebMIDI](https://www.w3.org/TR/webmidi/).

In addition, *score* is able to load Standard MIDI files (SMF).

Use [MIDI input]({{ site.baseurl }}/devices/midiin-device.html) and [MIDI output]({{ site.baseurl }}/devices/midiout-device.html) for MIDI streams. [MIDI Controller]({{ site.baseurl }}/devices/midi-controller-device.html) additionally provides named device-map controls and a Mackie Control surface mode; these are two modes of one protocol, not separate processes.

# Audio file formats

*score* uses [FFMPEG](https://ffmpeg.org/) for its audio needs.

It should support most codecs and formats listed [at this page](https://ffmpeg.org/general.html#Audio-Codecs).
Every standard format (WAV, W64, AIFF, MP3, OGG Vorbis, FLAC, etc.) are supported without issues.

*score* handles WAV files in a specific way, through the [dr_wav](https://github.com/mackron/dr_libs/) library, to allow for memory-mapping the data for large files.

*score* is able to read ACID tags to devise for instance BPM info from sound files.

See the [sound file process documentation]({{ site.baseurl }}/processes/soundfile.html) for more information.

# Video file formats

*score* uses [FFmpeg](https://ffmpeg.org/) to read video files. Available demuxers and codecs depend on the FFmpeg build; common choices include H.264, H.265, ProRes and transport streams (`.ts`).

[HAP](https://hap.video) and supported DXV variants have specialized GPU texture-decoding paths. This differs from hardware video decoding: compressed texture blocks can be sampled on the GPU, while the file still needs to be read and unpacked.

The [Video process]({{ site.baseurl }}/processes/video.html) provides **Auto**, **Direct (seek)** and **Frame queue** playback modes. Auto selects the playback path using the stream's keyframe layout. Direct playback is useful for independently decodable frames; inter-frame codecs generally need the frame queue.

## Hardware decoding

The video decoder can use FFmpeg hardware-acceleration backends, including Direct3D / DXVA on Windows, VideoToolbox on macOS, and Linux options such as VAAPI, V4L2-M2M, CUDA or QuickSync where available. Vulkan decoding is also build- and driver-dependent. Selecting a graphics renderer does not by itself guarantee hardware video decoding.

Support depends on the codec, pixel format, FFmpeg version, driver and GPU. Use the video decoding preference to select a backend; unsupported streams may still need software decoding.

## Hardware rendering
*score* can convert many decoded pixel formats with GPU shaders rather than converting every frame to RGB on the CPU. This reduces conversion work; it does **not** make file decoding or transfer free.

Supported paths cover packed and planar RGB / RGBA, grayscale, YUV and YUVA; common examples include NV12, P010 / P016, planar 4:2:0 / 4:2:2 / 4:4:4, YUYV / UYVY, high-bit-depth and floating-point images, and DCI XYZ12. The precise path depends on the source format and graphics backend; other formats can require a software conversion.

## Color and HDR

The video pipeline interprets source color metadata, including BT.601, BT.709, BT.2020, P3, PQ and HLG. The Video inspector's **Format** and **Tonemap (HDR)** controls choose conversion to SDR, HDR passthrough or linear output, and the tone-mapping operator.

Decoding an HDR file is not the same as displaying HDR. The output window format, graphics backend, operating system and display must also support the requested output. For SDR displays, use tone mapping rather than assuming passthrough will produce the intended image.

See [Video]({{ site.baseurl }}/processes/video.html), [Window]({{ site.baseurl }}/devices/window-device.html) and the [graphics pipeline]({{ site.baseurl }}/in-depth/video.html) for the processing and output controls.

For detailed choices and limitations, see [Video formats and color]({{ site.baseurl }}/processes/video-formats-color.html).

# Image file formats

The [Image process]({{ site.baseurl }}/processes/image.html) reads raster images through Qt's image readers and handles SVG through a scalable SVG renderer. Common formats include PNG, JPEG and GIF; additional formats depend on installed Qt image-format support.

# 3D file formats

Native 3D processes are separate from QtQuick3D content embedded in a JavaScript / QML process:

* [Geometry Loader (Object Loader reference)]({{ site.baseurl }}/processes/object-loader.html) imports geometry for mesh-oriented processing.
* [Asset Loader]({{ site.baseurl }}/processes/asset-loader.html) imports scenes from glTF / GLB and FBX, as well as OBJ, PLY, STL, OFF, SPLAT and SPZ assets. It preserves scene data where the format and importer support it; USD-family files require the optional parser add-on.
* Scene data can be processed and rendered through the native [Render Pipeline]({{ site.baseurl }}/processes/render-pipeline.html). A simple geometry path can use [Model Display]({{ site.baseurl }}/processes/model-display.html).
* [JavaScript / QML]({{ site.baseurl }}/processes/javascript.html) can host QtQuick3D scenes when the required Qt modules are installed. This is a separate rendering path, not a requirement for native glTF / FBX import.

# Graphics APIs

*score* uses [Qt RHI](https://www.qt.io/blog/graphics-in-qt-6.0-qrhi-qt-quick-qt-quick-3d) to target OpenGL, Vulkan, Metal, Direct3D 11 and Direct3D 12. Available backends depend on the platform and build. Advanced features such as compute shaders, storage buffers and particular texture formats additionally depend on GPU and driver support.

The shader processes cover several jobs:

- [ISF shaders]({{ site.baseurl }}/processes/shaders.html) generate and filter images.
- [Compute Shaders]({{ site.baseurl }}/processes/compute-shaders.html) work with GPU data, textures and geometry.
- [Render Pipeline]({{ site.baseurl }}/processes/render-pipeline.html) provides custom raster rendering for geometry and scenes.
- [Vertex Shader Art]({{ site.baseurl }}/processes/vertex-shader-art.html) generates visuals from a vertex shader.

See the [graphics pipeline]({{ site.baseurl }}/in-depth/video.html) for how these processes connect.

# Audio plug-ins

Desktop builds support the following audio plug-in and embedded-language systems when the corresponding backend is included. A plug-in binary must match the operating system and architecture; desktop plug-in support does not imply availability in the browser build.

* [AirWindows](https://www.airwindows.com/).
  * Documented [here]({{ site.baseurl }}/processes/audio-plugins.html).
* [CLAP](https://github.com/free-audio/clap).
  * Documented [here]({{ site.baseurl }}/processes/audio-plugins.html).
* [Steinberg VST3](https://www.steinberg.net/en/company/technologies/vst3.html).
  * Documented [here]({{ site.baseurl }}/processes/audio-plugins.html).
* [LV2](https://lv2plug.in) on Linux. Note that currently this requires building *score* on your own computer or use a Linux distro package.
  * Documented [here]({{ site.baseurl }}/processes/audio-plugins.html).
* [JSFX](https://www.cockos.com/jsfx/) is embedded in *score* through [ysfx](https://github.com/jpcima/ysfx).
  * Documented [here]({{ site.baseurl }}/processes/audio-plugins.html#jsfx).
* [Faust](https://faust.grame.fr/), the Faust programming language developed by GRAME. *score* embeds the Faust compiler and libraries.
  * Documented [here]({{ site.baseurl }}/processes/faust.html).
* [Pure Data](https://puredata.info/) is embedded in *score* through [libpd](https://github.com/libpd/libpd).
  * Documented [here]({{ site.baseurl }}/processes/puredata.html).
* It is possible to write simple audio instruments and effects with the [various math-expression processes]({{ site.baseurl }}/processes/exprtk.html).
* It is possible to write simple audio instruments and effects with [the JavaScript process]({{ site.baseurl }}/processes/javascript.html).
* It is possible to write more advanced instruments and effects in C++ with [the C++ JIT process]({{ site.baseurl }}/processes/cpp_jit.html).