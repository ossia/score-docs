---
layout: default

title: Video
description: "Playing back video files in ossia score"

parent: Processes
grand_parent: Reference

permalink: /processes/video.html
---

# Video
The video process allows to play a video.

Video decoding is done with the help of the GPU as far as possible, e.g. for YUV420P or HAP data.
Most [common codecs and pixel formats](https://www.ffmpeg.org/general.html#Video-Codecs) are supported ; we use [FFMPEG](https://www.ffmpeg.org/) for decoding plus the [HAP library](https://github.com/Vidvox/hap) by Vidvox for HAP videos.

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

Note that for now the sound tracks contained in video files are not handled; this will be done in a later version. 

As a workaround, audio content can be extracted from the video and dropped on the same interval to preserve synchronization.

![synchronize]({{ site.img }}/reference/processes/video_audio_sync.png "Synchronize")

The  following ffmpeg command can be used to extract audio track from a given input file :
```
$ ffmpeg -i <input_file> extracted_audio.wav
```

## Inspector controls

The video inspector allows to set a stretch mode and the timing behaviour: 

![video inspector]({{ site.img }}/reference/processes/video_inspector.png "Video inspector")

- Stretch modes can be the usual stretch / fill / keep original.
- Tempo is used to map the video to the score tempo, and to enable time-stretching with the [[Tempo]] process. 
  If **Use tempo** is not set, then the video will play at its internal rate. Otherwise, it will assume that the video is 
  at the given tempo, and play it faster / slower depending on the difference between that tempo and the score's actual playback speed: 
  a video set at 120 will play twice as slow if the score tempo is at 60.

## Limitations

While for simple playback any video format should work, we recommend using a seek-optimized format such as HAP or MJPEG when working on 
a score. This is because usual video formats for playback, such as H.264 or HEVC (H.265) make tradeoffs for better compression that make seeking much more complicated: 
in the theoretical worst case, the decoder needs to decode the entire video from the beginning when seeking which of course takes too long.

To reencode a video into HAP, you can use ffmpeg from the command-line (or the Handbrake GUI).

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
  

