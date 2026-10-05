---
layout: default
title: Tracking zones to MIDI
description: "Turn zone-entry events into notes and inspect the tracking data that triggers them."
parent: AI and tracking
grand_parent: Examples
permalink: /examples/ai/tracking-to-midi.html
score: /examples/ai/tracking-to-midi.score
---

# Tracking zones to MIDI

Turn zone-entry events into notes and inspect the tracking data that triggers them.

[Download the example]({{ site.baseurl }}/assets/scores/examples/ai/tracking-to-midi.score)

## Requirements

Install ONNX/Pose Detector support and the [LivePose model pack](https://github.com/sat-mtl/livepose/releases/tag/model-storage). RetinaFace uses `packages/pose-detector/detectors/det-face-retinaface-mobile.onnx` in the user library. The graph also uses the default `Presets/Javascript/tracking-zones/tracking-zones.qml` preset, Jk Object filter, FoMo from Synthimi, Airwindows, and Faust. Select a camera for `Camera:/` and a working audio output for `audio:/out/main`.

## Run and inspect

Open tracking-zones' custom interface and start playback. Simulation is enabled in the saved patch: use it to inspect zone events independently of camera detection, then turn it off to work with real face detections. Pose Detector's Detection output is connected to Source 1. For a model configured for multiple independent detections, the Poses output is the corresponding collection to connect instead.

The Events output feeds two Object filters:

- `.[] | select(.type == "enter") | .zone` writes `zones:/enter`.
- `.[] | select(.type == "exit") | .zone` writes `zones:/exit`.

The OSC device listens on UDP 9997 and sends to `127.0.0.1:9996`. Pulse to Midi reads `zones:/enter`, generates notes with default pitch 53 and pitch randomization 24, and sends them through a Lydian Midi scale into FoMo's Port of Spain preset. The saved exit branch reports departures; it is not connected as a note-off command. Note duration is controlled by Pulse to Midi.

## Expected result

Cross a configured zone boundary and compare the Events/Enter displays with MIDI display. The note envelope also modulates smoothDelay and IronOxideClassic2 before Lowpass2 reaches the parent audio mix. Begin quietly: the saved delay feedback is about 92.5%. The Lightness sampler receives the annotated camera texture but has no Positions connection or downstream Samples cable; it is not the note trigger in this graph.
