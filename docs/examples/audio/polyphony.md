---
layout: default
title: Multichannel audio and per-channel controls
description: "Give audio channels different resonant delays, then hear what changes when independent signals are combined into a mono or stereo mix."
parent: Audio
grand_parent: Examples
permalink: /examples/audio/polyphony.html
score: /examples/audio/polyphony.zip
---

# Multichannel audio and per-channel controls

![Multichannel delay and mixer routing with VU meters and a list-valued control branch]({{ site.baseurl }}/assets/scores/thumbnails/examples-audio-polyphony.png)

One control gesture can produce several different resonances when it reaches several audio channels. This score processes a recording and a synthesized tone in parallel, gives their channels different delay times, then combines them into a final mix. It is a useful sketch for layered sound design or an installation that needs channels to remain independently controllable.

## Hear the channels, not just the cable

An audio cable can carry several channels. The mono Airwindows effect is applied independently to each incoming channel; the Faust delay receives a list of delay values, one per channel. A step sequence changes the whole list together, preserving the relationships between its values.

The sound file is placed at a channel offset, leaving earlier channels for the generated tone. VU meters show the channels before and after processing and mixing. Mono mixing combines them, while channel extraction lets you inspect a subset without first collapsing everything.

## Setup and observation

Open the ZIP directly in score; the recording is included. Use a build with Faust, Airwindows and Object filter support, and configure audio output. Lower mixer gains before playing: the saved delay feedback is high, and summing channels can produce high levels.

1. Compare the VU meters before and after the mono mixers. Channels arriving at the same inlet are combined channel by channel; Mono mix 8 then reduces its inputs to one channel. Watch the level as well as the channel count.
2. Change the Step sequencer values and watch the delay list. Each value becomes five related values, using multipliers of 1, 2, 4, 8 and 16. Listen for how one change moves several resonances together.
3. Edit those multipliers in Object filter. Compare closely spaced delays with widely separated ones. Keep the list length matched to the processed channel count if you change the routing.
4. Compare the Audio Channel Extractor's meters with the mono mix. To audition the extracted channels, route its output to a separate listening path at low gain. This is an adaptation of the saved monitoring branch, not an additional speaker mix already configured.

The saved Stereo Mixer sends the combined result to the parent audio mix and a VU meter. Keep channels separate until the point where you deliberately want to combine them; this is the transferable idea if you later route the work to more speakers.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

