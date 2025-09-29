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

### Fast creation of effect chains

To allow easy experimentation, double-clicking on a process or preset will 
add it and connect it, if possible, to the currently selected process in the score,
or to the currently selected port if a port is selected.

![Adding processes]({{ site.img }}/reference/panels/process-add.gif "Processes adding")

If nothing is selected, the process will be added to the currently displayed interval.

> Note: that means that by default, if nothing is selected, the processes may go at the bottom slot and won't be visible without scrolling to the bottom of the score.


## System library

This pane displays content shared across all scores. By default, it will be in `<Documents>/ossia/score/packages`

The location can be changed in the settings.

The [User Library](https://github.com/ossia/score-user-library) which contains pre-existing presets will be downloaded on first launch. Please contribute to it!

Packages installed through the package manager will also go there.

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
