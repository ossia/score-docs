---
layout: default

title: Video
description: "Playing back video files in ossia score"

parent: Processes
grand_parent: Reference

permalink: /processes/video.html
---

# Video
The Video process plays a video file into a texture output, which can feed effects or a video output device.

FFmpeg decodes the media; score then converts its pixels for the graphics pipeline. These are separate operations: GPU YUV-to-RGB conversion does **not** mean that the codec itself is hardware-decoded. See [Video formats and color]({{ site.baseurl }}/processes/video-formats-color.html) for format, hardware-decoder and HDR details.

## Usage

To add a video to a score, the simplest is to drag'n'drop it from the user library to the score.
Videos loop by default to facilitate VJ use-cases. Otherwise a black screen would be shown when reaching the end. Do not forget to set a trigger at the end, though !

The simplest way to play a video is as follows:
  * Add a [[window]] device
  * Drop the video
  * Select the output port of the video process and assign it to the [[window]] device.

See the example:
<video controls>
    <source src="{{ site.img }}/reference/processes/video.mp4" type="video/mp4">
</video>

The Video process exposes a texture output, not an audio output. Extract the soundtrack and place an audio process on the same interval when sound is needed:

![synchronize]({{ site.img }}/reference/processes/video_audio_sync.png "Synchronize")

The  following ffmpeg command can be used to extract audio track from a given input file :
```
$ ffmpeg -i <input_file> extracted_audio.wav
```

## Inspector controls

The video inspector allows to set a stretch mode and the timing behaviour: 

![video inspector]({{ site.img }}/reference/processes/video_inspector.png "Video inspector")

- **Scale** offers **Original size**, **Expand (Black bars)**, **Expand (Fill)** and **Stretch**.
- Tempo is used to map the video to the score tempo, and to enable time-stretching with the [[Tempo]] process. 
  If **Enable tempo** is not set, then the video will play at its internal rate. Otherwise, it will assume that the video is
  at the given tempo, and play it faster / slower depending on the difference between that tempo and the score's actual playback speed: 
  a video set at 120 will play twice as slow if the score tempo is at 60.

### Playback mode

Three modes are available:

- **Auto** selects Direct playback for HAP/DXV and streams classified as having a keyframe at every frame; other streams use the frame queue. Selection follows the actual stream layout, not simply its filename extension.
- **Direct (seek)** requests the frame containing the current timeline time. It suits scrubbing and independently decodable frames, but forcing it on long-GOP footage can be expensive.
- **Frame queue** is the normal buffered playback path: frames are decoded ahead and selected according to playback time. Prefer this for sequential playback of inter-frame codecs.

This setting is independent of **Hardware Video Decoding** in graphics preferences. **None** uses software codec decoding; **Auto** attempts available hardware backends. Hardware and graphics-backend compatibility can require a CPU transfer even when decoding is accelerated.

### Color output

**Format** offers **SDR**, **Passthrough**, **Linear** and **Normalized**. **Tonemap (HDR)** offers **Clamp**, **BT.2390**, **BT.2446**, **Reinhard**, **Hable**, **ACES2**, **AgX**, **PBR Neutral** and **Auto**. These controls prepare the texture for downstream effects; they do not configure a monitor or turn an SDR window into an HDR output.

See [Video formats and color]({{ site.baseurl }}/processes/video-formats-color.html#hdr-and-color-output) before combining HDR sources, shaders and output devices.

## Limitations

Support depends on the FFmpeg build, codec profile and graphics backend. HAP, DXV and intra-frame formats are useful for interactive seeking; H.264 or HEVC footage with long groups of pictures may require decoding from an earlier keyframe when seeking.

The importer recognizes transport-stream files including `.ts`, `.mts` and `.m2ts`, as well as common containers such as MOV, MP4, MKV and MXF. A container extension does not identify its codec.

To re-encode a video into HAP, use an FFmpeg build with the HAP encoder:

```
$ ffmpeg -i source.mov -c:v hap <OPTIONS> output.mov
$ ffmpeg -i source.mov -c:v hap -format hap_alpha outputName.mov
$ ffmpeg -i source.mov -c:v hap -format hap_q outputName.mov
$ ffmpeg -i source.mov -c:v hap -compressor none outputName.mov
$ ffmpeg -i source.mov -c:v hap -format hap_q -chunks 4 outputName.mov
```

The (optional) HAP-related options can be: 

- `-format hap_alpha` for alpha-channel support
- `-format hap_q` for HAP Q codec support
- `-compressor none` slightly reduces playback CPU usage at the cost of larger file sizes.
- `-chunks <N>` with N a number between 1 and 64: optimizes the file for a specific multi-core decoding configuration.
  

