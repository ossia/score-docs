---
layout: default
title: "Point Tracker"
description: "Associate changing point detections with persistent identities"
parent: Processes
grand_parent: Reference
permalink: /processes/point-tracker.html
---

# Point Tracker

**Point Tracker 2D** and **Point Tracker 3D** associate detections across frames, smooth their motion and maintain identities through short occlusions. They do not detect objects in an image: feed them point detections from computer vision, OSC or a script.

## Input and output

**Points** accepts a list of vectors, coordinate sublists, or maps containing a position and optional confidence. A flat numeric list is grouped by two coordinates in 2D or three in 3D. A third component of a 2D detection means confidence; a fourth component of a 3D detection means confidence. Use consistent coordinate units: 3D positions are not automatically normalized.

**Tracks** emits records containing `id`, `slot`, `state`, `creation_time`, `age`, `time_since_seen`, `position`, `position_raw`, `velocity`, `confidence`, `provisional` and `reacquired`. **Positions**, **Ids** and **Count** provide simpler views; **Entered**, **Confirmed**, **Exited** and **Revived** report lifecycle events. Tracks can connect directly to [Entity To MIDI]({{ site.baseurl }}/processes/entity-to-midi.html).

## Settings workflow

1. Tune **Motion Gate**, **Max Speed**, **Position Noise** and **Motion Noise** to the units and plausible motion of the source.
2. Set **High Confidence**, **Low Confidence** and **New Track Confidence**. Two-Stage Association can use lower-confidence detections to sustain existing tracks without creating new ones.
3. Balance **Confirm Time**, **Confirm Hits** and **Confirm Window** against onset latency. **Emit Unconfirmed** exposes provisional tracks immediately; disable it for a more conservative output.
4. Set **Coast Time** for temporary disappearance and **Revive Time** for reacquisition. **Smooth**, **Min Cutoff**, **Beta**, **Prediction Lead** and **Output Deadband** balance jitter against response time.
5. For a fixed voice bank, set **Slot Count**, **Allocation**, **Steal Policy** and **Hold Time**. Slots are reusable; an id identifies a track, not a permanent hardware channel. Choose compact or slot-oriented **Data Format** and **Order By** as needed.

**Reset IDs** forgets all tracks and restarts numbering. Identity can still become ambiguous when objects cross or detections disappear; tune against real input rather than treating tracking as guaranteed recognition.
