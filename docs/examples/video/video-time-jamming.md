---
layout: default
title: "Scrubbing video and scenario time"
description: "An example exploring playback time as a performance control."
parent: Video Examples
grand_parent: Examples
permalink: /examples/video/video-time-jamming.html
score: /examples/video/video-time-jamming.score
---

# Scrubbing video and scenario time

![Cat FX scenario with sequenced video clips, Echo Trace and Multi Feedback]({{ site.baseurl }}/assets/scores/thumbnails/examples-video-video-time-jamming.png)

This example demonstrates treating playback time as a performance control.

## Overview

Four manually triggered sections explore tempo curves, rhythmic speed changes, jumps in video position and scrubbing an entire nested scenario. The Cat FX section combines sequenced clips with feedback effects, so changing scenario time also changes the arrangement being played.

The time controls run separately from the media they affect. This keeps their rhythm independent while a clip speeds up, reverses or jumps. Position is measured in milliseconds, and a tempo of 120 corresponds to normal speed. Generated percussion provides an accompanying rhythm.

## Files and playback

This is a loose score. Supply `cat.mov` beside the project and `Video/out.mov`, or replace every Video process's file path. The cat source is credited to [Andrew Kota on Pexels](https://www.pexels.com/video/the-cat-scratched-the-wood-3693815/). The movies are bundled separately in the Video manipulation and Sound and image example archives. Use a build providing Kaboom and Airwindows for the audio branches.

Start playback, then trigger one of the branch-start time-syncs to compare its time control. Watch that interval's progress line while changing an LFO or sequencer. For responsive reverse playback and jumps, use an all-intra format such as HAP and the Video inspector's Direct/Seek playback mode. Buffered forward playback is a different trade-off and can lag when scrubbing.

The feedback graphics also respond to the pointer in the output window. No external controller is required.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
