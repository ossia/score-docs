---
layout: default
title: "Processes"

parent: Reference manual
has_children: true

nav_order:

permalink: /docs/reference-manual/processes.html
category: "site-score"

description: "Processes"

tag: "Presentation"
visible: true
---

# Processes

*score* comes with a number of included processes. These cover various needs of action for advanced parameter control.

This section of the manual covers the general usage of Processes as well a detailed documentation of each included Processes.

## General description

*score* allows to handle a number of actions evolving through a defined amount of time. These processes can either be actions evolving during a given duration, such as automation of a given device's parameter, or actions activated only in a defined duration, such as mapping or LFO modulations.

Processes are attached to an interval in the scenario.


# Basics

## Create processes

### Using drag & drop

#### From Device explorer

Processes can be created by drag & dropping parameters from the `Device explorer` onto an existing interval in the scenario. The interval to which processes will be attached turns to yellow as the mouse with selection hovers it.

![Dropping parameters](/score-docs/assets/images/reference-manual/processes/dropping-parameters.png "Dropping parameters")

The `Device explorer` selection may contain one or several parameters. When multiple parameters are dropped, processes get stacked in different layers.

#### From Libraries

Processes can also be created by drag & dropping the desired process from the `Process library` or the `User library` in the scenario. When doing so, *score* automatically creates the interval to which process will get attached.

![Dropping processes](/score-docs/assets/images/reference-manual/processes/dragging-processes.gif "Dropping processes")

You may as well drop a process onto an existing interval.

> Note that both namespace selection and processes selection can be dropped onto an interval to which some processes are already attached. Depending on the type of processes, these may be created on top of processes already in place or at a slot below.

Audio, video and script files (Faust DSP, GLSL fragment shader, JS script...) can also be drag'n'dropped inside a scenario from your desktop's file manager.
By default, dropping several processes at the same time stacks them in the same interval.
Holding the Maj key while dropping will create sequential intervals for each item in the selection.

![Parallel or serial processes](/score-docs/assets/images/reference-manual/processes/parallel-or-serial-processes.gif "Parallel or serial processes")

### Create from interval

Processes can be created from an interval's widgets. Hover the interval to which attach a process to display the widget. Click the `+` widget to open the `Add process` window.

![Process addition widget](/score-docs/assets/images/reference-manual/processes/add-process-from-interval.png "Process addition widget")

From the `Add process window`, browse the various Processes types in the left panel, then choose the desired one. When done, click `+` button to attach process to the interval.

![Add process window](/score-docs/assets/images/reference-manual/processes/add-process-from-interval-window.png "Add process window")

<!-- ### TODO Object menu -->

## Remove existing processes

### Using keyboard

To remove a process, select it (for example by clicking on the slot background) and choose `Remove` from the `Object` menu ({% include shortcut.html content="Suppr" %}/{% include shortcut.html content="Backspace" %} key).

> As of score v3.0.0-a19, make sure the process you want to remove is properly selected when bringing it to front (for example, check the inspector)

### From Graph inspector

Processes can also be deleted from the `Graph inspector` at the top of *score*'s right panel. In the scenario, select the interval the process to remove is attached to. In the `Graph inspector`, browse through the attached processes and select the one to remove. Right-click to open the contextual menu and choose `Remove` (or use {% include shortcut.html content="Suppr" %}/{% include shortcut.html content="Backspace" %} key).

![Remove from Graph inspector](/score-docs/assets/images/reference-manual/processes/remove-process-from-graph.png "Remove from Graph inspector")


# Edit processes

## Fullsize edit

Processes can be edited in full size. This is especially handy when you want to precisely edit a process such as an automation or mapping function.

To display the process in full size, double-click on the interval the process is attached to. Process is now displayed using *score* central panel full width. Note that if several processes are attached to an interval, open them in full size will display all at once juxtaposed as shown below (see the `Multiple processes` interval).

To exit full size mode (go back to parent scenario), click the desired node of the path displayed at the top or use the {% include shortcut.html content="Ctrl+Alt+↑" %} shortcut.

![Edit process in full size](/score-docs/assets/images/reference-manual/processes/process-fullsize-edit.gif "Edit process in full size")

## Process Loops

Time-based processes such as automations, media and sub-scenarios can be looped for as long as their parent interval is active. When selecting a process, either from the object panel
or by clicking on process header, the loop option will appear in the `Inspector`.

![Process looping](/score-docs/assets/images/reference-manual/common-practices/loopProcess.gif "Process looping")

# Manage processes

## Fold/unfold attached processes

Processes attached to an interval can easily be fold/unfold. This comes up especially usefull when working with a lot of processes while still maintaining some screen space and the scenario readable.

To do so, click the blue arrow on top of the processes to fold/unfold.

![Fold/unfold processes](/score-docs/assets/images/reference-manual/processes/fold-unfold-processes.gif "Fold/unfold processes")

When selecting an interval, attached processes can also be fold/unfold using the `Show processes` & `Hide processes` entries from the `Object` menu.

![Fold/unfold processes](/score-docs/assets/images/reference-manual/processes/fold-process-menu.png "Fold/unfold processes")


<!-- TODO (or NOT TO DO...) contextual menu
TODO (or NOT TO DO...) View menu -->

## Stacked slots

Time-based processes (that is, processes whose *x* represents time, such as automations, media files) can be stacked on a same slot. This is the default presentation when dragging some parameters onto an interval or dragging a process from library onto an interval. In that case, top-most process is displayed in full color while processes in other layers or displayed in semi transparent color. You can of course re-arrange them as you want.

### Bring to front

To change which process to display top-most, mouse over to the top of the process slot displaying the destination address. Clicking the address bar opens up a contextual menu listing all layered processes. Selecting one in the menu brings it to front.

![Bring process to front](/score-docs/assets/images/reference-manual/processes/bring-to-front.png "Bring process to front")


### Move to new slot

Processes can also be juxtaposed in several slots rather than stacked on top of the other. Grab the handle at the top left corner of the slot and drag & drop it on another slot to move it above another process or between different slots to insert it.

![Moving processes](/score-docs/assets/images/reference-manual/processes/moving-processes.gif "Moving processes")


> Processes can also be dragged & attached to a new interval

<!-- TODO ### Patchable processes -->