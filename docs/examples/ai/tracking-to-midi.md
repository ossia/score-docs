---
layout: default
title: Tracking zones to MIDI
description: "An example showing how to trigger MIDI notes with motion tracking"
parent: AI and tracking
grand_parent: Examples
permalink: /examples/ai/tracking-to-midi.html
score: /examples/ai/tracking-to-midi.score
---

# Tracking zones to MIDI

![Pulse to Midi connected to Midi scale and Midi Envelope in the tracking patch]({{ site.baseurl }}/assets/scores/thumbnails/examples-ai-tracking-to-midi.png)

This example demonstrates turning movement through zones into musical events. Entering a region triggers a note, providing a starting point for a camera-controlled instrument or interactive installation.

{% include try-on-web.html %}

[Download the example]({{ site.baseurl }}/assets/scores/examples/ai/tracking-to-midi.score)

## Requirements

Install ONNX/Pose Detector support and the [LivePose model pack](https://github.com/sat-mtl/livepose/releases/tag/model-storage). RetinaFace uses `packages/pose-detector/detectors/det-face-retinaface-mobile.onnx` in the user library. The graph also uses the default `Presets/Javascript/tracking-zones/tracking-zones.qml` preset, Jk Object filter, FoMo from Synthimi, Airwindows, and Faust. Select a camera for `Camera:/` and a working audio output for `audio:/out/main`.

## Try it

Open tracking-zones' custom interface and start playback at a low listening level. Simulation is enabled in the saved patch: use it to explore zone events without relying on camera detection, then turn it off to work with real face detections.

Cross a configured zone boundary and compare the event displays with the MIDI notes. Try changing the zones or the note settings to alter the relationship between position and sound. The notes are constrained to a Lydian scale and played by FoMo; their envelopes also influence the audio effects.

## Tracking and note behavior

The saved patch uses Pose Detector's Detection output for Source 1. For a model configured for multiple independent detections, connect the Poses collection instead.

The Object filters separate entry and exit events into `zones:/enter` and `zones:/exit`. Only entry events trigger notes here: departures are reported, but do not send note-off commands. Pulse to Midi controls note duration. The OSC device listens on UDP 9997 and sends to `127.0.0.1:9996`.

Begin quietly, especially when experimenting with the delay: its saved feedback is about 92.5%. The Lightness sampler is not the note trigger in this example; its positions and sampled output are unconnected.
