---
layout: default
title: "Basics"

parent: Processes
grand_parent: Reference manual


nav_order: 1

permalink: /docs/reference-manual/processes/basics.html
category: "site-score"

description: "Processes"

tag: "Presentation"
visible: true
---

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

Audio, video and sript files (faust dsp, glsl fs, javaScript ...) can also be draged & droped inside a scenario from your desktop's file manager.
By deffault, droping sevral processes at the same time stacks them in the same interval. 
Holdig the Maj key while dropping will create sequential intervals for each items in the selection. 

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
