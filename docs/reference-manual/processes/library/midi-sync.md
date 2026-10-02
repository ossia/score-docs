---
layout: default

title: MIDI Sync Out
description: "Send MIDI Clock, Start/Stop and MIDI Time Code to synchronise external gear"

parent: Processes
grand_parent: Reference

permalink: /processes/midi-sync.html
---
# MIDI Sync Out

<!-- TODO screenshot: ![MIDI Sync Out]({{ site.img }}/reference/processes/midi-sync.png "MIDI Sync Out") -->

Emits MIDI synchronisation messages so external instruments, sequencers and effects can
follow score's transport. Connect the output to a MIDI device.

## MIDI Clock

Sends 24-ppqn MIDI Clock pulses. The mode control selects whether and how clock is
emitted.

## MIDI Start/Stop

Sends transport Start, Continue and Stop messages.

## MIDI TimeCode

Sends MIDI Time Code (MTC). Use this for frame-accurate synchronisation with video gear.

## MTC offset

Time offset applied to the emitted MTC.

## MTC framerate

Frame rate used for MTC (24 / 25 / 29.97 / 30 fps).

## Output

A MIDI bus carrying the selected synchronisation messages.
