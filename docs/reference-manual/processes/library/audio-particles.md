---
layout: default

title: Audio Particles
description: "Granular synthesis with folder-based sample triggering"

parent: Processes
grand_parent: Reference

permalink: /processes/audio-particles.html
---
# Audio Particles

![Audio Particles]({{ site.img }}/reference/processes/audio-particles.png "Audio Particles")

**Audio particles** randomly selects samples from a folder and scatters their playback across a multichannel **Output** audio port. It can build overlapping textures from percussion hits, field recordings or other short sounds. It plays samples rather than exposing a grain-size or sample-fragment editor.

## Setup and controls

1. Set **Folder** to a directory containing `.wav` files before starting playback.
2. Set **Channels** to the output channel count you need, using at least one channel.
3. Route **Output** to your audio destinations, optionally through [[Matrix]] or [[Audio Effects]].
4. Adjust **Frequency** and **Density** to set the timing and sparsity.

| Control | Range; default | Behavior |
|---|---|---|
| **Folder** | Directory path | Files ending in lowercase `.wav` are decoded when the process is prepared. |
| **Channels** | Control range 0–128; **16** | Number of output channels. Use 1–128 for playback; 0 is not a useful silent mode. |
| **Frequency** | Free numeric range 0.00001–30; **0.2** | Free-mode rate, or a synchronized note interval; see the unit caveat below. |
| **Density** | 0.001–1; **0.7** | Higher values make a scheduled opportunity more likely to start a sound. |

## Synchronized timing

Frequency has the [time chooser]({{ site.baseurl }}/reference/time-chooser.html) interface. Select a straight, dotted or triplet note value to schedule particle opportunities on the musical grid. Density can skip an opportunity, so synchronization does not mean every grid point produces a sound.

**Free-mode unit caveat:** this process still interprets Frequency's free numeric value as **hertz**, although the shared chooser displays time units and its numeric editor is time-oriented. A free value of `0.2` means approximately one opportunity every five seconds, not a 0.2-second period. In synchronized mode the note value correctly represents the interval between opportunities. Do not apply the free-duration interpretation of other time-chooser processes to this control.

Density is compared with an exponentially distributed random draw. It is not a direct percentage probability, and a low setting does not imply near-silence. Opportunities are periodically scheduled; the exponential randomness affects whether a sound is started, not the spacing of the grid itself.

## Playback limits

- Each selected file plays from its start to its end. Only its first audio channel is used, routed to one randomly selected output channel.
- Sounds may overlap, up to **1024 active playheads**. Further opportunities are ignored at that limit.
- At most one new sound starts per processing buffer. Very dense grids can therefore skip opportunities, and this is not a sample-accurate drum sequencer.
- Files are loaded during preparation. There is no live folder watcher in the current implementation; do not expect added files to become immediately available during playback.

Unlike the separately versioned LFO and envelope processes, Audio particles retains its existing process identity. Its synchronized control behavior is updated in place; it has no separately registered “v2” replacement.
