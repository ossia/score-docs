---
layout: default
title: MIDI effects and arpeggiation
description: "Hear one MIDI pattern become different phrases through arpeggiation, scale mapping and a moving tonal centre."
parent: Audio
grand_parent: Examples
permalink: /examples/audio/midi-fx.html
score: /examples/audio/midi-fx.score
---

# MIDI effects and arpeggiation

![Arpeggiator and Midi scale feeding Pluckies, with MIDI displays beneath the processing stages]({{ site.baseurl }}/assets/scores/thumbnails/examples-audio-midi-fx.png)

Keep the notes of a pattern in place while changing the music they produce. Arpeggiation reorganizes their rhythm and order; scale mapping changes their pitch relationships. Together they let a small amount of written material sustain a longer passage or respond to a performer's changes.

Three MIDI displays reveal the original pattern, the arpeggiated notes and the scale-mapped result. The final notes play Synthimi's `Pluckies` sound; slower modulation moves the scale root and changes the synth's articulation. Use a build with Synthimi and Airwindows. No external MIDI device or samples are needed.

## Try the transformations

1. Select an audio output, lower the listening level and start playback. Follow the same phrase through the three MIDI displays to connect the visible note transformations with what you hear.
2. Change the Arpeggiator's Rate and Octave controls. Compare a fast, wide-ranging figure with a slower, narrower one: the source pattern stays the same, but its energy changes.
3. Change Midi scale's Transpose to move the register, then select another scale to change the pitch relationships. These are different musical decisions; listen to each separately.
4. Slow the LFO that advances the wrapping Counter controlling Base. Each scale root then lasts longer, making the changing tonal centre easier to hear.
5. Reduce Drive's Dry/Wet to compare the processed synth with a cleaner sound. Listen for the amplitude-decay modulation as well as the small oscillator-pitch changes.

Finally, edit the source pattern and compare the result with your earlier parameter changes. This separates composition from interpretation: you can reuse the transformation chain with new material, or perform variations on one phrase.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

