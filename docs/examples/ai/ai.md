---
layout: default
title: AI and tracking
description: "Turn a camera into a visual or musical controller: follow a facial landmark, draw a motion trail, or trigger notes at zone boundaries."
parent: Examples
has_children: true
permalink: /examples/ai
---

# AI and tracking

Use a camera when a performer's movement should shape the work without a handheld controller. These examples connect movement to a result in three different ways:

- [Face landmarks and radial blur]({{ site.baseurl }}/examples/ai/pose-detection.html): start here to make an effect follow one point on a face. The data displays help you understand coordinates before designing a mapping.
- [Face tracking to native geometry]({{ site.baseurl }}/examples/ai/tracking-to-geometry.html): accumulate positions into a visible motion trail. This is the more technical option: the particle buffer must be matched to the detector's output.
- [Tracking zones to MIDI]({{ site.baseurl }}/examples/ai/tracking-to-midi.html): turn crossing a boundary into a note instead of continuously changing a parameter. Its simulation mode lets you explore the interaction before connecting a camera.

The downloads include face-tracking models; score still needs ONNX/Pose Detector support and access to a camera for live tracking. Begin with one face and a stable view, then use the detection displays to distinguish a lost detection from a problem in the media mapping.
