---
layout: default

title: Device modulation
description: "Compare pulses, repeating steps and wandering noise, then see how a direct connection differs from reading a device parameter."

parent: Automation
grand_parent: Examples

permalink: /examples/automation/modulation.html
score: /examples/automation/automating.score
---

# Device Modulation

<video controls>
    <source src="{{ site.img }}/examples/automation/automating.mp4" type="video/mp4">
</video>

Give a parameter a repeating pulse, a stepped phrase or an irregular drift without drawing every change by hand. This score lets you watch those movements before adapting one to a sound control, a light or another application.

## Choose the motion and its delivery

LFOs provide periodic movement, step sequences repeat a set of levels, and noise expressions produce less predictable variation. Interactive ends let you stay with one source, then cue the next.

Two displays compare direct cables with an OSC device parameter. A cable carries individual emissions; the address-bound display reads the parameter's stored value each tick. The difference is easiest to see when a source sends values only occasionally. This matters when a destination needs a continuous current value rather than a sequence of isolated updates.

## Try it

1. Start playback and watch the displays during `LFO`. Change the rate or waveform of each source to compare a smooth cycle with a more abrupt pulse.
2. Trigger the LFO interval's end to reach `Step`. Edit a few values in both step sequences, then watch what each display does between emissions. Keep the sequences alike when comparing the two delivery methods.
3. Trigger again to reach `Math expression`. Vary the noise parameters and compare its irregular motion with the repeating sections. The two noise generators have slightly different saved settings, so matching curves are not expected.
4. Trigger the expression interval's end to return to LFO. Pick a movement for an imagined passage: a regular pulse, a sequence of lighting levels or a wandering filter control. Connecting that destination would be an adaptation; the saved example visualizes data and makes no sound.

Keep `Display` running while comparing the branches; it has its own end trigger. No media files or external receiver are needed.

To try the OSC output in another application, configure its receiver for UDP port `9996` on the same computer. The saved device listens on port `9997` and sends `/some_address` to `127.0.0.1:9996`. Change the destination host and port for another computer, and allow the connection through any firewall. The internal comparison does not require a network round trip.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

## Learn more

- [[Automation]] - Automation curve process reference
- [[Automations]] - In-depth guide to automations
- [[LFO]] - Low-frequency oscillator
- [[Step sequencer]] - Step sequencer process
- [[Working with devices]] - General device setup
