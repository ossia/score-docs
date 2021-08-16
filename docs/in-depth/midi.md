---
layout: default

title: "MIDI support"
description: "How to use MIDI software, hardware, and data"

parent: In depth

permalink: /in-depth/midi.html
---

# MIDI communication

MIDI communication is provided by two kind of devices, available from the [[Device explorer]]:
* [[MIDI input device]] can be used to plug a MIDI keyboard to *score*.
* [[MIDI output device]] can be used to send MIDI data from *score* to an external sequencer.

# MIDI processes

MIDI processes can write to a specific channel or directly to the root device
through addresses. Simply drop either the MIDI node corresponding to the MIDI device, or the channel, to the port you want to connect to.

The most important processes are:
- [[Piano roll]]
- [[Patternist]]
- [[MIDI utilities]]

# MIDI file support

* The [[Piano roll]] process supports MIDI files.

Simply drag'n'drop a MIDI file in the score, either on a scenario or on the interval, from the user library or from your file explorer !

# MIDI processing

* See [[MIDI utilities]] for a list of processes that can alter MIDI data: arpeggiator, etc.
* You can write your custom MIDI processors, for instance with the [[Javascript]] or the [[C++ JIT]] process.