---
layout: default

title: "Audio routing"
description: "How audio goes from a process to another"

parent: In depth

permalink: /in-depth/audio-routing.html
---

# Audio routing
* There is an implicit routing from child process to parent interval, and from interval to parent scenario, recursively up to the top of the score.

* The audio output of the top interval is routed by default to the main stereo output of the audio interface defined in Audio Preferences.

* When connecting an audio outlet to another audio inlet, propagation is removed. This means that the dry output of the source process will not be mixed in its parent interval. This can be toggled by selecting the port, in the [[inspector]].