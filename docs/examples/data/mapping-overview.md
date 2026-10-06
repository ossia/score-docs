---
layout: default
title: Mapping and event utilities
description: "An example showing different techniques for mapping and processing control data"
parent: Data processing
grand_parent: Examples
permalink: /examples/data/mapping-overview.html
score: /examples/data/mapping-overview.score
---

# Mapping and event utilities

![Control graphs showing rate filtering, buffer queues, Flip Flop and Rendezvous]({{ site.baseurl }}/assets/scores/thumbnails/examples-data-mapping-overview.png)

This example demonstrates small building blocks for interactive control: filtering repeated messages, retaining values, making choices and waiting for several inputs. Each experiment can be explored independently and reused in a larger patch.

{% include try-on-web.html %}

[Download the example]({{ site.baseurl }}/assets/scores/examples/data/mapping-overview.score)

## Try it

Start playback in nodal view. The displays make the results visible without external devices or media.

- Compare Rate Limiter, Repeat and Repetition Filter. Try changing the input rhythm to distinguish reducing message frequency, resending a retained value and removing consecutive duplicates.
- Press the Counter's Bang control and watch it wrap. Compare counting events with Flip Flop's alternating state.
- Explore the Buffer queues: release a stored value with Bang, then compare that with viewing a whole buffer as an LED grid. Try locking the buffer to hold its contents.
- Change both Integer controls connected to Rendezvous. It waits for a new event from each input before emitting their ordered pair. Repeating an unchanged integer is filtered out in this example.
- Send different integers to Switch to compare matching cases with Unmatched.
- Trigger the list example and explore Enumerator's modes. Compare stepping through a list with the separate time-based Value delay example.

## Requirements

The Jk Object filter add-on is used for list construction. Other unconnected processes are available for experimentation, but do not contribute to these demonstrations. In particular, the empty Asset Loader does not produce a rendered scene.

The connected examples use local cables. The saved OSC and Local devices do not require an external sender.
