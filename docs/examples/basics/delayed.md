---
layout: default

title: Temporal patching (delayed)
description: "An example showing how to patch audio and messages in time using the delayed mode"

parent: Basics
grand_parent: Examples

permalink: /examples/basics/delayed.html
score: /examples/basics/delayed.score
---

# Temporal Patching (Delayed Mode)

![Delayed Patching Mode]({{ site.img }}/examples/basics/delayed.png "Delayed temporal patching in ossia score")

The Source interval begins at 4 seconds. Bytebeat's `Neurofunk` signal feeds Airwindows TapeFat, whose two controls are automated. TapeFat also has an input binding to `audio:/in/main`, so a configured live input can be mixed with the generated source.

Three delayed audio cables feed effect intervals beginning later:

- **Low**, at 8 seconds: Faust pitchShifter at −12 semitones → VerbThic.
- **Medium**, at 12 seconds: Deckwrecka → ChromeOxide.
- **High**, at 16 seconds: Faust pitchShifter at +12 semitones → NonlinearSpace.

## Listen to the offset

Configure audio output, use a build with Bytebeat, Faust and Airwindows, and start at a low level. No sound file is needed. The delayed cables retain source data so that each later effect can receive it relative to its own start rather than only the source's current block.

Compare the direct Gain branch with the three staggered effects. Source stops automatically at 20 seconds, while effect intervals wait for their end triggers; leave them active to hear delayed material and effect tails, then stop them explicitly. The scenario mix passes through a Faust Limiter to the parent output at `audio:/out/main`.

Compare this with [glutton mode]({{ site.baseurl }}/examples/basics/glutton.html), which connects the currently executing source and sink without these delayed cables. If using a microphone, avoid loudspeaker feedback.

[Download this example]({{ site.scores }}{{ page.score }})

## Learn more

- [[Audio routing]] - How audio propagates through the timeline
- [[Audio plugins]] - VST, Faust, JSFX effect formats
- [[Audio device]] - Configuring audio input/output
