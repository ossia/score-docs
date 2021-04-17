---
layout: default
title: "What is score ?"
parent: Quick start
nav_order: 0

permalink: /docs/quick-start/what-is-score.html
category: "site-score"

description: "What is score ?"

tag: "Presentation"
visible: true
---

# What is *score* ?

*Score* offers advanced tools to ease the authoring of time exigent projects involving medias: flexible score for a live performance, interactive scenario for an intermedia installation, game-like state machine scenarios, etc. It thus provides a unified place to write automations for the parameters of any of the devices involved in the project, provides means to author efficient mappings from device A to device B or to modulate some devices parameters using generative processes and so on.

## Advanced time sequencing environment

When having to author scenarios for interactive art, music and sound performances, one often has to rely on two approaches:

- DAW/timeline-based softwares offering tools for fine time editing and parameters automation
- cue-based softwares offering great flexibility in live situation

While both approaches have numerous advanges, they also draw some limits in some advanced media-based productions: First type hardly offers (if any) flexibility in live situation regarding how events actually evolve in time. Second type makes it hard if possible at all to control precisely processes evolving over time.

*score* thus aims at bridging the gap between these two models in a unified environment. By combining a flexible timeline with a patch-like authoring process, it allows to write [precisely timed processes such as automations]({{ site.baseurl }}/docs/quick-start/writing-automations.html) or more fancy parameters control and modulation while still [maintaining some variations as the scenario is executed]({{ site.baseurl }}/docs/quick-start/breaking-the-timeline.html). But it also allows to author [open and non linear scenarios](http://localhost:4000{{ site.baseurl }}/docs/quick-start/non-linear-timelines.html) yet still including some time-dependant processes.

![score scenario]({{ site.baseurl }}/assets/images/quick-start/what-is-score/score-main.png)

## Interoperability-based

*score 3.0.0* aims at fully integrate to every artist or musician's toolsets involved in advanced media authoring.

It allows to remotely control various commercial or custom software and hardware as well as to work with audio or video medias right from the app.

While *score* itself offers some audio and video features, it does not aim at being an "All in one" super software (hence forcing intermedia authors to give up their personnal toolset expertise). On the contrary, *score* was built from the ground up to be **as interoperable as possible**. Users remain thus free to use their tools of choice, be it their favorite VJing software, custom audio synthesis app or any specialized toolset.

![score main window]({{ site.baseurl }}/assets/images/quick-start/working-with-devices/ecosystem.png "score main window")

*score 3.0.0* supports a number of protocols such as [Midi]({{ site.baseurl }}/docs/reference-manual/devices-types/midiin-device.html), [Open Sound Control]({{ site.baseurl }}/docs/reference-manual/devices-types/osc-device.html), [OSCQuery]({{ site.baseurl }}/docs/reference-manual/devices-types/oscquery-device.html) or [serial]({{ site.baseurl }}/docs/reference-manual/devices-types/serial-device.html) making it easy to use score as the central hub of a project and thus author fine relationships between medias.

<!-- ## TODO Practice-based workflow -->