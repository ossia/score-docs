---
layout: default

title: Working with video
description: "Working with video within *score*"

parent: Quick start
nav_order: 7

permalink: /quick-start/working-with-video.html
---
# Working with video in *score*

*score* embeds a number of video related features: media playing and processing, GPU-based processing or synthesis. Just like with audio files, video files can be thus fully integrated to your scenario along with other processes and distant devices controls.

## Supported formats

*score* uses FFmpeg for video decoding, with format support determined by the installed build. Common containers, transport streams and production codecs are supported, but a filename extension alone does not establish codec/profile or hardware support. Start with a known playable file; see [Video formats and color]({{ site.baseurl }}/processes/video-formats-color.html) for HAP/DXV, high-bit-depth video and HDR.

## Video setup

First, we need to setup our video output. To do so, we need to add a video window device to our project by right-clicking in the `Device explorer` pane and choose `Add device` from the contextual menu. In the device setup window, mouse over to the video category and choose the `Window device`. You may define a name for the video window or use the default name and click `Add`.

When done, *score* creates a black video window.

![Create window device]({{ site.img }}/quick-start/working-with-video/window-device.gif)


> The device appears in the `Device explorer` with window controls such as size, position, fullscreen and render size. Closing the window does not remove its device; use the device's contextual **Show** action to reopen it. The [Window device reference]({{ site.baseurl }}/devices/window-device.html) also covers Background rendering and Multi-Window Mapping in current development builds.

## Playing a video file

To add a video file to the timeline, just grab your file on disk or in the project library and drop it where you want on the timeline. As seen in the [previous section]({{ site.baseurl }}/quick-start/working-with-audio.html "Working with audio within score"), you may as well drop it on top of some already existing automation's slot so your video file is aligned.

When done, a slot containing the video file gets created on the timeline. This creates a [[Video]] process. You can adjust the length of the slot to fit the part of the video file to play following the different key frames of the video.

![Add video file]({{ site.img }}/quick-start/working-with-video/adding-video-file.gif)

We now need to route our video file to our video window so it gets displayed when execution the scenario. Just as with other processes used so far (automation as well as audio), the video slot has an output port at the bottom: the white filled circle.

Click on the output port to bring its inspector. From there, select your window video device in the dedicated menu. Now when executing your scenario, video file will get properly displayed in window.

![Video routing]({{ site.img }}/quick-start/working-with-video/video-routing.gif)

## Adding video effects

Again, similarly to audio files, you can easily drag some effects. From the `Processes Library` pane or from the `User library` pane, select one of the processes in the `GFX` category. In the example below, we will use the `Shader filter` provided in *score* default library.

We now need to route our video file to the video effect rather than directly to the window. Drag a cable from the video output port (the white filled circle) to the effect input port (the white framed circle), as shown below. Then select the window device as the destination in the shader's texture output inspector (`GFX` is the window's name in this example).

![Video effect routing]({{ site.img }}/quick-start/working-with-video/video-effect-routing.gif)

You may now play with the shader parameters using its UI as the scenario is executed or write some automations.

## Playback, capture and output choices

In the Video inspector, start with **Playback: Auto**. It chooses direct frame access for suitable all-keyframe footage and buffered playback otherwise. **Direct (seek)** is useful for scrubbing but can be expensive with long-GOP files; **Frame queue** is the normal buffered path. Graphics preferences separately control **Hardware Video Decoding** and **Decoding threads**.

The Video process carries the picture, not the soundtrack. Place an extracted audio file in an audio process on the same interval when you need synchronized sound; see [Video]({{ site.baseurl }}/processes/video.html).

To use live images, add a [Camera or Window Capture]({{ site.baseurl }}/devices/camera-device.html), [GStreamer]({{ site.baseurl }}/devices/gstreamer-device.html) or [PipeWire video]({{ site.baseurl }}/devices/pipewire-device.html) device and select it as a texture inlet's source. To send a result to another application or stream, assign the final texture outlet to the corresponding output device instead of the window. See [Livestreaming]({{ site.baseurl }}/common-practices/10-livestreaming.html).

For a first SDR output, keep the Video **Format** at **SDR**. HDR source conversion and the output window's HDR mode are separate settings; consult the color reference before switching either one.

