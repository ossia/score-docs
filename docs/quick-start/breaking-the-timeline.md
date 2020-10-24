---
layout: default
title: "Breaking the timeline"
parent: Quick start
nav_order: 8

permalink: /docs/quick-start/breaking-the-timeline.html
category: "site-score"

description: "Breaking the timeline"

tag: "Presentation"
visible: true
---
# Breaking the timeline
In previous steps of this Quick start guide, we used *score* to write simple scenario use cases following a timeline-based approach pretty similar to the one found in usual DAW softwares. While such an approach allows to write very precise temporal developments of a scenario, it may also hit some limits in live performance situation or installation where a much more flexible approach is required. *score* offers a number of features to bridge the gap between different approaches and thus combine timeline-based workflow and cue-based workflow. One of them is the use of `trigger` points. 

## Enabling triggers

Introducing trigger points in your scenario allows to keep organizing things in time while allowing interactive triggering of elements: when executing the scenario, parts of the scenario starting with a `trigger` point will be put "on hold" until they get triggered. When triggered, following automations and states will get executed at the speed and duration specified in the scenario.

To add a trigger point, simply select a state on the scenario then from its inspector, toggle on the `trigger` icon. 

![Enabling trigger](/score-docs/assets/images/quick-start/breaking-the-timeline/enabling-trigger.gif "Enabling trigger")

When turning on the `trigger`, you can see a T-like icon is added on top of the selected `state`. You can also note that a dashed line appears on top of the preceeding automation slot. This indicates that the duration of the preceeding automations is now undefined: preceeding automations will get executed up until the trigger is, well... *triggered*.

![Triggering](/score-docs/assets/images/quick-start/breaking-the-timeline/triggering.gif "Triggering")

In the example above, the scenario start with a simple fade-in. Notice that it gets executed as the scenario playhead goes across the automation slot.  While the scenario playhead continues its progression, you will notice though that the green progression bar at the top of the automation stops as it reaches the trigger point. Execution of the following automations is then on hold until the trigger point is triggered by a mouse click. 

From then, execution follow its curse until the next trigger point in the scenario. Here again, execution is put on hold until trigger point is clicked my mouse.

## Triggers remote control

In the example above, we used the mouse to trigger the followup of the scenario execution. While convenient for demo purpose, you are most likely to rely on other inputs in creation situation such as some controller gear. You may use as an input for some trigger points, any parameter from your device.

To set an input for a trigger point, just grab the desired parameter in the `Device explorer` and drop it on the trigger icon.

![Enabling trigger](/score-docs/assets/images/quick-start/breaking-the-timeline/interactive-trigger.gif "Enabling trigger")

In the example above, we use as an input, one button of a Korg nanoKontrol [Midi controller](/score-docs/docs/references/devices-types/midiin-device.html). When done, you will see in the inspector the address of the dropped parameter in the address field.

> You may also drop the parameter on the address field of the trigger point inspector.