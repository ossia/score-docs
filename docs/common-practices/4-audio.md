---
layout: default

title: "Audio"
description: "Audio in ossia score"

nav_order: 4
parent: Common practices

permalink: /common-practices/4-audio.html
---

# Audio

## Playing a sound file

To play a [sound file]({{ site.baseurl }}/processes/soundfile.html), drag'n'drop it in the score, from the library, or from your operating system.

If you don't hear a sound, check that :

* The time cursor is increasing (if not, that means that the sound card is not [properly configured]({{ site.baseurl }}/faq/doesnotwork.html)).
* The sound file is linked to the beginning of the score via an [interval]({{ site.baseurl }}/processes/scenario.html#intervals).

It should look like this:

![Sound file playing]({{ site.baseurl }}/assets/images/common-practices/audio-1.png)

## Applying an effect

To apply an effect to a sound file:

1. Drop it from the process library to the sound file interval.
2. Connect a cable from the audio file output to the effect input.
   Now the sound will be routed entirely through the effect.
3. Add more effects in the same manner, by connecting the output of the previous effects to the input of the following ones !

<video controls>
    <source src="{{ site.img }}/common-practices/audio-2.mp4" type="video/mp4">
</video>

## Applying an effect to multiple audio files

To apply an effect to multiple files, it would be possible but unwieldy to connect a cable from each file to
the audio effect.

Instead, we can group them in a single [scenario]({{ site.baseurl }}/processes/scenario.html), and rout the scenario's output
to the audio effects:

![Grouping]({{ site.baseurl }}/assets/images/common-practices/audio-group.png)

## Analysing an audio signal

*score* provides a simple envelope analyzer. Combined with the signal display process, this allows
to visualize a signal in the time-line.

1. Add an envelope process (Audio > Envelope).
2. Add a signal display process (Monitoring > Signal display)
3. Route the audio output to the input of the envelope process.
> This means that the entire audio is routed to the envelope process, and thus won't be heard anymore. To prevent this,
> check "Propagate" in the audio outlet inspector.
4. Route the envelope output to the signal display input. The first output measures RMS, the second measures peak values.
5. If the signal is too low, add a Custom Mapping process between the envelope and the signal display,
   in order to multiply it by some factor meaningful for your signal.

![Envelope]({{ site.baseurl }}/assets/images/common-practices/audio-group.png)

## Sound spatialization

*score* allows arbitrary numbers of audio channels to go through its ports.

This makes it possible to use it for instance with large speaker arrays, domes, etc.

A simple and efficient 2D spatialization algorithm is provided with the [Faust](TODO) `spat` preset (which uses the spatialization method devised by Laurent Pottier).

By default, it is to be used with an 8-channel circular loudspeaker array


## Routing audio

* Propagate
* Routing with cables
* Audio device
* Routing with addresses

## Using live audio input

