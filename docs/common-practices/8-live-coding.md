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

Processes, sounds and scripts can be added, removed and edited while the score plays. They still need an active containing interval and appropriate routing to produce output.

Current development builds also allow adding a new device during playback. Stop execution before removing a device or changing its configuration or namespace: those operations remain restricted. In particular, the ability to add a device is not a guarantee that every hardware reconfiguration is interruption-free.

See [Editing workflow]({{ site.baseurl }}/reference/editing-workflow.html) for node selection, cable replacement, editor placement and the restrictions on live changes.

A very simple trick is then to use triggers to keep the parts running forever: this way, the intervals that are running that way
will keep running their processes forever, like for instance would a Max or Pure Data patch.

Here is a small example:

<video controls>
    <source src="{{ site.img }}/common-practices/livecode-1.mp4" type="video/mp4">
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

Open the code editor using the editor button on the process header or in its inspector. Processes that provide a custom UI have a separate UI toggle.

The placement menu offers **Window**, **Side panel** and **Central**. A central editor can be shown over a background visual output for live coding with the result behind the code; see [Editing workflow]({{ site.baseurl }}/reference/editing-workflow.html#place-code-editors-and-custom-uis).

## Editing scripts

When you are done editing, press **Compile** to submit the code to the execution engine. Read the error log before assuming a change has taken effect; validation and failure handling depend on the process. Test substantial edits before a performance rather than relying on a compile failure to protect the output.

It is possible to use the {% include shortcut.html content="Ctrl+Enter" %} shortcut to update the execution engine
with the current code.

The pane at the bottom of the window will display the error log: here, we have some slightly invalid code on line 9 for instance.

![Script editor]({{ site.img }}/common-practices/live-coding-editor.png "Live-coding editor")

## Updating a linked source

For a JavaScript process linked to a QML source file, an **Update** button appears in the inspector when its stored code differs from the available source. This replaces the document's copy with the file's current version; it is separate from compiling the code you are editing. See [Source update notices]({{ site.baseurl }}/reference/editing-workflow.html#source-update-notices).
