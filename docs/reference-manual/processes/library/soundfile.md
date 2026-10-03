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

The current development build chooses a decoder automatically:

| Source | Usual playback path |
| --- | --- |
| WAV / W64 supported by the WAV decoder | Memory-mapped disk access, without decoding the whole file into RAM |
| AIFF / AIF / AIFC / CAF up to 4 GiB, supported by libsndfile | Decoded into RAM |
| Other audio up to 4 GiB | Decoded into RAM through FFmpeg |
| Files above 4 GiB that cannot use the memory-mapped path | Streaming through FFmpeg |
| Audio taken from a supported video container | Streaming through FFmpeg |

The size threshold concerns the source file, not the size of decoded samples.
Disk speed and decoder cost still matter for streaming, especially with seeking.
The browser build uses a different policy: video and files above 48 MiB use
streaming decode, while smaller audio files are decoded into RAM.

Sample-rate mismatches are normally converted in the audio graph rather than by
resampling the entire file on import. Builds without graph resampling fall back
to a suitable decoding path. This conversion is distinct from the musical
time-stretch mode above.

## Supported formats and video soundtracks

The audio file drop handler recognizes WAV, W64, MP3, M4A, OGG, FLAC, AIF, AIFF,
AIFC, CAF, APE, WV, WMA, AAC, OPUS, AC3, DTS and DTSHD extensions. Actual decoding
depends on the codec and the libraries included in the build; an extension alone
does not guarantee that a particular file is readable.

The sound-file loader also accepts audio from supported video containers. Select
the video file as the sound process's source when only its soundtrack is needed;
this does not create a video output. Route the process's audio outlet to an effect
or an [Audio device]({{ site.baseurl }}/devices/audio-device.html) bus as usual.
