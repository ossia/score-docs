---
layout: default
title: Live audio looper with drum backing
description: "An example showing how to record and loop live audio"
parent: Audio
grand_parent: Examples
permalink: /examples/audio/looper.html
score: /examples/audio/looper.zip
---

# Live audio looper with drum backing

![Looper controls beside a drum pattern and its Deuterium sampler on the timeline]({{ site.baseurl }}/assets/scores/thumbnails/examples-audio-looper.png)

This example demonstrates live looping with a sequenced drum accompaniment. Timeline states switch between recording and playback, letting you arrange when a live performance becomes a repeating musical phrase.

The Looper records `audio:/in/main`. The drum backing is separate and is not recorded internally with the input.

## Prepare and record

1. Open the ZIP directly in score. Deuterium references the bundled `Data/Techno-1/drumkit.xml` and the kit's samples.
2. Configure the audio device with a working input and output. Use headphones or isolated monitoring to avoid feeding the loudspeaker output back into a microphone.
3. Start playback and supply audio to the input. The initial state sets the Looper's Loop control to `Stop`; the state at 0.5 seconds requests `Record`; the state at 4.5 seconds requests `Play`.
4. Listen for the captured material repeating over the sequenced drums. The saved Looper has Quantif set to 1, so its mode changes follow its musical quantization rather than an unquantized switch.
5. Trigger the main interval's end, nominally placed at 7 seconds, to finish both processes, or stop the transport. That end is interactive and does not automatically fire at its drawn position.

## Try it

Record a short voice or instrument phrase, then listen to how it fits against the drums. Move the Record and Play states to explore a different recording window, keeping the Looper's musical quantization in mind.

The states control the Looper through the Local device; no remote client is needed. Open a state to inspect its target before adapting the example to control another process.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

