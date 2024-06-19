---
layout: default

title: Pattern Applier
description: ""

parent: Processes
grand_parent: Reference

permalink: /processes/pattern-applier.html
---
# Pattern Applier

![Pattern Applier]({{ site.img }}/reference/processes/pattern-applier.png "Pattern Applier")

Given an input list, this applies each element of a list to the individual addresses matching an [[Pattern matching|address pattern]] expression.

For instance, given the list:

```
[ 1, 6, 4, 5, 12, 4, 56 ]
```

and the device: 

```
leds:/brightness/0
leds:/brightness/1
leds:/brightness/2
... etc
```

Then the following will write 1 to `leds:/brightness/0`, 6 to `leds:/brightness/1`, etc.


![Pattern Applier]({{ site.img }}/reference/processes/pattern-applier-example.png "Pattern Applier")