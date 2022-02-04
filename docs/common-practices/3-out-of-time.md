---
layout: default

title: "Out-of-time triggering"
description: "Out-of-time triggering in ossia score"

nav_order: 3
parent: Common practices

permalink: /common-practices/3-out-of-time.html
---

# Out-of-time triggering

By default, `score` works as a time-line: time flows from the start to the end of the score.

As mentioned by [[non-linear timelines|the quick start guide]], the time-line can be made non-linear
by adding triggers and graph connections.

It is possible to go one step further, by entirely removing parts of the score from
the "main" timeline and triggering them at any point in time: for instance in response to an OSC message,
by clicking, ...

## Creating an out-of-time score

To remove a part of the score from the time-line, simply make sure that it isn't connected to the start of the time-line:

![Disconnected interval]({{ site.img }}/common-practices/out-of-time-1.png)

When playing the score, this interval now won't run anymore:

![Disconnected interval not playing]({{ site.img }}/common-practices/out-of-time-2.png)

Some *score* users use that mechanism as a sand-box to try various behaviours.

Now, to play this part of the score, we have to tell *score* what is going to trigger it.
Thus, we have to add a [trigger]({{ site.baseurl }}/processes/scenario.html#triggers) to the start of the interval:

![A trigger]({{ site.img }}/common-practices/out-of-time-trigger.png)

Then, select the trigger, go to the inspector and enable the "Start on play" which will make
the trigger available for triggering when the score starts, with the right button:

![Trigger inspector]({{ site.img }}/common-practices/out-of-time-inspector.png)

## Re-triggering

The left button in the inspector is used to control the re-triggering behaviour.

If left unchecked, re-triggering the trigger will stop the sub-score that follows it.
It will need another event to start again.

If checked, it will restart automatically from the beginning every time the trigger is triggered.

## Triggering intervals

When the main score is playing, play / stop buttons will appear on top of intervals when hovered.
These allow to stop or start an interval while entirely discarding any semantics that may have been set in the score.

This will respect the quantization settings by default.