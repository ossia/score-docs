---
layout: default

title: Score preferences
description: "User preferences and settings of ossia score"

parent: Reference

permalink: /reference/preferences.html
---

## Audio

**Driver** selects the audio backend; the device, sample-rate and buffer controls below it depend on that backend and the platform. Only available drivers are listed.

If no sound is needed, select **Dummy**, which does not output sound. On Windows, **WASAPI (miniaudio)** is also available. Its **Default device** selection follows changes to the Windows default audio device.

See [Working with audio]({{ site.baseurl }}/quick-start/working-with-audio.html) for device setup and [Audio routing]({{ site.baseurl }}/in-depth/audio-routing.html) for connecting audio processes.

## User interface

This section is split into **Interface** and **Skin** tabs. See [Appearance and skins]({{ site.baseurl }}/reference/appearance.html) for presets, colour and font roles, per-role hinting, automatic saving and resetting. There is no separate global `FontHinting` preference.

The **Interface** tab includes:

| Setting | Effect |
| --- | --- |
| **Default editor** | Choose an external editor executable. |
| **Script editors** | Choose where process code editors open: a separate window, the right pane, or the central area. |
| **Behind central editors** | Choose whether a central script editor appears over the document's background or as a plain editor. |
| **Process UIs** | Choose where embeddable custom process interfaces open. Native plug-in windows such as VST, LV2 and CLAP remain separate windows. |
| **Graphical Zoom** | Scale the interface from 100% to 200%; a build that requires restarting labels this **Graphical Zoom (needs restart)**. |
| **Default Slot Height** | Set the initial height of process slots. |
| **New score duration** | Set the duration used for new scores. |
| **Update Rate (ms)** | Interval for UI events such as execution-engine updates and audio plug-in interfaces; 1–50 ms. |
| **Execution Refresh Rate (hz)** | Main-view refresh rate during execution; 20–500 Hz. Lower values leave more CPU time for processing. |
| **Execution GUI update** | Enable or disable execution-related GUI updates, independently of processing. |
| **Time Bar**, **Show musical metrics**, **Magnetism on musical metrics** | Control the time bar, musical grid display and snapping to musical metrics. |

See [Editing workflow]({{ site.baseurl }}/reference/editing-workflow.html) for editor placement and ways to reduce interface work during playback.

## Graphics

These settings control graphics processing and video output, not the editor skin. Available backends depend on the operating system and build.

| Setting | Effect |
| --- | --- |
| **Graphics API** | Select the rendering backend. OpenGL and Vulkan depend on build support; Metal is offered on Apple platforms, Direct3D 11 on Windows, and Direct3D 12 on Windows builds using Qt 6.9 or newer. |
| **Hardware Video Decoding** | Select a decoder backend, **Auto**, or **None**. The list depends on platform and bundled FFmpeg support; an entry does not guarantee that your GPU supports every codec. |
| **Decoding threads** | Threads per software video decoder. **Auto** chooses the threading strategy and count per codec; a number changes the pool size, not the decoder's threading model. |
| **Multisampling AA** | Request 1, 2, 4, 8 or 16 samples for antialiasing. The usable setting depends on the rendering backend. |
| **VSync** | Synchronize rendering with display refresh. |
| **Rate (if no VSync)** | Requested rendering rate when VSync is disabled, from 1 to 1000. |
| **Buffer count** | Request 1, 2 or 3 rendering buffers. |

Keep **Decoding threads** on **Auto** unless you have a measured reason to override it: a separate pool is used per decoder, so playing several files can multiply the resource cost. For the video workflow, see [Working with video]({{ site.baseurl }}/quick-start/working-with-video.html).

## Execution

Note that every execution settings change require stopping and restarting the playback of the current score.

### Enable listening during execution
This controls whether the Device Explorer panel updates its UI when the score is running. If there are thousands of parameters being updated all the time, monitoring them and updating the UI to show their new value can take some CPU usage which is not always required.

### Logging
When "Logging" is selected in the settings, if you click on the title of a process, then the Messages panel ({% include shortcut.html content="Ctrl+Shift+G" %}) will show all the messages getting in and out of that process.

### Benchmark
When "Benchmark" is selected in the settings, the relative computation time of each process will be computed. This is useful for instance to find if there is a super intensive process taking too much CPU.

### Advanced execution settings
#### Parallel
Runs the processes on separate CPU cores as far as possible.

#### Value compilation
When doing a "play from here", this will try to guesstimate in which state the score should be at that point, by looking for the closest previous sent messages in the score and sending them to the devices.


#### Transport value compilation
Same as value compilation, but redoes it every time you do a transport while the score is playing, with the "play" tool.


