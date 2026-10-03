---
layout: default

title: Rate Limiter
description: "Only outputs the incoming value according to a certain rate or quantification"

parent: Processes
grand_parent: Reference

permalink: /processes/rate-limiter.html
---
# Rate Limiter

![Rate Limiter]({{ site.img }}/reference/processes/rate-limiter.png "Earlier Rate Limiter controls")

The **Rate Limiter** reduces a stream of control messages arriving at **in**, forwarding selected values through **out**. Use it between a fast sensor or [[LFO]] and a destination that should receive fewer updates.

This page describes the current development-build version (v2).

## Interval

**Interval** uses the [time chooser]({{ site.baseurl }}/reference/time-chooser.html): choose a free duration or straight, dotted or triplet note value. The free range is **0–10 seconds**, default **0.01 seconds (10 ms)**. Numeric entry is in seconds.

## Mode and Send latest

**Mode** offers **Limit** (default) and **Debounce**. **Send latest** is on by default and affects Limit only.

| Setting | Behavior |
|---|---|
| Limit, free time, Send latest on | The first value passes immediately. Values arriving too soon replace a held value; the latest held value is sent when the interval expires. |
| Limit, free time, Send latest off | The first eligible value passes immediately; values arriving before the interval expires are discarded. |
| Limit, synchronized, Send latest on | Hold the latest arriving value and send it on the next musical grid point. No value is emitted on an empty step. |
| Limit, synchronized, Send latest off | The first value in each grid step passes at its arrival time; later values in that step are discarded. This limits the rate but does **not** move the first value onto the beat. |
| Debounce | Each input restarts a quiet-time countdown. Send only the latest value after no new input has arrived for Interval. A synchronized Interval gives a tempo-derived duration, not a grid-aligned output time. |

For a continuously moving fader, leave **Send latest** on so that its final position is not lost when movement stops. Use **Debounce** for an action that should happen only once movement settles. A zero free interval forwards every value without waiting.

Pending values are cleared on transport resets or discontinuities and when switching Mode, rather than being replayed later.

## Older saved processes

**Rate Limiter (old)** remains loadable with its separate quantification and millisecond controls. It is not automatically replaced with v2. Add a current Rate Limiter to use Interval and Send latest, then reconnect its ports and set its timing explicitly.