---
layout: default
title: Arranging synth patterns with triggers
description: "An example showing how to compose music with patterns and built-in synthesizers"
parent: Audio
grand_parent: Examples
permalink: /examples/audio/synths.html
score: /examples/audio/synths.score
---

# Arranging synth patterns with triggers

![Triggered bass and drum pattern intervals beneath the outer arrangement and automation curves]({{ site.baseurl }}/assets/scores/thumbnails/examples-audio-synths.png)

This example demonstrates separating musical patterns from their arrangement. Bass, bells and drums each have their own collection of patterns, while a surrounding scenario decides when they play.

## Overview

Interactive triggers let the same musical material participate in different arrangements without moving or copying its notes. Here, two looping sequences of states cue the instrument patterns, and a shared pitch-delay effect helps shape the larger musical form.

The states use the document's exposed `score:/triggers/` addresses. These are local controls, not an OSC server, so no network connection is needed.

## Play the arrangement

No samples or physical MIDI device are required. Use a build with FoMo, Synthimi, Kaboom, Airwindows and BarrVerb; configure the audio device at a low listening level.

1. Start playback and trigger the outer start state near 2 seconds, annotated as the first song. Open the Bass, Bells and Drums scenarios to see which patterns are playing.
2. Trigger a pattern's interactive end directly. Try leaving one instrument out for part of the arrangement, then bringing it back.
3. Trigger the second arrangement's start near 16.06 seconds. Compare its combination of patterns with the first arrangement.
4. Explore the `Automations` interval. Change the PitchDelay Dry/Wet or regeneration curves to make the effect build more gradually; the Step sequencer changes its pitch.
5. Edit a pattern and listen to it in both arrangements. This demonstrates how musical content can be reused while the surrounding structure changes.

Both arrangements loop rather than reaching a fixed song ending. Stop the transport when you have finished listening.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

