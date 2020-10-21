---
layout: default
title: "Writing automations"
parent: Quick start
nav_order: 4

permalink: /docs/quick-start/writing-automations.html
category: "site-score"

description: "Writing automations"

tag: "Presentation"
visible: true
---

*Score* provides a number of tools to author precise control of the various devices involved in your project. Here we will focus on two basic elements:
- saving some devices' state (aka making snapshots) to be recalled during the execution of your scenario
- writing automations for some parameters

These illustrate a small part of the possibilities detailed later in the manual, but should get you started with *score* basic workflow.

## Storing your device current state

Saving your device current state on the timeline is as easy as dragging parameters you want to save from the `Device explorer` to where you will want them to be recalled in the timeline.

You can store at one place all parameters of a device or only part of, as well as parameters from different devices.

> Note that when selecting a node in the namespace, all parameters below get selected. You may also select a single or many parameters using standard key combinations:
> - {% include shortcut.html content="Shift+click" %}: Select all parameters between clicked parameter and previously selected one
> - {% include shortcut.html content="Ctrl+click" %}: Add selected parameter to the current selection

In the illustration below, we will just select the `gain` parameters from our ossia compatible Max synth patch and store their current value at the 5th bar of our scenario. As you drop these `gain` parameters on the timeline, you can see a blue disc circled in white gets created. Clicking this `state` icon, you can see in the inspector panel both parameters and their value listed as a tree-like view.

![Storing your device's current state](/score-docs/assets/images/quick-start/score-authoring/storing-states.gif)

If you start playing your scenario using the play button from the transport ({% include shortcut.html content="space" %} key), this state will get recalled and sent to your device as the playhead cross its position on the timeline. Should you need this state to be recalled earlier or later, just stop execution of the scenario (using stop button from the transport bar or {% include shortcut.html content="↵" %} key), then select and drag it along the timeline.

> If your device does not echo back its parameters changes to *score*, you can still grab the parameters to store from the `Device exporer` and drop them on the Timeline. Then from the state inspector panel, type the desired value next to each parameter. 
> You may as well type the desired values in the `Device explorer` first, then drag & drop the parameters on the timeline.

You may now make some changes to your device, then store this new state using the same drag & drop workflow.

Note that when storing our device's second state in the timeline, *score* proposes to bind this snapshot to different elements in the timeline, as displayed with a dashed grey line. For now, we will just make sure this snapshot is bound to the first one we placed on the timeline. But be sure to check [dedicated section](/docs/in-depth/structuring-your-scenario.html) in the manual to see the features *score* provides to help you structure elements in your scenario.

You can now start sequencing your devices' states in your scenario or read [detailed informations about states managment](/docs/in-depth/store-and-recall-devices-states.html).

<!-- ## Pro tip: setting an *init state* for your scenario -->

## Writing continuous parameter control

*Score* provides numerous features to control continuously your devices' parameters over time. These are provided through the `Process` library available by clicking on the icon at the bottom left of score window (or using {% include shortcut.html content="Ctrl+Shift+P" %} shortcut).

![Process library panel](/score-docs/assets/images/quick-start/score-authoring/process_library.gif "Process library panel")

In the example below, we will just create a basic breakpoint function-based automation for one of our device's parameter, by selecting the `automation (float)` in the Process library, then drag & drop it where we want it on the timeline. 

![Creating automation](/score-docs/assets/images/quick-start/score-authoring/create_automation.gif)

When done, you will see on the timeline a simple 1 segment linear default automation. Let's now assign our device parameter as a destination for this simple automation process.

Click on the automation's slot top bar to bring its inspector. Now from the `Device explorer` drag the desired parameter on the address field. The automation is now assigned to our parameter.

When playing the scenario, our device's parameter will get driven by an ascending ramp as the playhead goes across the automation slot.

Of course, you may refine your automation function by double-clicking in the automation slot to add more points or select a segment and use {% include shortcut.html content="Shift+Drag" %} to add curvature to the segment as well as using other advanced features as detailed in the [Automation reference page](/docs/references/processes/automation_float.html).

> You can extend your automation slot by dragging along the timeline its top right corner (the blue dot). By default, slot will get extended will preserving the automation length so you can further write your automation. You may also drag it using {% include shortcut.html content="Cmd+Drag" %} to scale the automation as the slot gets extended along the timeline

### Full size edit

When further precision is required to edit your automation, you can double-click the name above the automation slot (here "automation (float)" to zoom in the slot and edit the automation in full size.

![Full size edit](/score-docs/assets/images/quick-start/score-authoring/fullsize-edit.gif)

When done editing, you can go back to your scenario full view using {% include shortcut.html content="Cmd+↑" %} or clicking on your scenario name beneath the time ruler.

![Leaving full size edit](/score-docs/assets/images/quick-start/score-authoring/leaving_full_size.png)

<!-- ### Stacked processes

> Note that editing -->

<!-- ### Enhanced process creation workflow

> score provides a number of shortcuts to ease the authoring workflow such as automatic `Process` selection based on dropped parameter type attribute, tween mode, interpolation and more. See the dedicated section for more details. -->