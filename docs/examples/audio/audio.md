---
layout: default

title: Audio
description: "Examples demonstrating audio processing in ossia score"

parent: Examples
has_children: true

permalink: /examples/audio
---

# Audio Examples

These examples demonstrate audio playback, effects processing, and synthesis capabilities in ossia score.

## Synthesis and processing

- [Audio Effects]({{ site.baseurl }}/examples/audio/audiofx.html): granular piano and a Faust bell through filters, delay and reverbs.
- [Faust synthesis]({{ site.baseurl }}/examples/audio/faust-synthesis.html): physical models arranged on an interactive timeline.
- [Granular synthesis approaches]({{ site.baseurl }}/examples/audio/granular.html): continuous and MIDI-driven grains, Faust and short loops.
- [MIDI effects and arpeggiation]({{ site.baseurl }}/examples/audio/midi-fx.html): compare notes before and after arpeggiation and scale mapping.
- [Scala tuning and Wavecycle]({{ site.baseurl }}/examples/audio/scales.html): turn MIDI notes into frequencies from tuning files.
- [Arranging synth patterns with triggers]({{ site.baseurl }}/examples/audio/synths.html): cue bass, bells and drums from a shared arrangement.
- [Sequencing audio effects]({{ site.baseurl }}/examples/audio/more-audiofx.html): switch a drum part between effects over time.
- [Multichannel audio and per-channel controls]({{ site.baseurl }}/examples/audio/polyphony.html): inspect channel counts and list-valued delay controls.
- [Live audio looper]({{ site.baseurl }}/examples/audio/looper.html): record the audio input over drum backing.
- [Pure Data integration]({{ site.baseurl }}/examples/audio/pd-integration.html): automate a noise-generating Pd patch.

See [Audio plug-ins]({{ site.baseurl }}/processes/audio-plugins.html) for host-format requirements, [Audio utilities]({{ site.baseurl }}/processes/audio-utilities.html) for channel routing, and [Audio effects]({{ site.baseurl }}/processes/audio-effects.html) for built-in processing. A plug-in or external patch used by an example must also be available on the computer opening it.
