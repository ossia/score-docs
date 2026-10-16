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

An installation's behavior depends on more than the range of its sensor values. Should a held gesture keep sending events? Should a second participant be required before anything happens? Should the last few values remain available after the input moves on? These small, independent patches let you see those choices in plots and displays before using them to control media.

{% include try-on-web.html %}

[Download the example]({{ site.baseurl }}/assets/scores/examples/data/mapping-overview.score)

## Try it

Start playback in nodal view. No external devices or media are needed. Choose one of these questions rather than trying to operate every branch at once.

### How often should the artwork respond?

Compare Rate Limiter, Repeat and Repetition Filter. Change an LFO's frequency and watch the input and output plots. Rate Limiter reduces message frequency, Repeat resends the last value, and Repetition Filter removes consecutive duplicates. A stream of messages and a stream of *changes* are not the same thing.

Press the Bang connected to the wrapping Counter repeatedly and watch it return to the beginning of its range. Compare this with Flip Flop's alternating state. Counting can cycle through a sequence; alternating can make successive actions choose between two responses.

### What should the patch remember?

In the manually triggered Buffer queue, press **Bang** to output a stored value. Compare that with the whole-buffer example, whose recent values appear as an LED grid. Enable **Lock** and watch what stops changing. A history of input can become material for an image or gesture instead of disappearing as soon as the next value arrives.

Trigger the list example and compare Enumerator's modes: stepping through stored values lets you perform their order and pace. Contrast this with the separate Value delay branch, where timing delays the arrival of a signal.

### When are several inputs ready?

Change one Integer feeding Rendezvous and watch it wait; then change the other. It emits an ordered pair only after each input has supplied a fresh event. Repeating an unchanged integer is filtered out in this patch. Try changing one side several times before the other to see why “both have contributed” differs from “use whatever values happen to be present”.

Send 1, 2 and 3 to Switch, then a value outside those cases. Compare the matching outputs with **Unmatched**. This gives distinct responses to recognized choices without treating every other input as one of them.

## Requirements

The list-construction branch requires the Jk Object filter add-on. The connected demonstrations use local cables; no external OSC sender is required. The displays are the intended output, not a rendered audiovisual scene.
