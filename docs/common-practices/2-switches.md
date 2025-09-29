---
layout: default

title: Switches
description: "Switches in ossia score"

nav_order: 2
parent: Common practices

permalink: /common-practices/2-switches.html
---

# Switches

## Single trigger

Adding a trigger at either end of a
[looping interval]({{ site.baseurl }}/common-practices/1-looping.html#loop-with-transitions)
provides control over each repetition. If the trigger is enabled at the beginning of the interval, it controls the start and restarts of the loop.
When time reaches the end of the interval, the transition returns to the start `Sync` where the execution is suspended again until re-triggered.
In this case, the interval's execution must reach its end before it can be restarted.

![Start trigger switch]({{ site.img }}/reference/common-practices/triggerStart.gif "Start trigger switch")

If the trigger is enabled at the end of the loop, it provides flexible time to the interval.
As soon as the interval begins executing, it can be interrupted by the validation of the trigger and transition back to the beginning.

![End trigger switch]({{ site.img }}/reference/common-practices/triggerEnd.gif "End trigger switch")

## On / Off

Combining both the above options, an interval can be toggled on and off at will. This method, like the previous, can also be directly mapped to various devices featuring buttons, keys, hardware switches or any kind of discrete value streams. In this case we will use the first button of a game controller accessed through the [Joystick Device]({{ site.baseurl }}/devices/joystick-device.html).

![Basic switch]({{ site.img }}/reference/common-practices/switch.gif "Basic switch")

When the button is pressed, the first trigger is validated (as by default, it is set to "pulse") and will respond to any value received at the provided address. When the button is released, the end trigger is validated in the same way, before the transition returns to the initial `Sync`.

## Consecutive toggles

The section inside the loop can contain more than one interval. Expanding on the prior example, switching between an idle state and an interval, a similar structure could enclose two intervals. This switch also requires an extra trigger.

![Consecutive switch]({{ site.img }}/reference/common-practices/consecutive.gif "Consecutive switch")

With the default "Pulse" operators to validate each trigger, this structure will return to the idle state after each transition. To avoid this extra step and make sure that the first interval executes every time the button's value is true and that the second executes every time it is false, the expression for the trigger has to be modified. By setting both the start and end triggers to only respond when the value is true, they can be validated in a row, skipping the idle state after the transition. 

![Consecutive 2 stages switch]({{ site.img }}/reference/common-practices/seq2Stage.gif "Consecutive 2 steps switch")

A better way of achieving the same result would be to rely on a [sub-scenario to isolate the loop]({{ site.baseurl }}/common-practices/1-looping.html#nested-loops). Since the first trigger is only needed to control the very first execution of the loop, it can be validated once to enter the sub-scenario and omitted in the actual toggle structure. The trigger at the end of the sub-scenario is left "never" valid to allow as many repetitions as needed.

![Consecutive switch isolated]({{ site.img }}/reference/common-practices/seqIsolate.gif "Consecutive switch isolated")

It may be preferable to switch at every press of the button, instead of having to hold for the first interval and let go for the second. Adding a minimum duration on each of the toggled intervals ensures that the value of the button can go back to false without validating the next trigger. This method also protects the switch from accidental "double taps".

![Tap once to switch]({{ site.img }}/reference/common-practices/tapToSwitch.gif "Tap once to switch")

## Parallel switches

Consecutive switches shown above can sequence an arbitrary number of intervals, but only in the same order every time. To enable switching as well as reordering, we can rely on conditional branches. Let's first create another device for control. For this example we will add a [[mapper device]] by copying and pasting the script below. We will name it "Structure".

```qml
import Ossia 1.0 as Ossia

Ossia.Mapper
{
    function createTree() {
        return [
        {
            name: "Branch",
            type: Ossia.Type.Int,
            write: function(v) { return v.value; }
        }
        ];
    }
}
```

![Structure mapper]({{ site.img }}/reference/common-practices/structureMapper.gif "Structure mapper")

Parallel branches start from the same `Sync`. Syncing them at the end too will also make them responsive to the same trigger and allow us to only set up one transition to loop the entire structure.

![Parallel sync]({{ site.img }}/reference/common-practices/parallelSync.gif "Parallel sync")

To add conditions for each start state of parallel intervals, they have to be split into individual events with the "Split condition" function. The state connecting the transition back to the initial `Sync` does not require a condition. Finally, a trigger on the end `Sync` can reset the loop with every new value set in the mapper.

![Conditions]({{ site.img }}/reference/common-practices/conditions.gif "Conditions")

It is now possible to switch between parallel intervals when setting a value to the "Branch" parameter. To control the start of the structure when played the first time, we have to avoid adding a trigger to the start sync of the loop. It would add an idle state as we experienced before and skip the evaluation of every other value. Instead we can isolate this switch from its initial trigger with another transition, similar to our solution to [looping parallel branches]({{ site.baseurl }}/common-practices/1-looping.html#loop-branches).

![Isolated conditions]({{ site.img }}/reference/common-practices/isolateConditions.gif "Isolated conditions")
