---
layout: default

title: "Cues"
description: "How to store and recall cues"

parent: In depth

permalink: /cues.html
---

# Cues

Cues are an essential part of interactive shows: they allow to record a set of controls and messages that will be applied at a single point in time: OSC or DMX messages, MIDI control changes, etc.

In *score*, cues are messages that are contained inside [[Scenario|states]].

## Creating a cue

Cues are created by drag'n'drop, from a set of [[Device explorer]] nodes, to the score.

<video controls>
    <source src="{{ site.img }}/in-depth/cues/cues-1.mp4" type="video/mp4">
</video>

It is possible to add messages to a cue by dropping on it. Existing messages to a given address will be replaced by the value that is being dropped.

<video controls>
    <source src="{{ site.img }}/in-depth/cues/cues-2.mp4" type="video/mp4">
</video>

## Playing a cue

Cues will be played automatically when the score execution reaches them:

<video controls>
    <source src="{{ site.img }}/in-depth/cues/cues-3.mp4" type="video/mp4">
</video>

## Playing a cue manually

It is possible to play a cue through the "Play" tool in the user interface.

<video controls>
    <source src="{{ site.img }}/in-depth/cues/cues-4.mp4" type="video/mp4">
</video>

## Playing a cue with an external control

It is possible to entirely control when a cue is going to be sent, by adding a trigger on it and let it "float" in the scenario.

Such a floating cue can originally be created by double-clicking on the scenario (or drag'n'dropping directly from the [[Device explorer]], and removing the created interval afterwards).

Then, one needs to add a trigger (through the inspector or by pressing {% include shortcut.html content="T" %} when the state is selected), and configure it for out-of-time playback.

Here is how this would work:

<video controls>
    <source src="{{ site.img }}/in-depth/cues/cues-5.mp4" type="video/mp4">
</video>

The set-up on the triggers look like this:

![Trigger set-up for external triggering of cues]({{ site.img }}/in-depth/cues/cues-trigger-setup.png)

Notice in particular that the two buttons, "Auto-Trigger" and "Start on play", are checked.

It would be possible for instance to trigger the cue when a MIDI CC reaches a specific value or similar.


See [[Breaking the timeline]] for more information on triggers.