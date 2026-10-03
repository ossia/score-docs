---
layout: default

title: ADSR
description: "Triggered and gated envelopes with tempo-syncable stage durations"

parent: Processes
grand_parent: Reference

permalink: /processes/adsr.html
---
# ADSR

![ADSR]({{ site.img }}/reference/processes/adsr.png "ADSR") 

The **ADSR** generates a control envelope for modulating another process's parameter. Its output is a scalar value, not an audio signal. This page describes the current development-build version (v2).

## Trigger and Hold

- **Trigger** starts a one-shot **attack–decay** envelope: it rises to the peak and decays to zero. Sustain and Release do not extend this one-shot.
- **Hold** starts an **attack–decay–sustain–release** envelope when pressed: it rises, decays to Sustain, and stays there while held. Releasing Hold starts the Release stage.

Trigger and Hold can run together; the output takes the higher envelope value. The process emits the peak reached during each audio processing buffer so that a short envelope is not missed by the control output.

## Stage controls

| Control | Free range | Default |
|---|---|---|
| **Attack** | 0–60 seconds | 0.01 seconds (10 ms) |
| **Decay** | 0–60 seconds | 0.25 seconds |
| **Sustain** | Level 0–1 | 0.5 |
| **Release** | 0–60 seconds | 0.25 seconds |

Attack, Decay and Release use the [time chooser]({{ site.baseurl }}/reference/time-chooser.html). Click their readout to choose a straight, dotted or triplet duration. A note value sets the stage's length at the current tempo; it does not postpone a trigger until the next beat. Zero requests the fastest envelope stage rather than a negative or indefinite duration.

For a rhythmic gated modulation, connect the output to a gain or filter parameter, select synchronized Attack and Release times, and operate Hold. For a short one-shot modulation, use Trigger and set Attack and Decay.

## Older saved processes

**ADSR (old)** remains separately registered for older scores. It retains plain second-based stage knobs and its previous defaults; it is not automatically migrated to the new chooser controls. Insert a current ADSR and explicitly copy the intended durations and connections when updating a score.

![ADSR]({{ site.img }}/reference/processes/adsr.gif "ADSR") 
