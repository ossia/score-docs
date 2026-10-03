---
layout: default
title: XWax DVS
description: "Decode stereo digital-vinyl timecode into position, signed speed and status"
parent: Processes
grand_parent: Reference
permalink: /processes/xwax-dvs.html
---

# XWax DVS

**XWax DVS** is a registered process in the optional LTC add-on. It decodes stereo digital-vinyl timecode using xwax, exposing position and playback speed as control values. It is not an audio player and does not itself slave score's transport.

## Input and controls

Connect the two channels of the timecode signal to the **Timecode** audio input. The decoder uses the first two channels; fewer than two channels cannot produce a valid position. Keep this signal separate from program audio.

| Control | Meaning |
|---|---|
| Vinyl Type | Serato 2a, 2b or CD; Traktor A/B, MK2 A/B or MK2 CD; MixVibes V2 or 7inch; Pioneer A/B. Match the actual timecode media. |
| Speed | Reference platter speed: RPM 33 or RPM 45. This is an input setting, distinct from the measured Speed outlet. |
| Pitch Filter | Kalman or AlphaBeta pitch estimator. |
| Lead-in | Seconds subtracted from decoded position, 0–60; default 0. |
| Tempo | Reference tempo in BPM, 0–300; default 120. |
| Output Format | Seconds (default), Milliseconds, Microseconds, Nanoseconds or Flicks. Applies to both position outlets. |

## Outputs

| Output | Meaning |
|---|---|
| Timecode | Floating-point position after subtracting **Lead-in**, in the selected units. Can be negative before the lead-in point. |
| Raw timecode | Integer position **without Lead-in subtraction**, but with the same output-unit conversion. |
| Speed | Signed speed ratio: approximately `1` for normal forward playback and `-1` for normal reverse playback. It is not pitch deviation from 1. |
| Tempo | **Speed × reference Tempo**; reverse playback can produce negative values. |
| Quality | Heuristic in the range 0–1, described below. |
| Valid | Whether an absolute position was decoded. |

### Raw timecode is not undecoded data

The bundled decoder reports normalized milliseconds. The process first divides by 1000, then converts to the selected units for **both** outlets. **Raw timecode** has an integer port, so the default Seconds format truncates fractional seconds. Milliseconds preserve the decoder's millisecond resolution while the value fits the integer range; Microseconds, Nanoseconds and Flicks can exceed that range quickly. Prefer the floating-point **Timecode** outlet with **Lead-in** set to 0 when you need an unshifted fractional position.

One second equals 705600000 flicks. Changing units does not increase the underlying decoder's position resolution.

### Validity and quality

If no position is available, **Timecode** becomes 0, **Raw timecode** becomes -1 and **Valid** becomes false. Speed can still be reported when position decoding fails; do not use it as a substitute for **Valid**.

**Quality** averages a position-change/pitch-stability score over up to 32 processing calls, not 32 milliseconds. It is not calibrated decoder confidence. In particular, exactly unchanged pitch contributes zero to its pitch-quality component, so a steady signal need not yield 1. Use **Valid**, observed motion and your receiving application's requirements together rather than relying on a universal quality threshold.

For linear SMPTE timecode rather than DVS media, use [[LTC Input]].
