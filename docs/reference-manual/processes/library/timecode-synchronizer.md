---
layout: default

title: Timecode Synchronizer
description: "Follow an external position or speed while limiting small synchronization jumps"
parent: Processes
grand_parent: Reference
permalink: /processes/timecode-synchronizer.html
---

# Timecode Synchronizer

The **Timecode Synchronizer**, in **Timing/Control**, converts numeric timecode and speed inputs into a smoothed speed signal. Small position differences are corrected by changing speed; sufficiently large differences produce a timecode correction.

It does not decode an audio LTC signal or MIDI messages itself, and adding it does not automatically synchronize score's transport. Connect a decoder or numeric source upstream, and route its outputs to the appropriate playback controls downstream.

## Inputs and outputs

| Port | Meaning |
| --- | --- |
| Input **Timecode** | External position, in the units selected by **Input format**. |
| Input **Speed** | Playback speed ratio: `1` is normal speed, `0` is stopped, negative values indicate reverse motion. |
| Input **Validity** | Whether the external timecode can be used. Its interaction with Speed depends on **Sync Mode**. |
| Output **Speed** | Smoothed, corrected playback speed. |
| Output **Tempo** | Output speed multiplied by 120; this is a fixed reference conversion, not a measurement of the source's musical tempo. |
| Output **Timecode** | Position correction at initialization or when a position jump exceeds the threshold; not a continuous position readout. |
| Output **Estimated Speed** | Speed derived from timecode history in Timecode mode; do not treat it as a second corrected-speed output in every mode. |

**Input format** and **Output format** independently select Seconds, Milliseconds, Microseconds, Nanoseconds or Flicks. One second is 705,600,000 flicks. The position error and **Jump threshold** are evaluated in seconds regardless of the chosen external units.

## Choose a synchronization mode

- **Both** follows Speed and corrects drift against valid Timecode. When Validity is false, a Speed strictly between `-10` and `10` is still accepted; loss of valid timecode alone therefore does not necessarily trigger **If no sync**.
- **Speed** follows Speed while Validity is true, without position correction.
- **Timecode** estimates speed from changes in Timecode while Validity is true. **Speed estimation window** sets the history duration in seconds; **Speed filter strength** smooths that estimate.

## Correction controls

| Control | Effect |
| --- | --- |
| **Jump threshold** | A position error larger than this value causes a position correction instead of only a speed adjustment. |
| **Max speed correction** | Limits correction relative to the magnitude of the base speed. At zero base speed this proportional correction limit is also zero. |
| **Correction time constant** | Divides the position error when computing the desired speed adjustment; larger values make correction gentler. |
| **Smoothing factor** | Blends the previous speed with the new target on each processing tick. Larger values retain more of the previous speed. |

Smoothing is tick-based, so do not interpret its factor as a fixed duration. Start with the default controls, then tune against the cadence and noise of the incoming position updates.

## Loss of synchronization

**If no sync** applies when the selected mode cannot use its inputs:

- **Stall** keeps running until **Dead reckoning timeout** elapses, then targets zero speed.
- **Zero** immediately targets zero speed.
- **KeepSpeed** retains the previous target indefinitely.

The Speed output still passes through smoothing. Even Zero does not necessarily make the emitted speed zero in the same tick.

## Typical connection

```text
[External position / speed / validity]
                 |
       [Timecode Synchronizer]
          |              |
        Speed        Timecode correction
          |              |
       [Playback controls of the target]
```

Choose the same time units on both ends of a position connection. Confirm how the target handles reverse speed and seek messages before using the patch in performance.

Source reference: `score-plugin-avnd/CMakeLists.txt` registers `ao::TimecodeSynchronizer`; its controls and algorithm are defined in `3rdparty/avendish/examples/Advanced/Utilities/TimecodeSynchronizer.hpp`.
