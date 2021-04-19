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
* The sound file is linked to the beginning of the score via an [interval]({{ site.baseurl }}/processes/scenario.html#interval).

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


## Routing audio

## Using live audio input