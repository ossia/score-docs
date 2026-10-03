---
layout: default
title: "Rendezvous"
description: "Collect one fresh value from every inlet before emitting a list"
parent: Processes
grand_parent: Reference
permalink: /processes/rendezvous.html
---

# Rendezvous

Rendezvous waits until every input has received a fresh event, then sends one ordered list on **Output** and starts a new collection cycle. List order follows inlet order, not arrival time.

Set **Input count** to create the required inputs. **Keep first** retains the first arrival on each inlet while waiting; with it off, later arrivals replace that inlet’s pending value. **Waiting** reports how many inlets still need a fresh event. **Clear** discards a partial collection; it takes precedence over arrivals in that processing tick. Changing Input count also clears the partial cycle.

For example, join independently arriving position and confidence messages before passing a complete pair downstream. Rendezvous is not a timestamp aligner and does not queue every intermediate message. For FIFO storage use [Buffer queue]({{ site.baseurl }}/processes/buffer-queue.html).
