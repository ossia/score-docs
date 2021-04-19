---
layout: default

title: "Modular workflow"
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