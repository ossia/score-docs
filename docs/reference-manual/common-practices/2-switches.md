---
layout: default
title: "Switches"

parent: Common practices
grand_parent: Reference manual
has_children: false

nav_order: 2

permalink: /docs/reference-manual/common-practices/2-switches.html
category: "site-score"

description: "Switches"

tag: "Presentation"
visible: true
---

# Switches

## Single trigger

Adding a trigger at either end of a 
[looping interval](/score-docs/docs/reference-manual/common-practices/1-looping.html#loop-with-transitions) 
provides control over each repetition.If the trigger is enabled at the beginning of the interval, it controls the start and restarts of the loop.
When time reaches the end of the interval, the transition returns to the start `Sync` where the execution is suspended again until re-triggered. 
In this case, the interval's execution must reach its end before it can be restarted.

![Start trigger switch](/score-docs/assets/images/reference-manual/common-practices/triggerStart.gif "Start trigger switch")

If the trigger is enabled at the end of the loop, it provides flexible time to the interval. 
As soon as the interval begins executing, it can be interrupted by the validation of the trigger and transition back to the beginning.

![End trigger switch](/score-docs/assets/images/reference-manual/common-practices/triggerEnd.gif "End trigger switch")

## On / Off

Combining both the above options, an interval can be toggled on and off at will. This method, like the previous, can also be directly mapped to various devices featuring buttons, keys, hardware switches or any kind of discrete value streams. In this case we will use the first button of a game controller accessed through the [Joystick Device](/score-docs/docs/reference-manual/devices-types/joystick-device.html).

![Basic Switch](/score-docs/assets/images/reference-manual/common-practices/switch.gif "Basic Switch")

When the button is pressed, the first trigger is validated as by default, it is set to "pulse" and will respond to any value received at the provided address. When the button is released, the end trigger is validated in the same way, before the transition returns to the initial `Sync`.

## Consecutive toggles

## Parallel switches
