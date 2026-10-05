---
layout: default
title: Address pattern tools
description: "Compare distributing, collecting, sweeping and regularly transmitting values across address patterns."
parent: Data processing
grand_parent: Examples
permalink: /examples/data/address-tools.html
score: /examples/data/address-tools.score
---

# Address pattern tools

![Four address-processing branches using Pattern applier, Pattern combiner, Spammer and Sweeper]({{ site.baseurl }}/assets/scores/thumbnails/examples-data-address-tools.png)

Compare distributing, collecting, sweeping and regularly transmitting values across address patterns.

{% include try-on-web.html %}

[Download the example]({{ site.baseurl }}/assets/scores/examples/data/address-tools.score)

## Run the four branches

Start playback and inspect the OSC device trees. Arraygen creates ten values with `10 * i`; Pattern applier distributes them to the matching `OSC:/pattern_applier/*` nodes. Matches use lexicographical order, not numeric order: names such as `10` sort before `2`. Check the actual node names before assuming list indices match numeric suffixes.

Pattern combiner gathers `OSC:/pattern_combiner/*` in List mode and sends the result to Value display. Change values on those nodes to observe the collected list. The Sweeper branch distributes its LFO input over `OSC:/sweeper/*` in RandomWalk mode; change its interval or mode to compare traversal patterns.

The remaining LFO feeds Spammer, targeting `OSC_fast:/spammer/*` with a saved delay of approximately 0.994 ms. Spammer sends OSC on its own thread rather than updating the device tree; inspect an OSC receiver to see this branch. Its high message rate is intentional, so do not aim it at an unprepared network endpoint.

## Network settings

The ordinary OSC device listens on UDP 9997 and sends to `127.0.0.1:9996`. OSC_fast listens on 10001 and sends to `127.0.0.1:10002`; use a receiver on 10002 for the fast stream. The saved fast namespace contains `/spammer/0` through `/spammer/10`, so the wildcard matches eleven addresses, despite the patch's explanatory text referring to ten.

No external files are needed. See [pattern matching]({{ site.baseurl }}/in-depth/pattern-matching.html) for alternatives such as `foo{0..9}` and `/{foo,bar}`.
