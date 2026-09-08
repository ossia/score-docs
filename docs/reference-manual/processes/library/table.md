---
layout: default

title: Table
description: "Store and recall arbitrary data in 1D, 2D or N-dimensional tables"

parent: Processes
grand_parent: Reference

permalink: /processes/table.html
---
# Table

<!-- TODO screenshot: ![Table]({{ site.img }}/reference/processes/table.png "Table") -->

Stores arbitrary values in an addressable table and lets you read, write, resize and clear
them at runtime. Tables are handy as scratch memory, lookup tables, step sequencers or
small datasets driven by other processes.

Three variants are available:

* **Table** — N-dimensional table.
* **Table (1D)** — one-dimensional table (a simple list).
* **Table (2D)** — two-dimensional table (a grid).

## Writing

* **Set cell / pair** — write a value at a given index (or key/value pair).
* **Fill** — fill the whole table with a value.
* **Resize / Dimensions** — change the table size or shape.
* **Clear** — empty the table.

## Reading

* **Read** — request the value(s) at an index, emitted on the output.

## Lock / Preserve / Dump

* **Lock** — prevent further writes.
* **Preserve** — keep the table content across resizes when possible.
* **Dump** — emit the full table content.

## Outputs

* **Output** — the value(s) read from the table.
* **Shape** — the current dimensions.
* **Size** — the total number of elements.

See also [Buffer queue](buffer-queue.html) for FIFO-style accumulation.
