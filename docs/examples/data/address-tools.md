---
layout: default
title: Address pattern tools
description: "Distribute gestures across groups of parameters, gather their values and explore a moving control pattern."
parent: Data processing
grand_parent: Examples
permalink: /examples/data/address-tools.html
score: /examples/data/address-tools.score
---

# Address pattern tools

![Four address-processing branches using Pattern applier, Pattern combiner, Spammer and Sweeper]({{ site.baseurl }}/assets/scores/thumbnails/examples-data-address-tools.png)

A bank of lights or an array of sensors is easier to compose as a group than as a collection of individual connections. This score uses OSC parameters as stand-ins: distribute different values across the group, gather them into one list, or move a changing signal from destination to destination. No physical lights or sensors are required to inspect the pattern.

{% include try-on-web.html %}

[Download the example]({{ site.baseurl }}/assets/scores/examples/data/address-tools.score)

## Try it

Start playback and inspect the OSC device trees. The patterns select groups of parameters by name, so the same gesture can later be adapted to a larger installation.

- In the Pattern applier branch, change Arraygen's expression from `10 * i` to `5 * i`. Compare the matched values: their spacing becomes smaller while the destinations stay the same. This is a way to compose a graded group rather than send an identical value everywhere.
- Change several parameters in the Pattern combiner group and watch the collected list. Gathering values makes it possible to treat multiple sensors as one input for further processing.
- Compare Sweeper's modes, then lengthen its interval. Watch how the destination changes and how long each step lasts. Adapted to lights, this would distinguish the path of a chase from its pace.
- With an OSC receiver connected, observe Spammer's regular transmissions. It sends on a dedicated thread rather than updating the device tree, so use the receiver, not the tree, to inspect this branch.

Pattern matches use lexicographical order: a name such as `10` comes before `2`. Check the ordering before assigning spatial meaning to list positions, or a smooth sequence of values may visit destinations in an unexpected order.

Spammer is saved with a delay of about one millisecond. Its high message rate is intentional; do not direct it at an unprepared endpoint. Increase the delay before adapting it to a slower receiver.

## Network settings

The ordinary OSC device listens on UDP 9997 and sends to `127.0.0.1:9996`. OSC_fast listens on 10001 and sends to `127.0.0.1:10002`; use a receiver on 10002 for the fast stream. The fast pattern matches eleven destinations, so account for messages to the whole group when choosing a transmission rate.

No external files are needed. See [pattern matching]({{ site.baseurl }}/in-depth/pattern-matching.html) for alternatives such as `foo{0..9}` and `/{foo,bar}`.
