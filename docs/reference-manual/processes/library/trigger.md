---
layout: default

title: Trigger
description: "Send triggering messages when a signal enters or leaves a range"

parent: Processes
grand_parent: Reference

permalink: /processes/trigger.html
---
# Range filter

![Trigger]({{ site.img }}/reference/processes/trigger.png "Trigger")

This object sends trigger messages when the incoming values enter or leave the input range.

Example: if the input messages are: 

```
5
3.6
3.4
3.8
1457
-50000
```

then given a min of 2 and max of 4, there will be:

- An "enter" trigger when the 3.6 message is received (we entered the range)
- A "leave" trigger when the 1457 message is received (we left the range).
