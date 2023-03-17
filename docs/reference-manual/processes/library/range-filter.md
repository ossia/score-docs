---
layout: default

title: Range filter
description: ""

parent: Processes
grand_parent: Reference

permalink: /processes/range-filter.html
---
# Range filter

![Range filter]({{ site.img }}/reference/processes/range-filter.png "Range filter")

This object filters the incoming values that are outside of the input range.

Example: if the input messages are: 

```
5
3.6
1457
-50000
3.7
NaN
```

then given a min of 2 and max of 4, the outputs will be

```
3.6
3.7
```
