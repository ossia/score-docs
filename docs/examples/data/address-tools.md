---
layout: default
title: Address pattern tools
description: "An example showing how to work with groups of device addresses"
parent: Data processing
grand_parent: Examples
permalink: /examples/data/address-tools.html
score: /examples/data/address-tools.score
---

# Address pattern tools

![Four address-processing branches using Pattern applier, Pattern combiner, Spammer and Sweeper]({{ site.baseurl }}/assets/scores/thumbnails/examples-data-address-tools.png)

This example demonstrates controlling groups of addresses with patterns. Instead of connecting each parameter separately, you can distribute a list, collect values or move a control signal across a set of destinations.

{% include try-on-web.html %}

[Download the example]({{ site.baseurl }}/assets/scores/examples/data/address-tools.score)

## Try it

Start playback and inspect the OSC device trees.

- Use Pattern applier to distribute generated values over several addresses. Change the source list and compare the matching parameters.
- Change values under `OSC:/pattern_combiner/*` and watch Pattern combiner collect them into a list.
- Compare Sweeper's modes and interval settings to change how a control signal moves among destinations.
- Observe Spammer with an external OSC receiver. It transmits on its own thread rather than updating the device tree, which is useful when regular transmission is needed independently of ordinary device updates.

Pattern matches use lexicographical order, not numeric order: a name such as `10` sorts before `2`. Check the node names before assuming that list indices correspond to numeric suffixes.

Spammer is saved with a delay of about one millisecond. Its high message rate is intentional; do not direct it at an unprepared network endpoint.

## Network settings

The ordinary OSC device listens on UDP 9997 and sends to `127.0.0.1:9996`. OSC_fast listens on 10001 and sends to `127.0.0.1:10002`; use a receiver on 10002 for the fast stream. The saved fast namespace contains `/spammer/0` through `/spammer/10`, so the wildcard matches eleven addresses, despite the patch's explanatory text referring to ten.

No external files are needed. See [pattern matching]({{ site.baseurl }}/in-depth/pattern-matching.html) for alternatives such as `foo{0..9}` and `/{foo,bar}`.
