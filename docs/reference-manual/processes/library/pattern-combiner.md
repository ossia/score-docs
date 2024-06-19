---
layout: default

title: Pattern Combiner
description: ""

parent: Processes
grand_parent: Reference

permalink: /processes/pattern-combiner.html
---
# Pattern Combiner

![Pattern Combiner]({{ site.img }}/reference/processes/pattern-combiner.png "Pattern Combiner")

This object combines the (numeric) values of a set of address matched by an [[Pattern matching|address pattern]] expression.

For instance, given a set of OSC sensors which all have a value:

```
sensors:/temperature.*        # 23°
sensors:/temperature.*        # 17°
sensors:/temperature.*        # 26°
```

Then the following will output the mean of the three temperature sensors, 22°:

![Pattern Combiner]({{ site.img }}/reference/processes/pattern-combiner-example.png "Pattern Combiner")