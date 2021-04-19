---
layout: default

title: "Writing automations"
description: "Writing automations"

parent: Quick start
nav_order: 4

permalink: /quick-start/writing-automations.html
---

## Writing continuous parameter control

*Score* provides numerous features to control continuously your devices' parameters over time. These are provided through the `Process` library available by clicking on the icon at the bottom left of score window (or using {% include shortcut.html content="Ctrl+Shift+P" %} shortcut).

![Process library panel]({{ site.img }}/quick-start/score-authoring/process_library.gif "Process library panel")

In the example below, we will just create a basic breakpoint function-based automation for one of our device's parameter, by selecting the `automation (float)` in the Process library, then drag & drop it where we want it on the timeline. 

![Creating automation]({{ site.img }}/quick-start/score-authoring/create_automation.gif)

When done, you will see on the timeline a simple 1 segment linear default automation. Let's now assign our device parameter as a destination for this simple automation process.

Click on the automation's slot top bar to bring its inspector. Now from the `Device explorer` drag the desired parameter on the address field. The automation is now assigned to our parameter.

When playing the scenario, our device's parameter will get driven by an ascending ramp as the playhead goes across the automation slot.

Of course, you may refine your automation function by double-clicking in the automation slot to add more points or select a segment and use {% include shortcut.html content="Shift+Drag" %} to add curvature to the segment as well as using other advanced features as detailed in the [Automation reference page]({{ site.baseurl }}/processes/automation_float.html).

> You can extend your automation slot by dragging along the timeline its top right corner (the blue dot). By default, slot will get extended will preserving the automation length so you can further write your automation. You may also drag it using {% include shortcut.html content="Cmd+Drag" %} to scale the automation as the slot gets extended along the timeline

### Full size edit

When further precision is required to edit your automation, you can double-click the name above the automation slot (here "automation (float)" to zoom in the slot and edit the automation in full size.

![Full size edit]({{ site.img }}/quick-start/score-authoring/fullsize-edit.gif)

When done editing, you can go back to your scenario full view using {% include shortcut.html content="Cmd+↑" %} or clicking on your scenario name beneath the time ruler.

![Leaving full size edit]({{ site.img }}/quick-start/score-authoring/leaving_full_size.png)

<!-- ### Stacked processes

> Note that editing -->

<!-- ### Enhanced process creation workflow

> score provides a number of shortcuts to ease the authoring workflow such as automatic `Process` selection based on dropped parameter type attribute, tween mode, interpolation and more. See the dedicated section for more details. -->