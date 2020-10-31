---
layout: default
title: "Processes"

parent: In depth

nav_order: 

permalink: /docs/in-depth/processes.html
category: "site-score"

description: "Processes"

tag: "Presentation"
visible: true
---

# Processes

*score* allows to handle a number of actions evolving through a defined amount of time. These processes can either be actions evolving during a given duration, such as automation of a given device's parameter, or actions activated only in a defined duration, such as mapping or LFO modulations. 

Processes are attached to an interval in the scenario.

## Create & remove processes

### Using drag & drop

#### From Device explorer

Processes can be created by drag & dropping parameters from the `Device explorer` onto an existing interval in the scenario. The interval to which processes will be attached turns to yellow as the mouse with selection hovers it.

![Dropping parameters](/score-docs/assets/images/in-depth/processes/dropping-parameters.png "Dropping parameters")

The `Device explorer` selection may contain one or several parameters. When multiple parameters are dropped, processes get stacked in different layers.

#### From Libraries

Processes can also be created by drag & dropping the desired process from the `Process library` or the `User library` in the scenario. When doing so, *score* automatically creates the interval to which process will get attached.

![Dropping processes](/score-docs/assets/images/in-depth/processes/dragging-processes.gif "Dropping processes")

You may as well drop a process onto an existing interval.

> Note that both namespace selection and processes selection can be dropped onto an interval to which some processes are already attached. Depending on the type of processes, these may be created on top of processes already in place or at a slot below.

### Create from interval

Processes can be created from an interval's widgets. Hover the interval to which attach a process to display the widget. Click the `+` widget to open the `Add process` window.

![Process addition widget](/score-docs/assets/images/in-depth/processes/add-process-from-interval.png "Process addition widget")

From the `Add process window`, browse the various Processes types in the left panel, then choose the desired one. When done, click `+` button to attach process to the interval.

![Add process window](/score-docs/assets/images/in-depth/processes/add-process-from-interval-window.png "Add process window")

<!-- ### TODO Object menu -->

### Remove existing processes

#### Using keyboard

To remove a process, select it (for example by clicking on the slot background) and choose `Remove` from the `Object` menu ({% include shortcut.html content="Suppr" %}/{% include shortcut.html content="Backspace" %} key).

> As of score v3.0.0-a19, make sure the process you want to remove is properly selected when bringing it to front (for example, check the inspector)

#### From Graph inspector

Processes can also be deleted from the `Graph inspector` at the top of *score*'s right panel. In the scenario, select the interval the process to remove is attached to. In the `Graph inspector`, browse through the attached processes and select the one to remove. Right-click to open the contextual menu and choose `Remove` (or use {% include shortcut.html content="Suppr" %}/{% include shortcut.html content="Backspace" %} key).

![Remove from Graph inspector](/score-docs/assets/images/in-depth/processes/remove-process-from-graph.png "Remove from Graph inspector")

## Fullsize edit

Processes can be edited in full size. This is especially handy when you want to precisely edit a process such as an automation or mapping function.

To display the process in full size, double-click on the interval the process is attached to. Process is now displayed using *score* central panel full width. Note that if several processes are attached to an interval, open them in full size will display all at once juxtaposed as shown below (see the `Multiple processes` interval).

To exit full size mode (go back to parent scenario), click the desired node of the path displayed at the top or use the {% include shortcut.html content="Ctrl+Alt+↑" %} shortcut.

![Edit process in full size](/score-docs/assets/images/in-depth/processes/process-fullsize-edit.gif "Edit process in full size")

## Organize processes

### Fold/unfold attached processes

-> using interval arrow
-> using contextual menu

### Manage slots

#### Bring to front

#### Move to new slot

> Processes can also be dragged to a new interval