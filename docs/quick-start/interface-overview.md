---
layout: default

title: "Interface overview"
description: "Interface overview"

parent: Quick start
nav_order: 1

permalink: /quick-start/interface-overview.html
---

# *score* interface overview

*Score* provides a unique window embedding all main features and toolboxes. From it, you can setup how your media applications and *score* will communicate, observe their parameters value navigate through their namespace in a structured way, store some parameters value in snapshots, draw some automations, structure you scenario in flexible ways and more.

![score main window]({{ site.baseurl }}/assets/images/quick-start/score-interface/score-main-window.png "score main window")

All can be done from one of the 3 UI areas described below.

## Explorer panel

On the left of *score* main window is the `Explorer panel`. This is where you can browse and manage the various contents needed for your project.

![Device explorer]({{ site.baseurl }}/assets/images/quick-start/score-interface/device_explorer.png "Device explorer")

It comprises 4 main sections that can be switched using the icon at the bottom:

![Explorer main panels]({{ site.baseurl }}/assets/images/quick-start/score-interface/explorer-panels.png)

1. [Device explorer]({{ site.baseurl }}/reference/glossary.html#device-explorer): This is where you can setup the [devices]({{ site.baseurl }}/reference/glossary.html#device) (hardware or software devices on the network) you want to control from *score*.
  The `Device explorer` also offers a way to monitor or browse devices involved in your project, inspect its parameters and their behavior.
  This also is where you can grab parameters you want to save in a snapshot, write automations on as explained in the following pages.
2. [Processes explorer]({{ site.baseurl }}/reference/glossary.html#processes-explorer): This is where you can browse and select some [processes]({{ site.baseurl }}/reference/glossary.html#process) to use in your scenario to control various parameters of your devices or other processes.
3. [User library explorer]({{ site.baseurl }}/reference/glossary.html#user-library). This is where you can access some user defined assets. These can be devices setups, presets, processes collections amongst other things.
4. [Project folder]({{ site.baseurl }}/reference/glossary.html#project-folder): This is where you can browse the content of the current project.


# Scenario editor panel

A the center of score main window is the scenario editor. This is where you can write and edit the various parts of your project's flexible and interactive scenario.

From there you can create some snapshots by dragging some parameters from the `Device explorer` at a particular time frame, create some automations by dragging parameters from the `Device explorer` on an interval, drop some audio or video medias from your hard drive to integrate them in your scenario.

![Scenario editor]({{ site.baseurl }}/assets/images/quick-start/score-interface/scenario_editor.png "Scenario editor")

# Objects inspector panel

On the right part of score main window is the `Object inspector`. It allows to dynamically inspect and setup the selected objects in the scenario.

![Object inspector]({{ site.baseurl }}/assets/images/quick-start/score-interface/dynamic_inspector.png "Object inspector")

1. Top part of the inspector is the structural context of the selected object. For example, the parent interval a process is attached to, the time point a state is placed on and its linked states, etc.

2. Bottom part are the various parameters of the selected object in the scenario: start time, duration and parameter address of an automation, source and target addresses of a mapping, its domain ranges, etc.


# UI controls

* Use right-click to edit controls precisely.

* Many controls are available: sliders, color choosers, toggles...