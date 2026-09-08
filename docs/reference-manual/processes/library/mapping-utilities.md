---
layout: default

title: Mapping utilities
description: "Mapping utilities"

parent: Processes
grand_parent: Reference

permalink: /processes/mapping-utilities.html
---
# Mapping utilities

![Mapping utilities]({{ site.img }}/reference/processes/mapping-utilities.png "Mapping utilities") 

A collection of small processes for mapping and transforming control values.

## Counter

<!-- TODO screenshot: ![Counter]({{ site.img }}/reference/processes/counter.png "Counter") -->

Counts the messages or impulses it receives and outputs the running count. Useful to drive
steps, indices or triggers from a stream of events.

* **Increase** — each incoming message increments the counter.
* **Output** — emit the current count on demand.
* **Max** — ceiling value for the counter.
* **Mode** — what happens when the count reaches **Max**:
  * **Free** — keep counting past the maximum.
  * **Clip** — stop at the maximum.
  * **Wrap** — wrap back around to the start.
  * **Fold** — bounce back down.

Outputs the current **Count**, and fires a **Ceiling** event when the maximum is reached.

---

More reference is on its way. Feel more than welcome to ask for help on the [ossia.io forum](https://forum.ossia.io) or send a message on [ossia score Gitter channel](https://gitter.im/ossia/score) where you will most likely find a handful of *score* users and developers.