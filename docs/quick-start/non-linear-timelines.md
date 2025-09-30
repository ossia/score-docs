---
layout: default

title: Non-linear timeline
description: "Non-linear timeline"

parent: Quick start
nav_order: 9

permalink: /quick-start/non-linear-timelines.html
---
# Non-linear timeline

In previous example, we used trigger points to add variation during the execution of time-lined contents (device's state recalling as well as automations) in the scenario. While trigger points bring flexibility in a timeline-based approach, things can be pushed a step further.

You remember we noted in the [Saving and recalling devices state]({{ site.baseurl }}/quick-start/saving-and-recalling-devices-state.html "Saving and recalling devices state") page that *score* offers to connect dropped namespace selection to different preceding elements in the scenario. *score* also provides several ways to connect elements, one of them allowing to write and organize elements pretty much like you would do when designing a state machine.

> To learn about the various connections features, please refer to the [in-depth topics]({{ site.baseurl }}/in-depth.html "in-depth topics") as well as the [reference manual]({{ site.baseurl }}/reference.html "*score* reference manual") to see how *score* engine works and the advanced authoring features it provides.

In the scenario editor panel, you may create some elements by dragging a connection to a point in the timeline where you want to store a namespace state or start a process. This is where the `create widget` comes handy.

In the illustration below, we can see that selecting a namespace state stored in the timeline brings the `create` widget: the yellow, blue and red crosses icons. We will focus here on the red one: it allows to *escape the timeline constraint* and automatically trigger elements attached to that connection.

<video controls>
    <source src="{{ site.img }}/quick-start/non-linear-timeline/timeless-interval.mp4" type="video/mp4">
</video>

As seen above, clicking the red cross allows us to drag a connection up to anywhere in the timeline. From there, we may adjust our device settings and drag a namespace selection from the `Device explorer` to store its state [as seen earlier]({{ site.baseurl }}/quick-start/states-and-automations-in-practice.html "Store & recall devices' state").

What's happening here? Well, we are starting to scratch the surface of *score*'s special strength.

When playing our scenario, *score* will recall our parameters' stored states and execute automations as the play-head runs through the timeline, just like we saw earlier. But when reaching the starting point of this dashed connection, the play-head will kind of *jump* to the connected elements and continue the reading as time regularly passes by.

This might look weird coming from a timeline-based approach but is actually extremely useful. While *score* can help to author elements of precise duration and evolution over time using its timeline as a default grid, it also allows to author state machine-like scenarios by *patching* timed processes.

## From timeline-based scenario to state machine

This way of *patching* blocks of timed elements offers to construct your scenario in much more flexible ways that traditional DAW or timeline-based sequencers. As illustrated below, it allows to write scenarios running in loop for example, especially useful in interactive installations.

![Looping scenario]({{ site.img }}/quick-start/non-linear-timeline/looping-scenario.png)

In the simple scenario above, *score* will execute the scenario as an infinite loop alternating a simple fade in, then jumping to the fade-out automations then jump back to fade-in automations.

Of course, you can still use some [trigger points]({{ site.baseurl }}/quick-start/breaking-the-timeline.html) so the scenario waits before jumping to the next point.

![State machine scenario]({{ site.img }}/quick-start/non-linear-timeline/state-machine.png)
