---
layout: default

title: Temporal patching (glutton)
description: "An example showing how to patch audio and messages in time using the glutton mode"

parent: Basics
grand_parent: Examples

permalink: /examples/basics/glutton.html
score: /examples/basics/glutton.score
---

# Temporal Patching (Glutton Mode)

![Glutton Patching Mode]({{ site.img }}/examples/basics/glutton.png "Glutton temporal patching in ossia score")

The Source interval starts at 4 seconds, with Bytebeat's `Neurofunk` feeding Airwindows TapeFat and a direct Gain branch. TapeFat also reads `audio:/in/main`; live input is optional because the Bytebeat already supplies audio. Two looping automations vary TapeFat's controls.

The same output feeds three effect intervals with ordinary, non-delayed cables:

- **Low**, starting at 6 seconds: Faust pitchShifter at −24 semitones → VerbThic.
- **Medium**, starting at 8 seconds: Deckwrecka → ChromeOxide.
- **High**, starting at 10 seconds: Faust pitchShifter at +24 semitones → NonlinearSpace.

## Compare active intervals

Configure audio output and start playback at a low level. Bytebeat, Faust and Airwindows support are required; no sample file or external controller is needed.

Listen as each effect starts processing the source that is currently running. Trigger Source's end and compare the remaining effects' tails. Unlike the [delayed example]({{ site.baseurl }}/examples/basics/delayed.html), these cables do not replay the source from its earlier start for each later sink.

All four interval ends are interactive, so their drawn end positions do not automatically stop them. The dry Gain and effect outputs enter the scenario mix, which passes through a Faust Limiter to `audio:/out/main`. Use headphones if adding a microphone to the saved audio input binding.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

## Learn more

- [[Audio routing]] - How audio propagates through the timeline
- [[Audio plugins]] - VST, Faust, JSFX effect formats
- [[Audio device]] - Configuring audio input/output
