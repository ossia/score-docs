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

Keep the notes of a pattern in place while changing the music they produce. Arpeggiation reorganizes their rhythm and order; scale mapping changes their pitch relationships.
Three MIDI displays reveal the original pattern, the arpeggiated notes and the scale-mapped result. The final notes play Synthimi's `Pluckies` sound; slower modulation moves the scale root and changes the synth's articulation. Use a build with Synthimi and Airwindows. No external MIDI device or samples are needed.

## Try the transformations

1. Select an audio output, lower the listening level and start playback. Follow the same phrase through the three MIDI displays to connect the visible note transformations with what you hear.
2. Raise the Arpeggiator's Rate and Octave for a fast, wide-ranging figure, or lower them for a slower, narrower one; the source pattern stays the same.
3. Change Midi scale's Transpose to move the register, then select another scale to change the pitch relationships.
4. Slow the LFO that advances the wrapping Counter controlling Base. Each scale root then lasts longer, making the changing tonal centre easier to hear.
5. Reduce Drive's Dry/Wet for a cleaner synth sound. Listen for the amplitude-decay modulation as well as the small oscillator-pitch changes.

Finally, edit the source pattern: the transformation chain applies the same treatment to the new notes.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

