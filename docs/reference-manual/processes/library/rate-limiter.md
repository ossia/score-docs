---
layout: default

title: Rate Limiter
description: "Only outputs the incoming value according to a certain rate or quantification"

parent: Processes
grand_parent: Reference

permalink: /processes/rate-limiter.html
---
# Rate Limiter

![Rate Limiter]({{ site.img }}/reference/processes/rate-limiter.png "Noise from LFO output every 300 miliseconds")

The rate limiter can be used to synchronise the input stream to a subdivision of the tempo. When "None" is selected in the quantification spin box, an incoming value will only be output every N miliseconds, as specified by the ms slider.

## Quantification

Set the subdivision of the tempo to synchronise to.

## ms.

You can change the value between 0 and 1000 milliseconds.