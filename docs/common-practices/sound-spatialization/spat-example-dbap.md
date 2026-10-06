---
layout: default
title: DBAP speaker gains and paths
description: "Explore a sound moving through a four-speaker space."
parent: Spatial audio techniques
grand_parent: Common practices
nav_exclude: true
permalink: /common-practices/sound-spatialization/spat-example-dbap.html
score: /common-practices/sound-spatialization/spat-example-dbap.score
---

# DBAP speaker gains and paths

![Speaker positions and DBAP gains feeding Matrix spatialization, alongside the audio effects chain and RMS traces.]({{ site.baseurl }}/assets/scores/thumbnails/common-practices-sound-spatialization-spat-example-dbap.png)

This example explores how a sound can move through a four-speaker space. A source travels back and forth across the layout, while DBAP calculates how much sound each speaker should receive. The visual displays let you study the movement even without a multichannel sound system.

[Download the example]({{ site.baseurl }}/assets/scores/common-practices/sound-spatialization/spat-example-dbap.score)

{% include try-on-web.html %}

## Setup and run

Use score with the GBAP spatialization add-on (Multi-Cursor Manager, PathGenerator and Matrix spatialization), Faust and Airwindows. The sound source is the default-library `Media/drums/kit1/Ride Cymbal.wav`; install the default media package or replace that Sound file with your own source.

Start playback and watch the two Point2D Views: one shows four speakers near the corners of a square, the other a source travelling diagonally back and forth. Multi-Cursor Manager defines the layout and PathGenerator supplies the movement.

Try moving a speaker or changing the path, and watch the gains in LED View. Adjust DBAP's Roll-off to explore how strongly distance affects the distribution, or Blur to change the behaviour near a speaker.

## Audio routing

The sound is a looping cymbal processed with delay, pitch shifting and a low-pass filter. The delay time is modulated to vary the texture. **Matrix spatialization** distributes the result over four channels, but its saved output only reaches the RMS and Signal displays, not the parent audio mix.

To hear the spatialized result, explicitly route Matrix spatialization's audio outlet to four hardware outputs in your speaker order. A stereo output cannot reproduce the four-speaker layout. Start at low gain: smoothDelay's saved feedback is about 99.8%. Without this routing you can still study the position, gain and RMS displays; the document is not a ready-made device configuration.
