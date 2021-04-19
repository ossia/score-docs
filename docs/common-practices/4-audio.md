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

To play a [[Soundfiles|sound file]], drag'n'drop it in the score, from the library, or from your operating system.

If you don't hear a sound, check that :

* The time cursor is increasing (if not, that means that the sound card is not [properly configured]({{ site.baseurl }}/faq/doesnotwork.html)).
* The sound file is linked to the beginning of the score via an [interval]({{ site.baseurl }}/processes/scenario.html#intervals).

It should look like this:

![Sound file playing]({{ site.img }}/common-practices/audio-1.png)

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

![Grouping]({{ site.img }}/common-practices/audio-group.png)

## Fade-ins and fade-outs

Every audio outlet has a "gain" sub-outlet which can be used to perform fades.

1. Press the audio outlet.
2. Right-click on the "gain" port.
3. Select "Create automation".

The created automation can then be used to adjust the volume of that output in time.

![Fading]({{ site.img }}/common-practices/audio-fade.png)

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

![Envelope]({{ site.img }}/common-practices/audio-envelope.png)

## Sound spatialization

*score* allows arbitrary numbers of audio channels to go through its ports.

This makes it possible to use it for instance with large speaker arrays, domes, etc.

A simple and efficient 2D spatialization algorithm is provided with the [[Faust]] `spat` preset (which uses the spatialization method devised by Laurent Pottier).

By default, it will spatialize a mono source on a 8-channel circular loudspeaker array.

![Spatialization]({{ site.img }}/common-practices/audio-spat.png)

It is possible to edit the Faust script, to change the number of loudspeakers:

1. Press the "Window" icon next to the Faust process name, to open its editor.
2. Edit the following line with the number of wanted loudspeakers instead of `8`:

    ```faust
    process = vgroup("Spatializer 1x8", sp.spat(8, angle, distance));
    ```

3. Press "Compile". The Faust process will be compiled and updated automatically.

## Using live audio input

To use a live audio input in a part of the score, follow these steps:

1. Set-up the [[audio device]] in the device explorer.
2. Drag'n'drop the input address to use as an input of a sound effect.

In the following example, a stereo bus receiving a stereo guitar signal has been created.
It is sent to a reverb.

<video controls>
    <source src="{{ site.img }}/common-practices/audio-input.mp4" type="video/mp4">
</video>
