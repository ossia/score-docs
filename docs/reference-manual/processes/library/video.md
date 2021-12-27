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
Most [common codecs and pixel formats](https://www.ffmpeg.org/general.html#Video-Codecs) are supported ; we use [FFMPEG](https://www.ffmpeg.org/) for decoding plus the HAP library by Vidvox for HAP videos.

If you plan to scrub in the video, it is important to use the HAP codec ; other video codecs make scrubbing very slow (in the worst case, the
entire video may have to be read from the beginning when scrubbing !).

## Usage
- Drag'n'drop the video from the user library or file explorer.

- Videos loop by default ; otherwise a black screen would be shown when reaching the end.

The simplest way to play a video is as follows:
  * Add a [[window]] device
  * Drop the video
  * Select the output port of the video process and assign it to the [[window]] device.

See the example:
<video controls>
    <source src="{{ site.img }}/reference/processes/video.mp4 " type="video/mp4">
</video>

Note that for now the sound tracks contained in video files are not handled; this will be done in a later version. 

As a workaround, audio content can be extracted from the video and dropped on the same interval to preserve synchronisation.

![synchronize]({{ site.img }}/reference/processes/video_audio_sync.png "Synchronize")

The  following ffmpeg command can be used to extract audio track from a given input file :
```
ffmpeg -i <input_file> extracted_audio.wav
```