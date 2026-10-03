---
layout: default
title: LTC Generator
description: "Generate an audio LTC signal with explicit frame-rate and transport limitations"
parent: Processes
grand_parent: Reference
permalink: /processes/ltc-generator.html
---

# LTC Generator

**LTC Generator** encodes linear timecode as a mono audio signal on **LTC**. It is provided by the optional LTC add-on; availability depends on the installed score build and add-ons.

## Controls and output

| Control or port | Meaning |
|---|---|
| Offset (s) | Integer timecode offset in seconds, from -128000 to 128000; default 0. |
| Framerate | 525 (30fps), 625 (25 fps), 1125 (30fps) or Film (24 fps). |
| LTC | Mono audio output carrying the encoded signal. |

The two 30 fps options select different television standards; neither label is a 29.97 fps selector. This generator does not expose a separate drop-frame switch or an output-level control.

## Routing

Add the process to an interval and route **LTC** to a dedicated audio output or, for a local decoding experiment, to [[LTC Input]]. Match the receiver's frame rate. LTC is a data signal: avoid mixing it with program audio or sending it to loudspeakers for monitoring.

## Transport and tempo limitations

Do **not** assume the emitted code automatically follows arbitrary score transport changes. The current encoder advances its own timecode frames; it does not implement continuous reconciliation with seeks, loops or transport jumps. Reconfiguration uses the remembered process time plus **Offset (s)**, but this is not a general chase mechanism.

Encoding also passes a speed factor of `120 / tempo` to the LTC library. The nominal factor is 1 at **120 BPM**; generation is tempo-dependent rather than an independent wall-clock source. Keep tempo fixed at 120 BPM when evaluating nominal-rate output, and verify the receiving hardware before relying on it for synchronization. Live frame-rate changes should likewise be checked at the receiver rather than assumed seamless.

[[LTC Input]] decodes numeric time values; neither connecting these two processes nor routing LTC to a device establishes automatic score transport slaving.
