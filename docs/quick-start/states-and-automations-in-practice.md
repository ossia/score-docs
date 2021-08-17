---
layout: default

title: "States & automations in practice"
description: "States and automations in practice"

parent: Quick start
nav_order: 5

permalink: /quick-start/states-and-automations-in-practice.html
---
# States & automations in practice

In previous sections of this [quick start guide]({{ site.baseurl }}/quick-start.html), we saw two elementary methods to write scenarios for your project: saving & recalling some device's state as well as writing simple automations for its parameters. While elementary, these two very features still offer a lot of flexibility to author advanced scenarios for your creations project. This is made even more flexible given a handful of *score*'s practice-based workflow features. Rather than separating cue-like execution of messages toward your devices and time evolving processes such as automations, *score* offer a number of ways to easily mix two approaches in a unified workflow.

<!-- ## Combining states and automations -->

## Sequence mode

### Setting up auto-sequence mode
A workflow you might find useful is the `auto-sequence` mode. As of *score* version 3.0.0-b2, `auto-sequence` is an option that needs to be activated from *score* settings. To do so, bring *score* [Settings window]({{ site.baseurl }}/reference/preferences.html "*Score* settings window").

In the `Settings` window, select the `User interface tab` then make sure the `auto-sequence` option is toggled on.


![Auto-sequence Settings]({{ site.img }}/quick-start/states-and-automations-in-practice/auto-sequence-pref.png "Auto-sequence settings")

### Using auto-sequence

In previous sections, we saw how to drag parameters from the `Device explorer` to easily store your device's state on the timeline as well as drag some processes (in this case automation). `Auto-sequence` kind of allows to do both in one go.

In the example below, we will start by storing an initial state for our device. Then after making some changes to our device, rather than dropping again the parameters from the `Device explorer` to the timeline, we will use the blue `+` icon next to the state icon and drag the link to a later point in the timeline.

What happens here is twofold:
* storing a new state using that blue `+` button will store the device's state using the namespace selection defined in the previous stored state
* using the `auto-sequence` option, *score* will automatically create some automations for the parameter that changed between initial state and newly created state

> You may also store a new state by dragging from the blue `+` icon *without* `auto-sequence` mode activated. In that case, *score* will still use previous namespace selection to store parameters values but no automation will get created for changed parameters.

![Using auto-sequence mode]({{ site.img }}/quick-start/states-and-automations-in-practice/auto-sequence-mode.gif "Using auto-sequence mode")

Of course, once these automations get auto-magically created, you can still edit their behavior over time and do whatever pleasing changes to their curve. You may also remove an automation, should you want not to include a parameter continuous change.

### Note on multiple automations editing

In the example above, you can see multiple automation slots actually got superposed. You can bring to front any of the automations in background to edit it. To do so, click on the address bar at the top of the slot to open up the list of superposed parameters 'automation. Select in the contextual menu the one to edit. Once to front (displayed in red), it can be edited.

> When multiple automations are stacked, frontmost one is drawn with a red line, while the ones behind are drawn with a greyed out line

![Select from stack]({{ site.img }}/quick-start/states-and-automations-in-practice/stacked-slots.gif "Select from stack")

You can also remove an automation from the stack by clicking on a slot background. Bring the contextual menu using right-click and select `remove`.

![Remove automation]({{ site.img }}/quick-start/states-and-automations-in-practice/remove-automation.png "Remove automation")
