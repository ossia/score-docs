---
layout: default

title: LSL device
description: "Receive and publish Lab Streaming Layer channels"

parent: Devices
grand_parent: Reference

permalink: /devices/lsl-device.html
---

# LSL device

The **LSL** device connects score to [Lab Streaming Layer](https://labstreaminglayer.org/) streams. It can subscribe to external streams and create separate outgoing streams. These are distinct directions: an incoming sensor channel is read-only, not a remote control for the sensor.

## Availability and dependencies

LSL is provided by the optional `score-addon-lsl` add-on. If **LSL** is absent from the device protocol list, the running score installation does not expose this add-on; installing a sensor driver or Python package alone does not add the protocol.

For a source build, include the add-on and its `3rdparty/liblsl` submodule. Its CMake configuration builds liblsl statically and links `LSL::lsl` and score's Device explorer plug-in. The bundled liblsl requires CMake 3.23 or newer, thread support and Boost headers; this add-on disables liblsl's private bundled Boost. Pugixml is bundled by default. The Windows build targets Windows 10 APIs. These build settings do not establish availability in every score package or on every platform.

At runtime, receiving requires an application or hardware bridge that publishes an LSL outlet, not merely a connected instrument. Sending requires an external LSL receiver if you want another application to consume score's values. The static build above does not require a separately installed shared liblsl for score; an external publisher or receiver may have its own liblsl installation requirements. Python and `pylsl` are only needed for Python-based publishers or receivers, not for the score device itself.

## Receive a stream

1. Start the source application or instrument's LSL bridge and enable its outlet.
2. In the [Device explorer]({{ site.baseurl }}/panels/explorer.html), choose **Add device → LSL**.
3. Set **Name:** to the name you want for the score device, for example `LSL`.
4. Wait for the **Inbound Streams** table to populate. It shows **Stream**, **Type**, **Channels**, **Rate** and **UID**. Discovery runs in the background and the table refreshes periodically.
5. Tick the checkbox beside each stream to receive. Highlighting a row is not enough. Use the UID to distinguish streams with similar names.
6. Confirm the device settings and expand the device in the explorer. Use its channel addresses as inputs to your score processes.

The **Stream Types:** field is present, with the hint “Leave empty for all types”, but the current implementation only stores its text: it does not apply the filter to discovery or subscriptions. Leave it empty and select streams with the checkboxes.

Subscriptions are saved by **UID**, not by stream name or source ID. A publisher restarted with a new UID must be selected again. The device subscribes when it connects; it does not automatically subscribe to every stream subsequently discovered.

### Incoming address tree and values

Each subscribed stream creates a node named after the stream, with one read-only (**GET**) parameter per channel. An unnamed stream uses `stream`. Channel labels are taken from the stream's channel metadata when available; otherwise the names are `ch1`, `ch2`, and so on.

For a device named `LSL`, a stream named `TestSensor` with no channel labels could expose:

```text
LSL:/TestSensor/ch1
LSL:/TestSensor/ch2
```

Inspect the actual explorer tree before assigning addresses, especially when names overlap. Channel units and numeric ranges are imported when present and understood by score.

| Incoming LSL format | score value |
|---|---|
| `float32`, `double64` | Float |
| `int16`, `int32` | Integer |
| `string` | String |

Although discovery can list `int8` and `int64` streams and create their integer parameters, the current receive loop does not handle samples in those formats. Convert them in the publisher if you need their values in score. This interface exposes individual channel values, not an audio buffer or a complete timestamped sample object; do not assume that double precision is preserved.

## Publish values from score

The same settings dialog has an **Outbound Sensors** tree:

1. Click **Add Sensor**. The new row is named `NewSensor` and initially uses `float`.
2. Edit **Sensor Name** to set the outgoing LSL stream name.
3. Double-click the sensor's **Data Type** cell to choose `float`, `int` or `string`. These create LSL `float32`, `int32` or `string` channels respectively. All channels in that stream share the chosen format.
4. With the sensor selected, click **Add Channel** for each channel. Edit the child names; generated names start at `ch1`. Add at least one channel before connecting.
5. Use **Remove Channel** on a selected child or **Remove Sensor** to remove its whole sensor configuration.
6. Confirm the settings. In the Device explorer, find the output node whose name begins with `outlet_`, then send values to its channel parameters using score states or processes. Use the actual generated address rather than assuming that the sensor name is its path.

Outgoing channels are write-only (**SET**). Their parent node's description holds the stream name. A write to any one channel sends a complete sample containing the current values of **all** channels in that outlet. Other channels retain their last values; the internal initial values are zero. Separate channel writes therefore produce separate samples, not an atomic multi-channel update.

The dialog does not expose stream type, source ID or sample rate controls. Newly configured sensors use type `Measurement`, source ID `ossia_score` and nominal rate `100.0` Hz. This rate is metadata: the implementation sends on parameter writes and does not run a 100 Hz output scheduler.

**Current output limitation:** use one outbound sensor per device. The add-on keys its outlets using the UID from the stream description passed to liblsl, rather than the UID assigned to the created outlet. For newly configured sensors this key is empty, so multiple sensors in one device can replace each other in the output bookkeeping; the generated node can simply be named `outlet_`.

## Timing and current limits

- Incoming streams are polled by a worker loop with a 5 ms sleep, taking at most one sample per stream per pass. This is not a lossless high-rate acquisition or recording interface; fast streams can accumulate latency.
- Incoming sample timestamps are used to detect whether a sample arrived but are not exposed as score parameters or used to schedule score events. There is no timestamp or clock-correction control in this dialog.
- Outgoing calls use liblsl's default sample timestamp rather than a timestamp explicitly supplied by the score timeline. Do not infer sample-accurate alignment with score's transport from LSL's general synchronization features.
- The device tree is generated from subscriptions and output configuration. Add or remove streams and channels in the device settings, not by manually adding explorer nodes.

## Troubleshooting

| Symptom | What to check |
|---|---|
| **LSL** is missing from the protocol list | Check that your score build includes and loads `score-addon-lsl`. A working LSL application elsewhere does not prove that the add-on is present in score. |
| **Inbound Streams** is empty | Confirm that the publisher has actually created an outlet and is still running. Allow discovery to complete. Check local/network connectivity and firewall rules for LSL discovery and data traffic; this dialog has no manual host or port fields. |
| A listed stream creates no input nodes | Tick its checkbox, not just its row. If the publisher restarted, reopen the settings and select its current UID before reconnecting. |
| Nodes exist but their values do not change | Check that the publisher is sending samples and that its channel format is supported by the receive loop. A listed nominal rate does not prove that samples are arriving. |
| An outgoing stream is absent | Check that the sensor has channels, confirm the settings, and inspect score's diagnostic output for `Failed to create outlet`. Test a single configured sensor first. |
| Connection appears successful but a selected input is absent | Individual subscription failures do not necessarily fail the whole device connection. Diagnostic messages include `Stream not found`, `Failed to resolve stream` and `Failed to subscribe to stream`; reselect the currently advertised source. |

For a software-only check when working from the add-on sources, `tests/test_lsl_sender.py` publishes a four-channel `float32` stream named `TestSensor`. It requires `pylsl` and its liblsl runtime. Start it before opening the settings, select `TestSensor`, then inspect the resulting channels while the sender runs. This checks the publisher-to-score path without requiring an instrument; it is not a hardware compatibility guarantee.