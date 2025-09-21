---
layout: default

title: Value Filter
description: "Toolbox for filtering incoming values"

parent: Processes
grand_parent: Reference

permalink: /processes/value-filter.html
---

# Value Filter

![Value Filter]({{ site.img }}/reference/processes/value-filter.gif "Value Filter in operation")

Value filter is a toolkit for letting incoming values go through according to multiple parameters:

- Is the value repeating or close to the last incoming value? (Noise gate)

For instance, to turn the following input: 

> 0 1 1 1 0 1 0 0 1

Into 

> 0 1 0 1 0 1

or, with some margin:

> 0.1 0.8 1.1 -0.1 -0.08 1.02 

into

> 0.1 0.8 -0.1 1.02

- Is the value close in time to another value?

- Do we want to clamp this value ?

- If clamped, do we want to filter the repetition of the clamped values too? (Repetition filter)