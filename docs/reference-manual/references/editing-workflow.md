---
layout: default

title: Editing workflow
description: "Timeline navigation, patch editing, live changes and editor placement"

parent: Reference

permalink: /reference/editing-workflow.html
---

# Editing workflow

Timeline and nodal views edit the same processes: changing the view does not create a second copy of the patch.

## Navigate and audition

- Use the interval path in the navigation bar to return to a parent interval. It remains available when a script editor or custom UI occupies the central view; navigating brings the score back.
- Double-click the time ruler to play from that position. Keep the second click held and drag to scrub forwards or backwards. Releasing restores the previous playback speed and continues playback near the release position.
- The Play tool also starts playback from the scenario background and supports dragging to scrub. On a state it sends that state's content; on an interval it plays from the clicked date. Hold **Alt** when clicking an interval with the Play tool to play that interval from its beginning.
- The right-click **Play from here** action is another way to seek. A later ordinary start of an interval begins at its beginning, not at a previous play-from-here offset.

Seeking an interactive score is not equivalent to replaying a recorded performance: score uses the intervals' visual durations to decide which events precede the target. See [Seek and transport]({{ site.baseurl }}/common-practices/9-seek-and-transport.html) for state-value compilation, conditions and start markers.

## Select, move and paste nodes

In a nodal view, **Ctrl+click** adds or removes a node from the selection. **Ctrl+drag** on empty canvas draws a selection box and adds the intersecting nodes. Drag an already-selected node to move the group; Delete removes the selected processes. Ordinary dragging on the nodal interval's empty canvas pans it, as does middle-button dragging.

Copying selected processes includes the cables between them. Paste follows the object most recently focused or selected, then its nearest suitable container: processes go in an interval, while states and intervals go in a scenario. This applies inside nested processes too. Click the intended destination before pasting rather than relying on the top-level view alone.

A newly created nodal view is fitted around its content. Once you pan, zoom or resize it, your view takes precedence over automatic fitting. The nodal canvas position and zoom are retained when navigating away and back; returning to the timeline also retains its zoom.

## Connect and replace processes

Start a cable drag from the port circle **or its name**. Hovering the circle, label or associated control can show the port description. During a cable drag, moving to or beyond the viewport edge scrolls the view, making distant ports reachable.

- Drop on a compatible port to connect it. Dropping on a node can choose the first port of the matching type; check the resulting connection when several ports share that type.
- Drag an existing cable near its endpoint to move that end to another compatible port.
- Drag a new connection onto an existing cable to replace the corresponding end: an outlet replaces its source, an inlet replaces its destination.
- Drop a process or preset onto a cable to insert it into the chain. A compatible cable is highlighted when dragging a node over it.
- Drop a process or preset onto a node to replace it. Compatible first input/output connections are retained; additional ports are matched by **both name and type**. Unmatched ports cannot retain their cables, so inspect multi-port replacements before continuing a performance.

See [Timeline and patches]({{ site.baseurl }}/examples/basics/timeline-and-patches.html) for the relationship between time sequencing and signal routing.

## Edit while playing

Processes can be added, removed or edited during playback. New devices can also be added from the Device explorer without stopping. This does **not** make every device operation safe while running: stop execution before removing a device or changing its configuration or namespace. These structural editing actions remain restricted; script-driven device removal is also refused during execution.

A new process still needs an active interval and appropriate connections to produce output. Adding an object to an inactive part of a score does not itself trigger that part. For continuously running patches, use a trigger to keep the containing interval active. See [Live coding]({{ site.baseurl }}/common-practices/8-live-coding.html).

Address recording has a waiting phase: it can begin with the first incoming message, or with playback if Play is pressed while recording is waiting. This is parameter/message recording, not an audio-file recorder. See [Recording]({{ site.baseurl }}/in-depth/recording.html).

## Place code editors and custom UIs

Processes that provide a code editor or custom UI can place it in a **Window**, **Side panel** or **Central** view. Use the placement menu on the editor button, or the context menu of the relevant toggle or tab. Changing placement moves an open UI and updates the default for that kind of UI; a process's placement override is saved in the document.

For a central code editor, **Behind central editors → Background** lets the document's background output or watched texture remain visible behind the code. **None** gives a plain editor. See [Window device]({{ site.baseurl }}/devices/window-device.html) for background output setup, and [Score preferences]({{ site.baseurl }}/reference/preferences.html) for **Script editors**, **Process UIs** and **Behind central editors**.

Use **Compile** or **Ctrl+Enter** to submit code from any editor placement, including the keypad Enter key. A windowed editor can be closed with Escape; a docked editor is not closed by that shortcut. Compile and transport shortcuts depend on focus: Ctrl+Enter in a code editor compiles, whereas in the score view it reinitializes execution. See [Shortcuts]({{ site.baseurl }}/reference/shortcuts.html).

### Source update notices

For a JavaScript process linked to a source QML file, the inspector shows **Update** when the document's copy differs from the readable source. This is an explicit replacement with the file's current version, including its companion UI source; it is not automatic live reload. Save local code changes before accepting it if you need to keep them. An unavailable or empty source does not replace the document's copy with nothing. See [[Javascript]] for the scripting workflow.

## Capture cues and publish named controls

Drag a process's preset button onto a state to capture its current controls as state messages, or onto empty scenario space to create a cue. Hold **Ctrl** while dropping to choose among the available options:

- **Cue of the controls** captures the control values.
- **Cue of the controls and the state** also captures process state beyond its controls, where supported, such as its script.
- **Copy in a new box** creates an independent copy in a new interval; this choice applies to empty scenario space, not an existing state.

Only applicable choices appear. A drag from another document creates a copy rather than references to objects in the other document. Capturing a cue publishes the controls it needs so the messages can address the original process.

For explicit publication, enable **Scriptable** in the process inspector and set its **Scripting name**. The local device exposes it under `score:/controls`; individual control ports also have a **Scriptable** context-menu item. Trigger and condition inspectors have their own **Scriptable** checkbox, exposing names under `score:/triggers` and `score:/conditions`. Triggers receive impulses; conditions expose booleans. Use the displayed address/tooltips rather than guessing addresses from visible labels.

### Repair broken references

Open **Broken references...** from the Windows menu to list unresolved addresses, the objects holding them and the reported problem. Select a row and use **Locate** (or double-click it) to select the referring object. **Rebind...** lets you choose the replacement address for that reference. The change is undoable; it is not a global text replacement of every matching address in the score.

## Reduce interface work during playback

On low-power systems, [Score preferences]({{ site.baseurl }}/reference/preferences.html) provides **Execution GUI update** and **Execution Refresh Rate (hz)**. Disabling execution GUI updates reduces interface work; it is not a transport stop or a substitute for disabling costly processing. Background visual output is configured separately through the [Window device]({{ site.baseurl }}/devices/window-device.html).
