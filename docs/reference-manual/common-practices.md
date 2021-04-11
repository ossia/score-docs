---
layout: default
title: "Common practices"

parent: Reference manual
has_children: false

nav_order: 1

permalink: /docs/reference-manual/common-practices.html
category: "site-score"

description: "Common practices"

tag: "Presentation"
visible: true
---

# Common practices

## Looping

### Process Loops

Time based processes like automations, media and sub-scenarios can be looped for as long as their parent interval is active. When selecting a process, eiher form the object window or by clicking on the it's upper margin, the loop option will appear in the `inspector`.

![Process looping](/score-docs/assets/images/reference-manual/common-practices/loopProcess.gif "Process looping")

### Loop with transitions

To enable the repetition of certain parts of a scenario, we use transitions to go "back in time". Transitions are instantaneous intervals that can connect two states ragrdless of their chonological relasionship. 

![Loop with Transitions](/score-docs/assets/images/reference-manual/common-practices/loopStructure.gif "Loop with transitions")

It is importatn to note however that in this case, the loop will go on forever as well as playing and repalying all folowing intervals.
In both the above exemples, adding a trigger on the last `Sync` allows to control the amount of repetition.

### Nested loops

To avoid prpetual looping and branshing, it may be necessary to isolate a repeating structure in an sub-scenario.

![Nested Loops](/score-docs/assets/images/reference-manual/common-practices/nestedLoop.gif "Nested loop")
