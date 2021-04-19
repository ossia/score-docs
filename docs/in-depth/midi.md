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

# MIDI file support

* The [piano roll]({{ site.baseurl }}/processes/midi.html#piano-roll) process supports MIDI files.

> Simply drag'n'drop a MIDI file in the score !

# MIDI processing

* See [[MIDI processes]] for a list of processes that can alter MIDI data: arpeggiator, etc.
* You can write your custom MIDI processors, for instance with the [[Javascript]] or the [[C++ JIT]] process.