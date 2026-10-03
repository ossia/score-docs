---
layout: default
title: "Entity To MIDI"
description: "Map tracked entities to expressive MIDI voices"
parent: Processes
grand_parent: Reference
permalink: /processes/entity-to-midi.html
---

# Entity To MIDI

Entity To MIDI turns people, blobs or other tracked entities into MIDI voices. Connect Point Tracker’s **Tracks** to **Entities** for persistent identities, then connect **MIDI** to an instrument or MIDI destination. **Active Voices** and **Denied** help monitor voice allocation.

For its absolute and tempo-relative duration controls, see [Time Chooser]({{ site.baseurl }}/reference/time-chooser.html).

Entities also accepts coordinate vectors, sublists, flat numeric lists or maps. **Coordinates** selects 2D or 3D interpretation for bare data. Without explicit ids, identity is list position: changing list order can exchange voices. Prefer [Point Tracker]({{ site.baseurl }}/processes/point-tracker.html) for unordered detections.

## Voices and expression

**Output Mode** offers **MPE**, **Channel per entity**, or **Single channel**. MPE assigns per-entity pitch bend, pressure and CC74; match **MPE Zone**, **Member Channels** and **Bend Range** to the receiving synth. Channel per entity omits the MPE handshake. Single channel cannot provide independent pitch bends, so pitch is latched and pressure uses polyphonic aftertouch.

**Note Model: Sustained** holds one note for the entity’s lifetime; **Triggered** produces short notes. **Trigger On** chooses Confirmed or First detection, trading false starts for lower latency. Configure **Max Voices**, **Allow Stealing**, **Steal Policy**, **Lost Grace** and **While Coasting** for crowding and occlusions.

**Pitch Axis**, **Invert Axis**, **Position Min/Max** and **Lowest/Highest Pitch** map position to pitch. **Pitch Tracking** chooses Continuous bend, Latched or Retrigger (for Triggered mode). **Glide** smooths pitch changes. The process also provides expression mappings for pressure and timbre.

## Duration, grid and safety

**Min Note**, **Max Note**, **Trigger Length**, **Glide** and **Max Hold** use time choosers; musical durations follow tempo. **Beat Quantize**, **Grid** and **Quantize Strength** align notes with the score’s grid. **Max Hold** limits how long a pending note waits for the grid.

Keep **Watchdog** enabled when a tracking source may stop sending: it releases held notes after the configured absence of tracking data. **Panic** and **Panic On Stop** provide explicit cleanup. Configure receiver bend ranges and channel mode before performing; a conventional single-channel synth cannot reproduce MPE’s independent expression.
