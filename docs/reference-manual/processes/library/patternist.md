---
layout: default

title: Patternist
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

> The note corresponding to each lane can be changed by clicking on it and dragging.

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


## Workflow tips

**Start simple**: Begin with basic 4-step patterns before experimenting with complex polyrhythms.

**Think in layers**: Build patterns one drum sound at a time rather than trying to program everything at once.

**Use standard drum maps**: Stick to General MIDI drum note numbers for compatibility with most drum software and hardware.

**Test timing**: Verify that your patterns align correctly with the musical timing before building complex arrangements.
