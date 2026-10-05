---
layout: default

title: Device modulation
description: "An example showing how to modulate devices and processes over time"

parent: Automation
grand_parent: Examples

permalink: /examples/automation/modulation.html
score: /examples/automation/automating.score
---

# Device Modulation

<video controls>
    <source src="{{ site.img }}/examples/automation/automating.mp4" type="video/mp4">
</video>

This patch compares two ways of moving the same kind of control data: a direct value cable and the current value of an OSC device parameter.

## Follow the comparison

1. Start playback. The `Display` interval contains `Signal display from cable` and `Signal display from OSC`. The latter reads `OSC:/some_address`; the former receives cables from each source interval.
2. After the initial interval, two LFOs run: one feeds the cable display and the other writes to the OSC address.
3. Trigger the LFO interval's end to switch to `Step`. Compare the displays for these less frequent messages: the cable conveys individual emissions, whereas the address-bound inlet polls the stored device value each tick.
4. Trigger again to reach `Math expression`. Both generators use `noise(pos * a * 10, b * 10, c)`, with slightly different saved parameters. Trigger its end to return to LFO.

The `Display` interval has its own end trigger; keep it running while comparing the source branches. The example makes no audio and needs no media files.

The saved OSC device listens on UDP `0.0.0.0:9997` and sends `/some_address` to `127.0.0.1:9996`. An external receiver on 9996 can monitor the outgoing messages, but is not required for the internal display comparison. Change the remote host and port before using a different application or computer.

[Download this example]({{ site.scores }}{{ page.score }})

## Learn more

- [[Automation]] - Automation curve process reference
- [[Automations]] - In-depth guide to automations
- [[LFO]] - Low-frequency oscillator
- [[Step sequencer]] - Step sequencer process
- [[Working with devices]] - General device setup
