---
layout: default

title: Live coding
description: "Working on a score while it executes"

nav_order: 8
parent: Common practices

permalink: /common-practices/8-live-coding.html
---

# Live coding
The timeline nature of *ossia score* may make it look like it is not very amenable to live coding ; that could not be farther from the truth !

# Editing the score during playback

It is possible to edit every part of the score while it plays, and most importantly, start or restart those parts.

Most places in a score should be editable during playback ; if you encounter issues, please file a [bug report](https://github.com/ossia/score) !
In particular, processes, sounds, shaders, etc. can all be added, removed, altered during playback.

> There is *one* important exception, that we have not lifted yet: it is not possible to add a new device during playback ; you must prepare the devices to be used before hitting play.
> For instance, it is not possible as of *ossia score 3.0.0-b1* to open a new window for visuals or plug a new MIDI keyboard in the middle of a performance.

A very simple trick is then to use triggers to keep the parts running forever: this way, the intervals that are running that way
will keep running their processes forever, like for instance would a Max or Pure Data patch.

Here is a small example:

<video controls>
    <source src="{{ site.img }}/common-practices/livecode-1.mp4 " type="video/mp4">
</video>

# Code-based processes

A few processes in score use textual scripts:
- [[Javascript]]
- [[ISF Shaders|Shaders]]
- [[Bytebeat]]
- [[Texture generator]]
- [[Faust]]
- [[C++ JIT]]

![Live coding processes]({{ site.img }}/common-practices/live-coding-scripts.png "Live coding processes")

In all cases, the script can be edited with the small "Window" button on the header of each of the corresponding nodes
(the second button).

## Editing scripts

When that button is pressed, this opens the script editor, which can be used to change the code.
When you are done editing, press "Compile" ; this will update the code for the execution engine.
Invalid code won't change the current state to prevent unwanted loud noises and flashes :-)

It is possible to use the {% include shortcut.html content="Ctrl+Enter" %} shortcut to update the execution engine
with the current code.

The pane at the bottom of the window will display the error log: here, we have some slightly invalid code on line 9 for instance.

![Script editor]({{ site.img }}/common-practices/live-coding-editor.png "Live-coding editor")
