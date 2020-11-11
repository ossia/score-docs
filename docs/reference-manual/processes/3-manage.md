---
layout: default
title: "Manage processes"

parent: Processes
grand_parent: Reference manual

nav_order: 3

permalink: /docs/reference-manual/processes/manage.html
category: "site-score"

description: "Processes"

tag: "Presentation"
visible: true
---

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