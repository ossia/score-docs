---
layout: default
title: Arranging synth patterns with triggers
description: "Perform different arrangements of shared bass, bell and drum patterns, using triggers and effect curves to shape the larger musical form."
parent: Audio
grand_parent: Examples
permalink: /examples/audio/synths.html
score: /examples/audio/synths.score
---

# Arranging synth patterns with triggers

![Triggered bass and drum pattern intervals beneath the outer arrangement and automation curves]({{ site.baseurl }}/assets/scores/thumbnails/examples-audio-synths.png)

Treat bass, bells and drums as a collection of phrases you can recall, rather than a song fixed to one ordering. Two arrangements cue the same pool of patterns, letting you hear how a change of combination or entrance reshapes the music without rewriting its notes.

## Separate the phrase from the cue

Each instrument has its own pattern scenarios. A surrounding sequence of states triggers those patterns, while a shared pitch-delay treatment provides a larger-scale gesture. This separation is useful for live sets with alternate versions of a passage, or for a piece that must leave room for a performer's timing.

The cues use the document's local trigger controls; they do not require an OSC server or a network connection.

## Play the arrangement

No samples or physical MIDI device are required. Use a build with FoMo, Synthimi, Kaboom, Airwindows and BarrVerb; configure the audio device at a low listening level.

1. Start playback and trigger the outer start state near 2 seconds, annotated as the first song. Open Bass, Bells and Drums and follow which patterns are active as the arrangement unfolds.
2. End one active pattern with its interactive end trigger. Listen to the space it leaves before a later cue brings material back; the automatic arrangement may retrigger patterns as it continues.
3. Trigger the second arrangement's start near 16.06 seconds. Compare its combination of phrases with the first. The notes belong to the patterns, not to a copied version of the song.
4. In `Automations`, reshape the PitchDelay Dry/Wet or regeneration curve to make the treatment arrive gradually or abruptly. The Step sequencer changes its pitch, so listen to both the amount of effect and the intervals in its echoes.
5. Edit a pattern used by the arrangements and hear it in each context. A small change to the shared material can affect several passages at once.

Both arrangements loop rather than reaching a fixed ending. Stop the transport when finished. For your own performance, this structure can separate rehearsed musical material from the decision about when to recall it.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

