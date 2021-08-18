---
layout: default

title: Audio utilities
description: "Various utility audio processes"

parent: Processes
grand_parent: Reference

permalink: /processes/audio-utilities.html
---

# Gain

![Gain]({{ site.img }}/reference/processes/gain.png "Gain plug-in")

This plug-in simply multiplies its input audio by a gain value.

# Envelope

![Envelope]({{ site.img }}/reference/processes/envelope.png "Envelope plug-in")

This plug-in allows to take the envelope (first outlet is RMS, second outlet is peak) of an input audio signal.
The output will be an array with as many values than there are channels in the input signal.

The signal is often a small value, which can be boosted for instance with a [[Math expressions|mapping]].

# Metronome

![Metronome]({{ site.img }}/reference/processes/metronome.png "Metronome plug-in")

This plug-in outputs a metronome sound, based on the time signature of its parent interval.

The metronome sounds used can be changed: they are in the [user library]({{ site.baseurl }}/in-depth/library.html), in the folder "Util" ; the process looks for files named `metro_tick.wav` and `metro_tock.wav`.

The second outlet outputs an impulse on each tick.

# Merger

![Merger]({{ site.img }}/reference/processes/merger.png "Stereo merger plug-in")

This process combines stereo audio signal from N inlets, into one outlet whose channels correspond to the inputs's channels one after each other (mono input channels are duplicated ; no input means silence on the output).

That is, in the example below, the output of the Merger process will be a 4-channel signal with:

* Channel 0, 1: the audio generator (originally mono).
* Channel 2, 3: the drum loop.

![Merger example]({{ site.img }}/reference/processes/merger-2.png "Stereo merger plug-in")
