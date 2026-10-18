---
layout: default
title: Live audio looper with drum backing
description: "Capture a live voice or instrument over a drum backing, then use timeline cues to turn the recorded phrase into a repeating part."
parent: Audio
grand_parent: Examples
permalink: /examples/audio/looper.html
score: /examples/audio/looper.zip
---

# Live audio looper with drum backing

![Live-looping controls and a drum accompaniment arranged on the timeline]({{ site.baseurl }}/assets/scores/thumbnails/examples-audio-looper.png)

Play a short phrase once, then hear it return over a drum backing. The timeline switches the Looper from stopped to recording to playback, so the moment a live phrase becomes a repeating part is composed in advance.

The Looper captures the main audio input, not the internally generated drums, so the accompaniment stays out of your recording.

## Prepare and record

1. Open the ZIP directly in a score build with Kaboom support. The current score uses synthesized drums and needs no sample kit. Configure a working audio input and output.
2. Use headphones or isolated monitoring to avoid feeding loudspeaker output back into a microphone. Begin at a low listening level.
3. Start playback and supply audio to the input. The initial cue requests `Stop`, the cue at 4 seconds requests `Record`, and the cue at 12 seconds requests `Play`.
4. Listen for the captured phrase repeating against the drums. Quantif is set to 1, so mode changes wait for the next quantized boundary instead of switching freely between beats.
5. Trigger the end of `Loop`, drawn at 14.5 seconds, or stop the transport. The end is interactive: its position is not an automatic stop.

## Shape the phrase

Record a phrase with a clear attack and a little silence at the end. Listen to the join between repetitions, then move the Record or Play cue to change what falls inside the capture window. Because of quantization, the audible switch can come slightly after the cue.

Try a sustained sound next. A capture window that works for a rhythmic phrase may cut a sustained note differently; this makes the recording boundary part of the composition. The cues address the Looper through the Local device, so no remote client is required.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

