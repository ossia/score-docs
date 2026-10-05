---
layout: default

title: Library
description: "Using the media and process library"

parent: Panels
grand_parent: Reference

permalink: /panels/library.html
---

# Library

The library is split across multiple panels: 

- The Process library: {% include shortcut.html content="Ctrl+Shift+P" %}
- The system library: {% include shortcut.html content="Ctrl+Shift+B" %}
- The project library: {% include shortcut.html content="Ctrl+Shift+L" %}

## Process library

This pane shows the processes available to add to the score: automations, audio effects, etc. Everything is there ! 

![Processes]({{ site.img }}/reference/panels/processes.png "Processes")

The top part shows the list of available processes, grouped by category.
Processes there can be dragged to the score.

The middle part shows available presets for the selected processes.
Presets can also be dragged to the score.

The bottom part shows information on the selected process.

### Categories and preset descriptions

File-backed process entries can be grouped into nested
categories derived from their containing folders. Expand the category tree to find
related shaders, scripts and other supported library files; the exact entries depend
on the installed packages and process plug-ins. Files in a process's default preset
folder can appear directly beneath that process rather than beneath another wrapper.

The preset list remains associated with the selected process. A preset may carry an
optional `Description` in its `.scp` JSON metadata; hover over that preset to read it
as a tooltip. A missing description does not prevent a preset from loading.
See [Presets]({{ site.baseurl }}/presets.html) for saving and reusing presets.

### Package and source updates

When an installed package has an update, the Process library can display a notice
with an **Update** link to the **Packages** settings page.

This is separate from the inspector's **Update** button for a process taken from an
external file. For process types that support source refresh, that button appears
when the source is out of date and replaces the process with the current file version.
It is an undoable edit, not an automatic rewrite of every existing process when a
package changes. Review the result before continuing playback.

### Fast creation of effect chains

To allow easy experimentation, double-clicking on a process or preset will 
add it and connect it, if possible, to the currently selected process in the score,
or to the currently selected port if a port is selected.

![Adding processes]({{ site.img }}/reference/panels/process-add.gif "Processes adding")

If nothing is selected, the process will be added to the currently displayed interval.

> Note: that means that by default, if nothing is selected, the processes may go at the bottom slot and won't be visible without scrolling to the bottom of the score.


## System library

This pane displays content shared across all scores. In a normal installation its
folder is `<Documents>/ossia/score/packages`. The **Library** settings change the root
directory above `packages`.

On first interactive launch, score offers to download the
[User Library](https://github.com/ossia/score-user-library), containing pre-existing
presets and other content. It is installed in `packages/default`.
Personal content belongs in `packages/user`.

Content installed through the [package manager]({{ site.baseurl }}/package-manager.html)
also appears here. SDKs and native support packages are stored separately and are not
ordinary library items.

The process-library scan is asynchronous, so large packages may take time to appear.
Restart if manually copied content is not discovered. A library rescan does not replace
running native libraries: restart after installing or changing native support packages.

Various actions are possible:
- Dragging and dropping one or multiple files to the score.
- Double-clicking on files. For instance, double-clicking on a .score will open it.
- Right-click allows to open a folder in the system file explorer.
- Dragging and dropping processes from the score: one can save a preset at a specific place by dragging from the folder preset icon.

Here is an example of saving and loading a whole score as a preset, to embed it recursively in itself. 

![Saving and loading presets]({{ site.img }}/reference/panels/library-presets.gif "Library presets")

### Important folders in the default library
- `Skins`: contains skins which can be changed in the settings. The currently provided screens are adaptations for various colour-blindness schemes.

- `Util/metro_tick.wav` and `Util/metro_tock.wav`: replace these if you want to change the sound of the metronome.

## Project library
This pane displays the content of the current project folder: this is simply the folder in which the edited score is saved. Otherwise, it behaves exactly like the system library.

## Preview
For now, sound files are previewed when clicking on them ; playback can be started and stopped with the little play / stop button at the bottom-left.

![Audio preview]({{ site.img }}/reference/panels/library-play.gif "Audio preview")
