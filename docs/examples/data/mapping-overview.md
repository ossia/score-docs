---
layout: default
title: Mapping and event utilities
description: "Choose how an interactive piece responds to events: filter repetitions, remember values, alternate actions or wait for two inputs."
parent: Data processing
grand_parent: Examples
permalink: /examples/data/mapping-overview.html
score: /examples/data/mapping-overview.score
---

# Mapping and event utilities

![Control graphs showing rate filtering, buffer queues, Flip Flop and Rendezvous]({{ site.baseurl }}/assets/scores/thumbnails/examples-data-mapping-overview.png)

An installation's behavior depends on more than the range of its sensor values. Should a held control keep sending events? Should a second participant be required before anything happens? Should the last few values remain available after the input moves on? Each small, independent patch answers one of these questions in plots and displays.

{% include try-on-web.html %}

[Download the example]({{ site.baseurl }}/assets/scores/examples/data/mapping-overview.score)

## Try it

Start playback in nodal view. No external devices or media are needed. Work through one question at a time instead of operating every branch at once.

### How often should the artwork respond?

Look at Rate Limiter, Repeat and Repetition Filter. Change an LFO's frequency and watch the input and output plots. Rate Limiter reduces message frequency, Repeat resends the last value, and Repetition Filter removes consecutive duplicates. A stream of messages and a stream of *changes* are not the same thing.

Press the Bang connected to the wrapping Counter repeatedly and watch it return to the beginning of its range. Flip Flop instead alternates between two states, so successive presses choose between two responses.

### What should the patch remember?

In the manually triggered Buffer queue, press **Bang** to output a stored value. The whole-buffer example instead shows all its recent values as an LED grid. Enable **Lock** and watch what stops changing.

Trigger the list example and switch Enumerator's modes: each steps through the stored values in a different order, at the pace you trigger it. The separate Value delay branch only delays the arrival of a signal.

### When are several inputs ready?

Change one Integer feeding Rendezvous and watch it wait; then change the other. It emits an ordered pair only after each input has supplied a fresh event. Repeating an unchanged integer is filtered out in this patch. Try changing one side several times before the other to see why “both have contributed” differs from “use whatever values happen to be present”.

Send 1, 2 and 3 to Switch, then a value outside those cases. Each recognized value goes to its own output; anything else goes to **Unmatched**.

## Requirements

The list-construction branch requires the Jk Object filter add-on. The connected demonstrations use local cables; no external OSC sender is required. The displays are the intended output, not a rendered audiovisual scene.
