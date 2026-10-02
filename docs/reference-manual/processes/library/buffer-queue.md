---
layout: default

title: Buffer queue
description: "Accumulate incoming messages and output them as a buffer"

parent: Processes
grand_parent: Reference

permalink: /processes/buffer-queue.html
---
# Buffer queue

<!-- TODO screenshot: ![Buffer queue]({{ site.img }}/reference/processes/buffer-queue.png "Buffer queue") -->

Accumulates the values it receives over time and exposes them as a buffer. Useful to
build a history of recent values, to batch a stream of messages, or to turn a sequence of
single values into a list.

## Input

The value to push into the queue.

## Max length

Maximum number of elements kept. When the queue is full, the oldest elements are dropped
as new ones arrive (FIFO).

## Mode / Data

* **Mode** — how the queue behaves when emitting (e.g. emit on each input vs. on demand).
* **Data** — how the stored values are formatted on the output.

## Clear / Lock

* **Clear** — empty the queue.
* **Lock** — freeze the queue so new inputs are ignored.

## Output

The accumulated values as an `ossia::value` (typically a list).
