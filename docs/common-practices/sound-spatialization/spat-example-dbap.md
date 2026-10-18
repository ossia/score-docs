---
layout: default
title: DBAP speaker gains and paths
description: "Follow a cymbal texture across a four-speaker layout and explore how distance shapes the speaker gains."
parent: Spatial audio techniques
grand_parent: Common practices
nav_exclude: true
permalink: /common-practices/sound-spatialization/spat-example-dbap.html
score: /common-practices/sound-spatialization/spat-example-dbap.zip
---

# DBAP speaker gains and paths

![Speaker positions and DBAP gains feeding Matrix spatialization, alongside the audio effects chain and RMS traces.]({{ site.baseurl }}/assets/scores/thumbnails/common-practices-sound-spatialization-spat-example-dbap.png)

A cymbal texture travels diagonally across a four-speaker space. As its imagined position moves, distance-based amplitude panning (DBAP) changes the share of sound assigned to each speaker. The position and level displays show that distribution without a multichannel system connected.

[Download the example]({{ site.baseurl }}/assets/scores/common-practices/sound-spatialization/spat-example-dbap.zip)

{% include try-on-web.html %}

## Setup and run

Open the ZIP directly in score; the cymbal recording is included. The patch needs the GBAP spatialization add-on, Faust and Airwindows.

Start playback and look at the two Point2D Views: one shows four speakers near the corners of a square, while the other shows the source moving diagonally back and forth. **DBAP** compares those positions to calculate speaker gains; **Matrix spatialization** applies the gains to the processed sound.

Move one speaker in **Multi-Cursor Manager**, or change the path in **PathGenerator**, and watch the balance shift in LED View. Increase Roll-off to make distance weigh more strongly in that balance. Then vary Blur near a speaker to explore a less concentrated distribution. You are changing how a position becomes a set of loudness relationships, not moving a recorded stereo pan.

## Audio routing

The looping cymbal passes through a modulated delay, pitch shifting and low-pass filtering to form the sound being moved. The four-channel result feeds RMS and Signal displays and, because Matrix spatialization's outlet propagates, is also mixed into the main audio output; on a stereo output the four channels are folded together.

To hear it spatially, disable propagation on Matrix spatialization's audio outlet and route it explicitly to four hardware outputs in the same order as your speaker layout. Start at low gain and reduce the delay feedback before auditioning: the saved feedback is about 99.8%, so the texture can persist strongly. A stereo output cannot reproduce the four-speaker arrangement. Without hardware routing, the displays still let you study positions, gains and channel activity.
