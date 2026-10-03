---
layout: default
title: "Buffer queue"
description: "Collect messages and choose when to release stored values"
parent: Processes
grand_parent: Reference
permalink: /processes/buffer-queue.html
---

# Buffer queue

Buffer queue stores incoming **Input** messages in a bounded queue. It is a control-value buffer, not an audio delay. “Queue” and “Buffer queue” refer to this same process.

## Controls and output

- **Max length** sets capacity. When full, a new message replaces the oldest stored value.
- **Data** chooses **Oldest**, **Newest**, or **Whole buffer** (an ordered list) on **Output**.
- **Mode** chooses **Every tick**, **On input**, **On change**, **When full**, **On input, when full**, **On change, when full**, **On bang**, or **On bang, pop oldest**.
- **Bang** requests output in every mode. **Pop** removes what was sent: one selected value, or the entire buffer for Whole buffer. The special On bang, pop oldest mode removes the oldest value after each output even with Pop off.
- Hold **Clear** to empty the buffer and discard arrivals. An impulse clears it for one processing tick. **Lock** prevents new messages being queued without preventing output.

On input reacts to arrivals even when Clear or Lock discards them. On change reacts to queue additions and clearing, not to the removal caused by Pop. Every tick and When full can therefore repeatedly send stored data without new input.

For batches, choose Whole buffer, On change, when full, and Pop. For manual playback, choose Oldest and On bang, pop oldest, then connect a trigger to Bang. See [Value delay]({{ site.baseurl }}/processes/value-delay.html) for delayed echoes rather than explicit queue management.
