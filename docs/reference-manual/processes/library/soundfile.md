---
layout: default

title: Soundfiles
description: "Playing sound files in ossia score"

parent: Processes
grand_parent: Reference

permalink: /processes/soundfile.html
---


# Sound file process

To add a sound file, the easiest way is to drag'n'drop it either from the operating system, or from 
the library.

![Soundfile drop]({{ site.img }}/reference/processes/soundfile-drop.gif "Sound file example")

## Timestretching

ossia score supports 4 modes of playback: 

- No stretching at all (Raw).
- Re-pitching through resampling thanks to the libsamplerate library.
- Time-stretching (pitch does not change) thanks to the Rubberband library, in a mode optimized for drums and another for tonal instruments.

If a file has any tempo information (either through ACID tags or a BPM present in the filename), 
it is automatically assumed to be a loop and put in loop mode with the timestretch enabled.

The tempo of the soundfile can be adjusted through the inspector ; the ratio between its tempo and the current playback tempo 
will be used to timestretch / repitch accordingly.

![Soundfile inspector]({{ site.img }}/reference/processes/soundfile-inspector.png "Sound file inspector")

## RAM / disk playback

score will stream .wav / .aiff files at the same samplerate than the project from disk directly.
All the other files will be decoded first and read from RAM.

 - Until a choice is implemented, we recommend users who have large .wav files and slow hard drives 
   to set-up a RAMDisk manually.

## Supported formats

score should be able to read any file supported by FFMPEG. Current releases are built with FFMPEG 4.4.
The list of supported audio format is available [here](https://www.ffmpeg.org/general.html#Audio-Codecs).
