---
layout: default
title: "Value delay"
description: "Multitap delay and feedback for control values"
parent: Processes
grand_parent: Reference
permalink: /processes/value-delay.html
---

# Value delay

Value delay retains the history of **In** and produces **Out**, a list of delayed taps, plus **Mix**, a blend of the current input and first echo. It accepts control values, not audio.

See [Time Chooser]({{ site.baseurl }}/reference/time-chooser.html) for entering absolute or tempo-relative Time values.

- **Count** sets the number of taps.
- **Mode: Ticks** spaces taps by **Length** processing ticks; this depends on execution settings.
- **Mode: Messages** spaces taps by Length received messages rather than elapsed time.
- **Mode: Time** uses the **Time** chooser for spacing; musical durations follow the tempo.
- **Feedback** mixes echoes back into the delay line. **Mix** ranges from current input (0) to first echo (1).
- **Freeze** stops recording new input and repeats the retained delay segment. **Clear** empties history.
- **Smooth** interpolates between recorded values in Time mode.

Numbers, matching vectors and numeric lists can be blended. Other values, such as strings, are delayed without numeric interpolation. Use [Buffer queue]({{ site.baseurl }}/processes/buffer-queue.html) instead when explicit push/pop and output triggers are needed.
