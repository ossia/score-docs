---
layout: default
title: "Working with audio"
parent: Quick start
nav_order: 6

permalink: /docs/quick-start/working-with-audio.html
category: "site-score"

description: "Working with audio within score"

tag: "Presentation"
visible: true
---
# Working with audio in *score*
## Audio setup

Before playing with audio soundfiles or synthesis in *score* you may want to ensure audio settings are properly set up.

To do so, open the `Preferences` window from the *score* menu and select the "Audio" tab in the left side of the Preferences window.

Then select the Driver you want to use as well as the desired audio interface and related options (Buffer size and sample rate).

![Audio setup](/score-docs/assets/images/quick-start/working-with-audio/audio-preferences.png "Audio setup")

Make sure the audio switch is properly lit on. 

![Audio switch](/score-docs/assets/images/quick-start/working-with-audio/audio_switch.png "Audio setup")

When done, you are ready to go !

## Playing audio file

Audio files can easily be integrated to your scenario. Just grab your file on your disk and drop it at the desired place on the timeline. Click the play button (or use {% include shortcut.html content="spacebar" %} shortcut) and that's it.

> By default, *score* will use the main stereo output of your audio interface. Be sure to read the [audio routing](/score-docs/in-depth/audio_routing.html "Audio routing") section for more information.

![Playing audio files](/score-docs/assets/images/quick-start/working-with-audio/reading-audio-file.gif "Playing audio files")

## Combining audio medias and devices control

Audio files (and more generally medias) can be fully combined with device's automations or other processes in the scenario. Thus you can write medias playing and distant devices remote control at a one unified and only place.

In the example below, we just want to play one audio file synchroneously with some automations already in place. Rather than dropping our audio file on the timeline and align things by hand, we can just drop it on the automation's slot top bar so it sticks to it. 

In this particular case, you may notice though that the dropped soundfile is shorter than the full length of the automation. Just bring the audio file inspector and toggle the loop mode. Now when playing the scenario, the audio file will loop as long as the automation is playing.

![Audio file and other processes](/score-docs/assets/images/quick-start/working-with-audio/combining-audio-and-other-processes.gif "Audio files and other processes")

## Adding audio effects

Contrary to some other softwares, *score* does not rely so much on the studio recording metaphore involving the usual mixing desk, per track FX, fixed busses and so on. Rather, it relies much more on a time-based modular approach. Without going too much into details of *score* engine for now, let's just say that it offers to have a unique sound chain (audio source, FX or modulators) for each block of the scenario involving audio.

As illustrated below, you can easily add some FX, either from the built-in library or some VST effects installed on your computer to some audio file in your scenario. When dropped, a patch-like workspace is created. 

For demonstration purpose here, we will just add a simple gain controller. Below the soundfile waveform, you can note a red dot. This actually is the audio output. We can just drag a cable from this red dot down to the red circle (its input) at the left of the gain FX. When playing the scenario, audiofile will now play through this simple FX and go out to the main output. Again, when the playhead gets beyond the automation's slot, audio will get fully bypassed (hence preventing from any CPU drain).

![Adding FX](/score-docs/assets/images/quick-start/working-with-audio/simple-audio-fx.gif)

Feel free to get familiar with this patch workspace using other audio FX or VST of your own collection.

> You may also note some yellow circle and frames. These are respectively control input and output of some processes parameter. Should you feel adventurous, have fun checking the `Control` folder in the `Process library` to add modulation to your FX's parameters.