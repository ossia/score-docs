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

# Metronome

![Metronome]({{ site.img }}/reference/processes/metronome.png "Metronome plug-in")

This plug-in outputs a metronome sound, based on the time signature of its parent interval.

The metronome sounds used can be changed: they are in the [user library]({{ site.baseurl }}/panels/library.html), in the folder "Util" ; the process looks for files named `metro_tick.wav` and `metro_tock.wav`.

The second outlet outputs an impulse on each tick.

# Stereo merger

![Merger]({{ site.img }}/reference/processes/merger.png "Stereo merger plug-in")

This process combines stereo audio signal from N inlets, into one outlet whose channels correspond to the inputs's channels one after each other (mono input channels are duplicated ; no input means silence on the output).

That is, in the example below, the output of the Merger process will be a 4-channel signal with:

* Channel 0, 1: the audio generator (originally mono).
* Channel 2, 3: the drum loop.

![Merger example]({{ site.img }}/reference/processes/merger-2.png "Stereo merger plug-in")

The [Four-source Audio Merger walkthrough]({{ site.baseurl }}/reference/process-examples/audio-merger.html) includes a downloadable multichannel patch.

# Audio Splitter {#splitter}

Splits the channels of **Input** into separate mono **Channel** outlets. **Channels** sets the number of outlets; input channels beyond that count are not copied. Use it to route a multichannel bus to separate effects or recorder paths. It separates channels, not frequency bands.

To select a range from a multichannel input, see [Extracting Channels from an Eight-channel Recording]({{ site.baseurl }}/reference/process-examples/audio-channel-extractor.html).

# Audio recorder

[Audio recorder]({{ site.baseurl }}/processes/audio-recorder.html) records an audio bus to a 16-bit WAV file. Set **File pattern**, enable **Record**, then disable it to close the take and receive its **Filename**. `%n` and `%t` keep numbered or dated takes.

# Beat following

[Beat Tracker]({{ site.baseurl }}/processes/beat-tracker.html) extracts tempo and beat phase from audio or incoming control events. Unlike the metronome above, it follows an external performance; connect its outputs deliberately to tempo, speed or other controls.
