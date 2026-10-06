---
layout: default
title: Multichannel audio and per-channel controls
description: "An example showing multichannel audio processing and polyphonic effects"
parent: Audio
grand_parent: Examples
permalink: /examples/audio/polyphony.html
score: /examples/audio/polyphony.score
---

# Multichannel audio and per-channel controls

![Multichannel delay and mixer routing with VU meters and a list-valued control branch]({{ site.baseurl }}/assets/scores/thumbnails/examples-audio-polyphony.png)

This example demonstrates multichannel audio processing and independent control of each channel. VU meters make it possible to see how sounds are combined, processed separately and reduced to a final mix.

## Overview

An effect does not have to be written for multichannel audio to be useful here: score replicates the mono Airwindows effect across the incoming channels. A Faust delay then uses a list of control values to give the channels different delay times.

The sources are a sound file and an expression-generated tone. Despite its `Detuned saws` label, the expression multiplies two sine waves and duplicates the result on two channels. The sound file starts at channel offset 3, leaving earlier channels available for the other source.

## Setup and observation

Relink `Audio/Grand Pianos 06 80 BPM.wav`, or choose another sound file. It is not packaged with this score-only download. The graph also requires Faust, Airwindows and Object filter support.

1. Start playback and compare the VU meters before and after the mono mixers. Several channels entering a single inlet are summed channel by channel; Mono mix 8 reduces them to one channel.
2. Change the Step sequencer values and watch the displayed delay list. Each step produces five related values, with multipliers 1, 2, 4, 8 and 16, so one gesture changes several delay times together.
3. Try changing those multipliers in Object filter. Compare closely spaced delays with widely separated ones. Keep the list size consistent with the processed channel count if you change the routing.
4. Use Audio Channel Extractor to examine a smaller group of channels, then compare it with the mono and stereo mixes. Notice what is lost when independent channels are summed.

The saved final Stereo Mixer feeds a VU meter, not the parent audio mix. To listen, enable its output's parent-mix routing or assign it to your audio output. The root interval targets `audio:/out/main`. Lower mixer gains first: summing several channels and using the saved high delay feedback can produce high levels.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

