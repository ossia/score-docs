---
layout: default

title: MIDI pattern sequencer
description: "Send MIDI messages according to rhythmic patterns"

parent: Processes
grand_parent: Reference

permalink: /processes/patternist.html
---

# MIDI Pattern Sequencer

![Patternist]({{ site.img }}/reference/processes/patternist.png "MIDI Pattern Sequencer Example")

A classic MIDI pattern sequencer.
On the left of the sequencer, there is the actual note of the lane with a corresponding number.
Each step correspond to a measure. If the step is activated (_yellow_), the note will be played.

This process can have multiple distinct patterns which can be switched.

## Channel

On which MIDI channel the output goes.

## Current Pattern

The index of the current pattern.

## Lanes

Each lane corresponds to one MIDI note.

## Step

How many steps there are in a pattern.
The minimal amount of steps is 4 and the maximum is 32.

## Rate

To which musical declination corresponds a step: quarter note, 16th note, etc.