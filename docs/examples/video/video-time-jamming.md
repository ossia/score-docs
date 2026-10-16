---
layout: default
title: "Scrubbing video and scenario time"
description: "Perform with video speed, position and scenario time while an independent rhythm keeps running."
parent: Video Examples
grand_parent: Examples
permalink: /examples/video/video-time-jamming.html
score: /examples/video/video-time-jamming.zip
---

# Scrubbing video and scenario time

![Sequenced clips and feedback effects inside the Cat FX performance section]({{ site.baseurl }}/assets/scores/thumbnails/examples-video-video-time-jamming.png)

Speed up, reverse and jump through footage as part of a performance. Four manually triggered sections let you compare a composed tempo curve, rhythmic speed changes, jumps in movie position and scrubbing a whole arrangement of clips and effects.

## Control time from outside

The time-control processes run separately from the media they affect. Their rhythm can therefore keep going while the target clip reverses or jumps. Position is measured in milliseconds; a tempo of 120 corresponds to normal speed.

The Cat FX section extends this idea to a nested scenario: changing its time moves through the arrangement, not just through one movie. Sequenced clips and feedback treatments become material to revisit and interrupt. Generated percussion provides an accompanying rhythm.

## Setup

Open the ZIP directly in score. Use a build providing Kaboom and Airwindows for the audio branches, and begin at a low listening level. The cat footage is credited to [Andrew Kota on Pexels](https://www.pexels.com/video/the-cat-scratched-the-wood-3693815/).

For responsive reverse playback and jumps, use an all-intra format such as HAP and the Video inspector's Direct/Seek mode. Buffered forward playback prioritizes a different use and can lag when scrubbing.

## Try it

- Start playback and trigger one branch-start time-sync at a time. Watch the target interval's progress line to see whether time moves continuously or jumps.
- Change the LFO driving speed, then a position sequencer's steps. Compare a reversal through nearby frames with a cut to a distant point in the movie.
- Trigger Cat FX and change its time modulation. Notice how this changes which clips and effects are active; move the pointer in the output window to influence its pointer-controlled feedback graphics.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
