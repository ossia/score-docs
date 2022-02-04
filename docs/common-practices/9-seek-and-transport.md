---
layout: default

title: "Seek and transport"
description: "Seek and transport"

nav_order: 9
parent: Common practices

permalink: /common-practices/9-seek-and-transport.html
---

# Seek and transport

This page explains all the possible ways to control the transport in score.

There are three ways to control transport:

- Manually, with the "play from here" feature which allows to seek at a given point explicitly.

- In a pre-determined or processed way with a specific process which allows to control the speed of its parent interval.

- Through an external transport system. For now only JACK transport is supported.

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

## Playing a single state

Either the play tool or a right-click menu allow to launch the content of a single state at any point.


# Controlling speed and transport programmatically

See the documentation of the [[Tempo|Tempo process]].

# Controlling global transport through an external API

Right now, only JACK is supported. The plan is to include synchronization with SMTPE, Midi Clock, Ableton Link, etc. over time.

The setting is currently in the global software settings: score can act both as a JACK client or master:

![JACK transport]({{ site.img }}/common-practices/seek/jack-transport.png "JACK transport")
