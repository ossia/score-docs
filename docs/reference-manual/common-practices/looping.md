---
layout: default
title: "Looping"

parent: Common practices
grand_parent: Reference manual
has_children: false

nav_order: 1

permalink: /docs/reference-manual/common-practices/looping.html
category: "site-score"

description: "Looping"

tag: "Presentation"
visible: true
---

# Looping

## Process Loops

Time based processes like automations, media and sub-scenarios can be looped for as long as their parent interval is active. When selecting a process, eiher form the object window or by clicking on the it's upper margin, the loop option will appear in the `Inspector`.

![Process looping](/score-docs/assets/images/reference-manual/common-practices/loopProcess.gif "Process looping")

## Loop with transitions

To enable the repetition of certain parts of a scenario, we use transitions to go "back in time". Transitions are instantaneous intervals that can connect two states ragrdless of their chonological relasionship. 

![Loop with Transitions](/score-docs/assets/images/reference-manual/common-practices/loopStructure.gif "Loop with transitions")

It is important to note however that in this case, the loop will go on forever as well as playing and repalying all folowing intervals.

## Nested loops

For more control and to avoid prpetual looping and branshing, it may be necessary to isolate a repeating structure in an sub-scenario. Triggering the end of the interval containing the sub-scenario will ensure the stopping of the loop as well as the execution of the folowing intervals.

![Nested Loops](/score-docs/assets/images/reference-manual/common-practices/nestedLoop.gif "Nested loop")

## Repetition ammount

Adding a trigger on the last `Sync` of a loop and setting it's maximum duration allows to control the amount of repetition. The trigger left by default to be "nerver" true will still be vaildated when the maximum duration of the precceding interval has been reached. With this metthod, the time spent looping is equal to the loop duration + the maximum duration, and can be fine tuned by manipulating the closing parenthesis.

![epetition ammount](/score-docs/assets/images/reference-manual/common-practices/repetition-ammount.gif "repetition ammount")

## Loop branches 

Transitions actually connect to `Syncs` (vertical doted lines), therefore, transitioning to a specific `Sync` will execute or re-execute all connected branches. When sevral treansitions are connected to the same `Sync`, the smallest loop will then always restart first and cut short all parrallel intervals.

![Loop branches](/score-docs/assets/images/reference-manual/common-practices/loopBranches.gif "Loop branches")

Transitions can provied a workaround in this situation. Since transitions are instantaneous intervals, they can also be used to isolate parllel loops without interfering with timming and their original synchronisation.

![Isolate transitions](/score-docs/assets/images/reference-manual/common-practices/isolateTransitions.gif "Isolate transitions")
