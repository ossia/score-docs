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

You can add a device during playback. Stop execution before removing a device or changing its configuration or namespace.

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
- [C++ JIT]({{ site.baseurl }}/processes/cpp_jit.html)

![Live coding processes]({{ site.img }}/common-practices/live-coding-scripts.png "Live coding processes")

Open the code editor using the editor button on the process header or in its inspector. Processes that provide a custom UI have a separate UI toggle.

The placement menu offers three display modes:

- Separate window: a floating code editor.
- Side panel: an editor pane alongside the score.
- Central view: the editor occupies the main view. Under "Behind the editor", choose "Document background, without chrome" to show the code over the document's background output, or "Nothing: a plain editor".

Right-click the editor's side-panel tab or central-view tab to change its placement. See [Editing workflow]({{ site.baseurl }}/reference/editing-workflow.html#place-code-editors-and-custom-uis) for the placement settings.

## Editing scripts

Press Compile or {% include shortcut.html content="Ctrl+Enter" %} to apply the edited code. Compilation errors appear in the pane below the editor.


![Script editor]({{ site.img }}/common-practices/live-coding-editor.png "Live-coding editor")

## Updating a linked source

For a JavaScript process linked to a QML source file, an Update button appears in the inspector when the file changes. Click it to replace the document's stored code with the file's current version. See [Source update notices]({{ site.baseurl }}/reference/editing-workflow.html#source-update-notices).
