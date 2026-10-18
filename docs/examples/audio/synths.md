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

Bass, bells and drums are stored as phrases you can recall in any order. Two arrangements cue the same pool of patterns in different combinations, without rewriting any notes.

## Patterns and cues

Each instrument has its own pattern scenarios. A surrounding sequence of states triggers those patterns, while a shared pitch-delay treatment changes slowly across the whole arrangement.

The cues use the document's local trigger controls; they do not require an OSC server or a network connection.

## Play the arrangement

No samples or physical MIDI device are required. Use a build with FoMo, Synthimi, Kaboom, Airwindows and BarrVerb; configure the audio device at a low listening level.

1. Start playback and trigger the outer start state near 2 seconds, annotated as the first song. Open Bass, Bells and Drums and follow which patterns are active as the arrangement unfolds.
2. End one active pattern with its interactive end trigger. Listen to the space it leaves before a later cue brings material back; the automatic arrangement may retrigger patterns as it continues.
3. Trigger the second arrangement's start near 16.06 seconds. It combines the same phrases differently: the notes belong to the patterns, not to a copied version of the song.
4. In `Automations`, reshape the PitchDelay Dry/Wet or regeneration curve to make the treatment arrive gradually or abruptly. The Step sequencer changes its pitch, so listen to both the amount of effect and the intervals in its echoes.
5. Edit a pattern used by the arrangements and hear it in each context. A small change to the shared material can affect several passages at once.

Both arrangements loop instead of reaching a fixed ending. Stop the transport when finished.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

