---
layout: default

title: "Looping"
description: "Looping in ossia score"

nav_order: 1
parent: Common practices

permalink: /common-practices/1-looping.html
---

# Looping

This chapter deals with structure loops, not [Process loops]({{ site.baseurl }}/processes.html#process-loops).

## Loop with transitions

To enable the repetition of certain parts of a scenario, we use transitions to go "back in time". Transitions are instantaneous intervals that can connect two states regardless of their chronological relationship.

![Loop with Transitions]({{ site.img }}/reference/common-practices/loopStructure.gif "Loop with transitions")

In this case, the loop will go on forever as well as playing and replaying all following intervals.

## Nested loops

For more control and to avoid perpetual looping and branching, it may be necessary to isolate a repeating structure in a sub-scenario. Triggering the end of the interval containing the sub-scenario will ensure that the loop stops as well as the execution of the following intervals.

![Nested Loops]({{ site.img }}/reference/common-practices/nestedLoop.gif "Nested loop")

## Repetition amount

Adding a trigger on the last `Sync` of a loop and setting its maximum duration allows to control the amount of repetition. The trigger left by default to be "never" true will still be validated when the maximum duration of the preceding interval has been reached. With this method, the time spent looping is equal to the loop duration + the maximum duration, and can be fine-tuned by manipulating the closing parenthesis.

![repetition amount]({{ site.img }}/reference/common-practices/repetition-ammount.gif "repetition amount")

## Loop branches

Transitions actually connect to `Syncs` (vertical doted lines), thus, transitioning to a specific `Sync` will execute or re-execute all connected branches. When several transitions are connected to the same `Sync`, the smallest loop will then always restart first and cut short all parallel intervals.

![Loop branches]({{ site.img }}/reference/common-practices/loopBranches.gif "Loop branches")

Transitions can provide a workaround in this situation. Since transitions are instantaneous intervals, they can also be used to isolate parallel loops without interfering with timing and their original synchronization.

![Isolate transitions]({{ site.img }}/reference/common-practices/isolateTransitions.gif "Isolate transitions")
