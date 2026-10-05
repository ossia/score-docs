---
layout: default

title: Shortcuts
description: "Default keyboard shortcuts in ossia score"

parent: Reference

permalink: /reference/shortcuts.html
---

Below is a list of shortcuts available in *score* listed by scope of usage.

Shortcuts depend on the focused view. In particular, **Ctrl+Enter** compiles in a code editor but reinitializes in the score view, and **Ctrl+Space** requests completion in a text prompt rather than playing the score.

# General

- {% include shortcut.html content="Ctrl+Shift+D" %}: Show `Device explorer` panel
- {% include shortcut.html content="Ctrl+Shift+P" %}: Show `Processes library` panel
- {% include shortcut.html content="Ctrl+Shift+B" %}: Show `System library` panel
- {% include shortcut.html content="Ctrl+Shift+L" %}: Show `Project library` panel
- {% include shortcut.html content="Ctrl+Shift+C" %}: Show `Console` panel
- {% include shortcut.html content="Ctrl+Shift+G" %}: Show `Messages log` panel


# Conditions

- {% include shortcut.html content="Suppr" %}/{% include shortcut.html content="Backspace" %}: Delete selected `condition`

# Device explorer

- {% include shortcut.html content="Esc" %}: De-select node

# Timeline

- {% include shortcut.html content="↑" %}, {% include shortcut.html content="↓" %}, {% include shortcut.html content="→" %}, {% include shortcut.html content="←" %}: Navigate through the various linked elements on the `Timeline`
- {% include shortcut.html content="Ctrl+Alt+↑" %}: Go back to parent scenario
- {% include shortcut.html content="Ctrl+Alt+U" %}: Unroll all processes attached to an interval
- {% include shortcut.html content="Ctrl+Alt+F" %}: Fold all processes attached to an interval


## Transport

- {% include shortcut.html content="Space" %} or {% include shortcut.html content="Ctrl+Space" %}: Play/pause the currently displayed interval.
- {% include shortcut.html content="Shift+Space" %}: Play the root score.
- {% include shortcut.html content="Enter" %}: Stop execution.
- {% include shortcut.html content="Ctrl+Enter" %}: Reinitialize (stop and send the initial state).
- Double-click the time ruler: Play from here. Hold the second click and drag to scrub.
- {% include shortcut.html content="Alt+Click" %} on an interval with the Play tool: Play that interval from its beginning.

## Nodal editing

- {% include shortcut.html content="Ctrl+Click" %}: Add/remove a node from the selection.
- {% include shortcut.html content="Ctrl+Drag" %} on empty canvas: Add nodes intersecting the selection rectangle.
- Drag an already-selected node: Move the selected group.
- {% include shortcut.html content="Ctrl+C" %} / {% include shortcut.html content="Ctrl+V" %}: Copy/paste selected processes and their internal cables; the destination follows the current editing context.
- {% include shortcut.html content="Delete" %}: Delete selected processes.

See [Editing workflow]({{ site.baseurl }}/reference/editing-workflow.html) for cable gestures and nested paste behavior.

# Piano roll

With notes selected and the piano roll focused:

- {% include shortcut.html content="↑" %} / {% include shortcut.html content="↓" %}: Transpose by one semitone.
- {% include shortcut.html content="Shift+↑" %} / {% include shortcut.html content="Shift+↓" %}: Transpose by one octave.

# Code editors

- {% include shortcut.html content="Ctrl+Enter" %}: Compile; also works with keypad Enter and in docked editors.
- {% include shortcut.html content="Ctrl+F" %}: Open search.
- {% include shortcut.html content="Ctrl+Space" %}: Request completion where the language provides a completer.
- {% include shortcut.html content="Tab" %} / {% include shortcut.html content="Shift+Tab" %}: Indent/unindent selected text.
- {% include shortcut.html content="Shift+Delete" %}: Delete the current line.
- {% include shortcut.html content="Esc" %}: Close search when open; otherwise a windowed editor can close. Docked editors are not dismissed by Escape.

# Console prompt

These apply while typing in the Console input, not the score view:

- {% include shortcut.html content="Enter" %}: Execute the entered command.
- {% include shortcut.html content="↑" %} / {% include shortcut.html content="↓" %}: Browse command history.
- {% include shortcut.html content="Ctrl+Space" %}: Request completion.
- {% include shortcut.html content="Ctrl+A" %} / {% include shortcut.html content="Ctrl+E" %}: Move to the start/end of the line.
- {% include shortcut.html content="Ctrl+B" %} / {% include shortcut.html content="Ctrl+F" %}: Move back/forward one character.
- {% include shortcut.html content="Ctrl+U" %} or {% include shortcut.html content="Ctrl+L" %}: Clear the input line, not the console output.
- {% include shortcut.html content="Ctrl+K" %}: Delete from the cursor to the end.
- {% include shortcut.html content="Ctrl+W" %}: Delete the preceding word.
- {% include shortcut.html content="Ctrl+T" %}: Transpose the characters immediately before and at the cursor.

# Trigger

- {% include shortcut.html content="Suppr" %}/{% include shortcut.html content="Backspace" %}: Delete selected `trigger`
