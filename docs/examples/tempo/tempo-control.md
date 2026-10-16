---
layout: default

title: Tempo manipulation
description: "Hear a drum loop change speed with and without changing pitch, layer different metres, and make tempo follow a control signal."

parent: Tempo Examples
grand_parent: Examples

permalink: /examples/tempo/tempo-control.html
score: /examples/tempo/tempo.zip
---

# Tempo Manipulation

![Metronome layers followed by re-pitching, time-stretching and speed-control sections]({{ site.img }}/examples/tempo/tempo.png "Tempo manipulation in ossia score")

Speed up a recorded rhythm and decide whether its pitch should rise with it. This score compares re-pitching with time-stretching, then lets a changing control signal drive the tempo. Before the loop begins, two metronomes show how different metres can coexist inside a shared timeline.

## Treat timing as musical material

A Tempo curve shapes the speed of its interval. The sound file's stretching mode determines how the recording responds, so a similar timing gesture can produce either a pitch sweep or a duration change with pitch preserved. A later section replaces the drawn tempo with an LFO-driven value: the timing itself becomes a modulated parameter.

These are useful contrasts for a performance transition. You might want the audible lift of re-pitching in one passage and a steadier pitch in another, or let one layer retain its metre while the surrounding music changes.

## Try it

Open the ZIP directly in score; the drum recording is included. Configure audio output at a low level. No external controller is required.

1. Start playback and compare `Parent signature` with `Custom signature`. One metronome follows the parent's changes; the other retains its local 4/4 during the parent's 3/4 section. Follow the signature tracks to connect the changing accents with the two metres.
2. Listen to `Re-pitching`, then `Time-stretching`. Both use the same recording, but different stretching modes. Compare what happens to pitch during the tempo changes, not just how quickly the drum hits arrive.
3. Reshape one Tempo curve to make an acceleration gentler or more abrupt. Listen to how the timing gesture affects the phrase before changing the sound file's stretching mode for another comparison.
4. In `Speed`, the LFO drives tempo between 20 and 120 BPM. Change its rate to compare a slow rise and fall with rapid fluctuations. The connected BPM input takes precedence over the drawn tempo curve.
5. In `Free scrubbing`, select the Play tool with **P** and drag in the score background. Use your hand to explore playback position instead of accepting the forward motion of the timeline.

The loop's displayed process name differs from the bundled recording's name; use the file inspector if you need to replace it. The LFO interval has an interactive end, so stop the transport when finished.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

## Learn more

- [[Tempo]] - Tempo process reference
- [[Musical metrics]] - Time signatures, quantization, polyrhythm
- [[Scenario]] - Timeline container and timing
