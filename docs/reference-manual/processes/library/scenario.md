---
layout: default

title: Scenario
description: "The main process of ossia score"

parent: Processes
grand_parent: Reference

permalink: /processes/scenario.html
---

# Scenario
The Scenario process arranges states, intervals, triggers and conditions in time. It can contain other Scenario processes, allowing a score to be organized into nested sections rather than one flat timeline.

An interval determines when its processes execute; cables determine how they exchange data. Use timeline and nodal views as complementary views of this structure. See [Editing workflow]({{ site.baseurl }}/reference/editing-workflow.html) for selection, cable and paste gestures.

### Execution
- Putting stuff on the top start state for it to run with Reinitialize
- Putting stuff on the top end state for it to run when stop is pressed.

Double-click the time ruler or use **Play from here** to audition from another position. A double-click-and-drag on the ruler scrubs forwards or backwards; releasing restores the previous speed. See [Seek and transport]({{ site.baseurl }}/common-practices/9-seek-and-transport.html) for how seeking evaluates interactive events and earlier states.

### Keyboard shortcuts

- In a scenario with the navigation keys ( {% include shortcut.html content="↑" %}, {% include shortcut.html content="↓" %}, {% include shortcut.html content="→" %}, {% include shortcut.html content="←" %}).
- To the parent scenario with {% include shortcut.html content="Ctrl+Alt+↑" %}.

- Unroll all intervals' racks in a scenario {% include shortcut.html content="Ctrl+Alt+U" %}
- Fold all intervals' racks in a scenario {% include shortcut.html content="Ctrl+Alt+F" %}

### Speed control

Speed sliders appear on intervals while playing. To reset it:  {% include shortcut.html content="Ctrl+Right Click" %}

Scrubbing can temporarily run time backwards. This changes the time supplied to processes, not the history of actions already sent to external devices.

### Interpolate states

Select an interval whose start and end states contain different numeric values for the same device address. In the interval inspector, use **Interpolate states** (**Ctrl+K**) to create automation processes between those endpoint values.

The action operates on the selected intervals and skips addresses already automated there. It does not interpolate arbitrary strings or create missing endpoint messages. Edit the generated curves with the [[Automation]] process editor.

### List of drag'n'drops possible

#### On intervals
- Drop from the device explorer to an interval: create an automation curve.
- Drop from the library explorer to an interval: create a process.
- Drop a media from the library or the system to an interval: create a process.
- Drop from the object list into a slot or in the interval

#### Moving processes around
- Drag the little ☰ icon somewhere else in the timeline.
  - In the same interval: reorders
  - In another interval: moves the process
  - In a blank space: creates a new interval from there and moves the process

#### On processes
- Generally, dropping a media on a process changes the content of the process.
   * dropping a new sound file on a sound process
   * dropping a new address from the explorer on an automation
   * etc...
   * file bugs if you see a case not implemented !

#### On states
- Message list: add messages to the state
- .cues files (created by dropping a state into the library)
- .layer files
- Drag a process's preset button onto a state to capture its controls as a cue. Hold **Ctrl** during the drop to choose whether to include supported process state beyond its controls. See [Capture cues and publish named controls]({{ site.baseurl }}/reference/editing-workflow.html#capture-cues-and-publish-named-controls).


#### From states
- It is possible to select messages in a state and drop them either in the scenario, or on another state


# Intervals

Execution controls: intervals can be started, stopped, and muted.

The containing interval must be active for its processes to run. Adding a process during playback does not automatically activate a future or inactive interval.

# Graph links

Graph links connect scenario elements without assigning them an ordinary fixed timeline duration. They are useful for expressing relationships that follow the interactive graph rather than a predetermined sequence of durations.

# Conditions

A condition decides whether an event happens. Its inspector also defines its behavior when seeking: evaluate the live expression or force a true/false outcome for the offset operation. A condition can be published by name using **Scriptable**; see [Editing workflow]({{ site.baseurl }}/reference/editing-workflow.html#capture-cues-and-publish-named-controls).


## Keyboard shortcuts
Pressing suppr / backspace when a condition is selected removes it.

# Triggers

- It is possible to choose the desired behaviour for off-time triggers : either triggering them stops and restarts the subgraph immediately, or it stops the subgraph and will only restart it after a new triggering. This choice is done in the trigger inspector.

## Keyboard shortcuts
Pressing suppr / backspace when a trigger is selected removes it.

## References and nested editing

Paste follows the most recently focused or selected object and its nearest suitable container, including inside nested scenarios. When copied content contains internal references, these can target the corresponding copies instead of the originals.

Use **Broken references...** in the Windows menu to locate unresolved references and **Rebind...** to point a selected reference at a replacement. See [Repair broken references]({{ site.baseurl }}/reference/editing-workflow.html#repair-broken-references).