---
layout: default

title: Sweeper
description: ""

parent: Processes
grand_parent: Reference

permalink: /processes/sweeper.html
---
# Sweeper

![Sweeper]({{ site.img }}/reference/processes/sweeper.png "Sweeper")

Given an input value, this process periodically sends it to all the OSC addresses matching a specific address.

For instance: given the addresses: 

```
arduinos:/led.1
arduinos:/led.2
arduinos:/led.3
arduinos:/led.4
```

which are the brightness of some LEDs, then the Sweeper process receiving an LFO signal as input will periodically distribute it across the LEDs, to create a sweeping motion, with the pattern: `arduinos:/led.*`.

![Sweeper]({{ site.img }}/reference/processes/sweeper-example.gif "Sweeper")