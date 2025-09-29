---
layout: default

title: Modular workflow
description: "How to connect processes to create processing pipelines"
parent: In depth

permalink: /in-depth/modular-workflow.html
---

# Modular workflow

*ossia score* is built upon an entirely modular foundation.

At any point during edition, it is possible to switch from the temporal view, to the modular view,
in order to patch processes together as easily as possible.
The mode switching is operated by the buttons at the bottom of the software:

![Mode buttons]({{ site.img }}/in-depth/modular/buttons.png)

Some processes will always appear in patch view: audio effects, generators, and more generally
any process for which the effect does not depend on time-relative data.

Here is a small score viewed in temporal mode (the default):

![temporal view]({{ site.img }}/in-depth/modular/temporal.png)

Here is the same score viewed in modular mode:

![Modular view]({{ site.img }}/in-depth/modular/modular.png)

It is also possible to disable the cables when the patching has been done and one
wants to focus on the controls, the automations, etc:

![No cables]({{ site.img }}/in-depth/modular/nocables.png)

This functionality is accessible through {% include shortcut.html content="Alt+Shift+G" %}.

# Interactions

Outside of simply drag'n'dropping or double-clicking from the process library, there 
are multiple interactions available to add a process directly at a specific position in the data flow.

## Adding a process in the middle of a cable

If a cable is selected, and one doubles-clicks in the process library, the object is if possible inserted in the middle of the cable.

## Adding a process before a specific port

If an input port or control is selected, and one doubles-clicks on a process in the process library, if the process's first output is compatible with 
the port's type then the process will be connected before the port.

If there is an address in the port, it will be moved to the first input port of the newly-created process.
Likewise for the "Propagate" attribute on audio ports.

For instance, if a score contains an LFO object, with the address `foo:/bar` assigned to the LFO amplitude, and 
one selects the amplitude port and doubles-clicks on the Micromap object in the process library, the Micromap's input will be set to `foo:/bar`, a
cable will be created from the Micromap's output to the LFO's amplitude and the LFO's amplitude won't have the `foo:/bar` address set anymore.

## Adding a process after a specific port

The same than above applies for output ports.

## Adding a process after another

If an entire process is selected in the score, and one doubles-clicks on a new process to add in the library, score will try to connect to the first port.
This is useful for instance when creating audio or video effect chains as one can quickly connect new effects as they always have an audio or video input and output as first port by convention.

To make this workflow even faster, when a new process is created, it is selected, meaning that one does not even have to go to the score to add new objects.