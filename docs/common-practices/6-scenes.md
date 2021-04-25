---
layout: default

title: "Scenes"
description: "Scenes in ossia score"

nav_order: 4
parent: Common practices

permalink: /common-practices/6-scenes.html
---

# Scenes

Scenes are a common pattern in intermedia creation: you want to split
a show for instance in a sequence of acts, chapters, etc.

To achieve this in *score*, the general principle is to have sequences of intervals,
each containing a sub-scenario.

## Structuring a score for dynamic scenes

To go from one scene to the next dynamically by responding to an interaction, it is sufficient to add triggers.

It is also possible to use the Play from here tool to transport the timeline to a specific point.

Don't forget to label your scenes in the inspector to make the score easier to read:

![Splitting a score in scenes]({{ site.img }}/common-practices/scenes-1.png)

## Working with scenes

To work on a specific scene, simply go in "full view". That is, either double-click
on the interval header, or press the full view button in the interval inspector.

If you have a lot of scenes, you can use the object finder (at the top-right) to find your scene by name or label:

<video controls>
    <source src="{{ site.img }}/common-practices/scenes-2.mp4" type="video/mp4">
</video>

