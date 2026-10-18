---
layout: default

title: Device modulation
description: "Drive parameters with pulses, repeating steps and wandering noise, then see how a direct connection differs from reading a device parameter."

parent: Automation
grand_parent: Examples

permalink: /examples/automation/modulation.html
score: /examples/automation/automating.score
---

# Device Modulation

<video controls>
    <source src="{{ site.img }}/examples/automation/automating.mp4" type="video/mp4">
</video>

Give a parameter a repeating pulse, a stepped phrase or an irregular drift without drawing every change by hand. The score only displays the values; connect one to a sound, a light or another application to use it.

## Choose the motion and its delivery

LFOs provide periodic movement, step sequences repeat a set of levels, and noise expressions produce less predictable variation. Interactive ends let you stay with one source, then cue the next.

Two displays show the same source through a direct cable and through an OSC device parameter. A cable carries individual emissions; the address-bound display reads the parameter's stored value each tick. The difference is easiest to see when a source sends values only occasionally. Use the parameter when a destination needs a continuous current value instead of isolated updates.

## Try it

1. Start playback and watch the displays during `LFO`. Change the rate or waveform of each source: a sine gives a smooth cycle, a square an abrupt pulse.
2. Trigger the LFO interval's end to reach `Step`. Edit a few values in both step sequences, keeping them alike, then watch what each display does between emissions.
3. Trigger again to reach `Math expression` and vary the noise parameters. The two noise generators have slightly different saved settings, so their curves do not match.
4. Trigger the expression interval's end to return to LFO. The saved example only visualizes data and makes no sound.

Keep `Display` running while switching sections; it has its own end trigger. No media files or external receiver are needed.

To try the OSC output in another application, configure its receiver for UDP port `9996` on the same computer. The saved device listens on port `9997` and sends `/some_address` to `127.0.0.1:9996`. Change the destination host and port for another computer, and allow the connection through any firewall. The internal displays do not require a network round trip.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

## Learn more

- [[Automation]] - Automation curve process reference
- [[Automations]] - In-depth guide to automations
- [[LFO]] - Low-frequency oscillator
- [[Step sequencer]] - Step sequencer process
- [[Working with devices]] - General device setup
