---
layout: default
title: "Interface overview"
parent: Quick start
nav_order: 1

permalink: /docs/quick-start/interface-overview.html
category: "site-score"

description: "Interface overview"

tag: "Presentation"
visible: true
---

Score provides a unique window embedding all main features and toolboxes. From it, you can setup how your media applications and *score* will communicate, observe their parameters value navigate through their namespace in a structured way, store some parameters value in snapshots, draw some automations, structure you scenario in flexible ways, etc. All can be done from one of the 3 UI areas:

![score main window](/score-docs/assets/images/quick-start/score-interface/score-main-window.png "score main window")

# Device explorer

On the left of *score* main window is the [Device explorer](/score-docs/docs/references/glossary.html#device-explorer). This is where you can setup the [devices](/score-docs/docs/references/glossary.html#device) (hardware or software devices on the network) you want to control from *score*. 

The `Device explorer` also offers a way to monitor or browse devices involved in your project, inspect its parameters and their behaviour.

This also is where you can grab parameters you want to save in a snapshot, write automations on as explained in the following pages.

![Device explorer](/score-docs/assets/images/quick-start/score-interface/device_explorer.png "Device explorer")

# Scenario editor

A the center of score main window is the scenario editor. This is where you can write and edit the various parts of the flexible and interactive scenario of your project.

From there you can create some snapshots by dragging some parameters from the `Device explorer` at a particular time frame, create some automations by dragging parameters from the `Device explorer` on an interval, drop some audio or video medias from your harddrive to integrate them in your scenario.

![Scenario editor](/score-docs/assets/images/quick-start/score-interface/scenario_editor.png "Scenario editor")

# Objects inspector

On the right part of score main window is the `Object inspector`.It allows to dynamically inspect and setup the selected objects in the scenario.

![Object inspector](/score-docs/assets/images/quick-start/score-interface/dynamic_inspector.gif "Object inspector")

On the top part of the inspector is the structural context of the selected object. For example, the parent interval a process is attached to, the time point a state is placed on and its linked states, etc.

On the bottom part are the various parameters of the selected object in the scenario: start time, duration and parameter adress of an automation, source and target addresses of a mapping, its domain ranges, etc.