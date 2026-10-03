---
layout: default

title: Seek and transport
description: "Seek and transport"

nav_order: 9
parent: Common practices

permalink: /common-practices/9-seek-and-transport.html
---

# Seek and transport

This page explains all the possible ways to control the transport in score.

Transport can be controlled manually, programmatically or through an external transport system:

- Use **Play from here**, a time-ruler double-click or the Play tool to seek; drag to scrub.
- Change an interval's speed, or use a process such as [[Tempo]] to control its parent's timing.
- Use JACK transport for global transport synchronization. MIDI synchronization processes are a separate mechanism; receiving MIDI timing data does not automatically make the global score transport a slave.

See [[MIDI Sync In]] and [[MIDI Sync Out]] for receiving and generating MIDI timing messages. [[Timecode Synchronizer]] converts numeric position/speed inputs into smoothed playback-control signals; it requires explicit downstream connections.

# Semantics of transport

Before explaining how to use the actual feature, it is important to explain the semantics of 
transport in score, as due to the interactive nature of scores, behaviour of transport can be somewhat surprising.

Consider the following score:

![Seek example]({{ site.img }}/common-practices/seek/exec-main.png "Seek example")

Thanks to the various interactive features of score such as [[Scenario|interactive triggers]] and [[Scenario|interval speed control]] the three following executions are possible:

![Seek example A]({{ site.img }}/common-practices/seek/exec-a.png "Seek example A")

![Seek example B]({{ site.img }}/common-practices/seek/exec-b.png "Seek example B")

![Seek example C]({{ site.img }}/common-practices/seek/exec-c.png "Seek example C")

This of course begs the question of: what should happen when asking score to transport at any given point when the score has not started playing ? 

The policy taken by score is to follow the visual duration set for intervals. That is, that visual duration even for a fully interactive interval is not entirely devoid of semantic meaning: it can be taken as to mean: 

    The duration that I expect this part of the score to last.

In particular, this means that any interactive point *before* the point to which the transport is performed will be triggered. All intervals that are visually at that point will be positioned accordingly.

That is, here are successive transports done in the above score.

![Transport example A]({{ site.img }}/common-practices/seek/transport-a.png "Transport example A")

![Transport example B]({{ site.img }}/common-practices/seek/transport-b.png "Transport example B")

![Transport example C]({{ site.img }}/common-practices/seek/transport-c.png "Transport example C")

![Transport example D]({{ site.img }}/common-practices/seek/transport-d.png "Transport example C")

## Value compilation

Consider a score where a sound is being played through an external sound player, controlled through OSC. This sound player's API is:

    player:/play   <bool>
    player:/volume <float>

The score is:

![Value compilation]({{ site.img }}/common-practices/seek/autom.png "Value compilation")

Now, if we want to play our score from the middle of the automation, if nothing else was done other than positioning the playhead and starting playback, the `player:/play true` OSC message would never be sent and the remote software would not start playing, thus making the feature somewhat useless.

Thankfully, score takes this into account: by default, when running a transport action if the score is not playing, every state leading to the transported point is computed from the beginning of the score. If multiple states send different values, then the last one is taken into account: that is, if making a transport after the end of the example score shown above, the player will receive the messages: 

    player:/play   false
    player:/volume 0

The software settings contain two options to control this behaviour, one for the first time a transport is done, and one for subsequent transports when execution is already running: 

![Value compilation settings]({{ site.img }}/common-practices/seek/settings.png "Value compilation settings")

## Offset behaviour

A more complex case is related to conditions.

![Conditions example]({{ site.img }}/common-practices/seek/conditions.png "Conditions")

In this case, a choice must be made when processing the conditions. However, sometime we may need to explore the different outcomes of a score when doing transport: for instance, if a condition requires a performer to be at a specific place on the stage, we may want to be able to perform a transport without having to ask the performer to go to the designed place for the transport to take place as expected.

Thus, the condition inspector provides the "offset behaviour" setting which allows to toggle whether the condition will be true, false, or evaluated with the live value in the device tree, when it is evaluated during a transport operation: 

![Offset example]({{ site.img }}/common-practices/seek/offset.png "Offset behaviour")


# Using transport

## Play from here

This feature allows to move the global time bar.
To use it, right-click on a scenario and hit "Play from here": 

![Play from here]({{ site.img }}/common-practices/seek/menu.png "Play from here")

You can also use the "Play" tool: 

![Play tool]({{ site.img }}/common-practices/seek/pfh.gif "Play tool")

In current development builds, double-clicking the time ruler also plays from that position. Keep the second click held and drag to scrub: dragging backwards can run the interval backwards, rather than merely moving a stopped cursor. On release the previous speed is restored and playback continues from near the release point.

Dragging on the scenario background with the Play tool also scrubs. Clicking an interval with that tool plays it from the clicked date; **Alt+click** plays the interval from its beginning. A subsequent ordinary start of an interval does not retain an earlier play-from-here offset.

Reverse time is not an undo operation: it does not reverse external hardware actions or guarantee that every stateful plug-in reconstructs its history. VST, VST3 and LV2 processing can continue during reverse timeline execution, but each process still determines what negative time means for its content.

## Playing a single state

Either the play tool or a right-click menu allow to launch the content of a single state at any point.


# Controlling speed and transport programmatically

See the documentation of the [[Tempo|Tempo process]].

# Controlling global transport through an external API

JACK transport can control the global transport when using the JACK audio backend. Configure whether score acts as a client or master in the software settings:

![JACK transport]({{ site.img }}/common-practices/seek/jack-transport.png "JACK transport")

# Setting a start marker

It is possible to set a start marker by right-clicking into the musical metrics area, at the top of the score.

When a start marker is set, play / pause will always start from this point: this is mainly useful to play a specific part of a score quickly in succession.

![Start marker]({{ site.img }}/common-practices/seek/start-marker.gif "Start marker")

## Starting playback while recording waits

When address recording is armed and waiting for its first message, pressing Play starts the recording context with playback. It no longer needs a later message to establish the recording's start time. The **Play while recording** preference controls whether the first received message also launches playback automatically. See [Recording]({{ site.baseurl }}/in-depth/recording.html) for the full workflow.

For related editing gestures and focus-dependent shortcuts, see [Editing workflow]({{ site.baseurl }}/reference/editing-workflow.html).