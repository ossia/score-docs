---
layout: default

title: Feature coverage 2025–2026
description: "Documentation scope and verification map for the 2025–2026 score source changes"

parent: Reference
permalink: /reference/feature-coverage-2026.html
---

# Feature coverage 2025–2026

This is a documentation coverage map, not a release announcement or a list of features available in every build. It identifies the user-facing subjects to review when documenting the year's source changes. A source implementation, a registered process, an installed add-on and a tested workflow are different kinds of evidence.

## Source scope and status

The review window begins **2025-10-02** and ends at the inspected **2026-10-03** snapshot of the local `score-workshop` source checkout: commit `7cfe8e04e36b46455f7e490367c1d20d7d534b2b` (`video: GPU decoders for the pixel formats real files still sent to swscale`). The checkout is the source of this audit; its directory name is not a release version or a claim that every commit is published upstream.

The linked pages check current implementations and registration, including build guards and optional dependencies. Reverted work, internal renderer classes and unregistered objects are not presented as user-selectable processes.

**Status:** the areas below are **source checked and documented**, with unavailable surfaces called out separately. This is documentation coverage, not a claim that every workflow, hardware device or backend has been runtime-tested.

Evidence levels used by this map:

- **Scope recorded:** subject and evidence lead identified; no claim of completed coverage.
- **Source checked:** current registration, names, controls and restrictions verified, with source references recorded.
- **Documented:** an existing linked page describes the verified surface and its limitations.
- **Workflow exercised:** the described interaction has been run, with the build, platform and result recorded separately from source inspection.
- **Not exposed / unavailable:** current registration or build constraints prevent the proposed surface; record the reason instead of creating a fictional process page.

### Exclusions and availability corrections

**xwax — not verified; no feature page.** The audio/MIDI source audit found no xwax implementation or registration in this checkout. The proposed evidence commit `83cea1165e` changes VST widgets rather than establishing xwax support. This proposed plan item is therefore excluded from documented capabilities; its omission is intentional, not evidence of an unfinished xwax page.

- **Historical `TRANSPARENCY` shader key:** absent from the current parser. [[Shader cookbook]] documents the current `QUEUE` and `LAYER` controls instead.
- **Tracking protocols:** the optional add-on returns from CMake before building in this snapshot. [[Add-ons]] records this restriction rather than claiming its devices ship.
- **Libmapper:** conditional registration exists, but the audited factory has a header/implementation interface mismatch. [[Libmapper client]] records the prerequisite instead of treating source presence as working support.
- **Phidgets:** the optional integration's wrapper has a stale include path. [[Phidgets device]] describes its intended channel model while requiring a compatible enabled build before use.
- **High-contrast preset:** no named built-in preset was verified. [[Appearance and skins]] documents the available per-role colour and font controls, not an accessibility certification.

## Coverage map

Each row links the overview and reference entry points for an audited area. The process and device indexes link the individual registered objects and grouped utility references.

| Area | Documentation | Checked scope and limits |
| --- | --- | --- |
| Graphics and media | [[Graphics pipeline]], [[Video formats and color]], [[Shader cookbook]], [[Devices]] | Playback selection, codec versus pixel decoding, colour, captures, output windows and sharing backends; current shader headers and resource contracts. Backend, driver and optional-runtime restrictions are explicit. |
| 3D and scenes | [[3D scene pipeline]], [[Asset Loader]], [[Processes]] | Registered scene tools, geometry, animation, materials, cameras, lights, environment and rendering connections. No invented Scene From Meshes process; optional USD, SPZ version and LDR loader restrictions documented. |
| Scripting and custom UI | [[Scripting]], [[Scripting API]], [[Custom UI]], [[Remote Control]] | Document automation, processes, ports, values, devices, files, view capture and interface lifetime. Context-specific APIs are separated from process execution and scripted protocols. |
| Devices and protocols | [[Devices]], [[Protocols]], [[Device explorer]] | Discovery, named MIDI controller maps, Companion, Linux receive-only CAN, camera configuration, framing and live device restrictions. Tracking and Libmapper availability are caveated above. |
| Audio and MIDI | [[Working with audio]], [[Audio plugins]], [[MIDI Sync In]], [[MIDI Sync Out]], [[VU Meter]] | Audio capture/routing and resampling, plug-in scanning and format constraints, sequencing, note policies and timing/monitoring processes. Source limitations in MIDI Filter and high-rate MIDI synchronization are stated rather than hidden. |
| Process utilities | [[Array utilities]], [[Control utilities]], [[MIDI utilities]], [[Audio utilities]], [[Display Utilities]], [[Mapping utilities]], [[Analysis]] | Registered routing, filtering, queues, tables, regex, serialization, file/shell operations, trackers, recorders and display utilities. Grouped references distinguish their controls, ports and trigger behavior. |
| Timing | [[Time Chooser]], [[Musical metrics]], [[Timecode Synchronizer]], [[Seek and transport]] | Absolute and musical durations, quantization, transport, modulation and versioned FX. Process-specific limitations include the Audio Particles free-frequency readout mismatch and smoothed loss-of-sync behavior. |
| Workflow and UI | [[Editing workflow]], [[Shortcuts]], [[Recording]], [[Presets]] | Scrubbing, nodal selection/cables/paste, placement, source updates, cue snapshots and broken-reference repair. Reverse processing is not undo of external actions. |
| WASM / browser build | [[Using score in the browser]], [[Building for WebAssembly]] | JSPI/isolation, browser permissions, project import/export and persistence, media constraints and build exclusions. Native plug-ins and desktop JavaScript-process execution are not promised in the browser. |
| Projects and custom applications | [[Project files]], [[Media management]], [[Custom applications]] | Missing media, consolidation, archives, unused files, trimming and platform packagers. Archive collection boundaries, native environment overlays, QRC verification and signing limitations are explicit. |
| Appearance | [[Appearance and skins]], [[Preferences]] | Skin colours, independent font roles, presets, persistence, hinting and rendering preferences. No fabricated high-contrast preset or accessibility certification. |
| Add-ons | [[Package manager]], [[Add-ons]], [[Library]] | Runtime packages, SDK/support libraries, rescanning and extension availability. A catalogue or repository entry is not proof of installed support. |
| Development | [[Release build]], [[Hacking]], [[Plug-ins with Avendish]], [[Command line API]] | Current build/SDK prerequisites, plug-in interfaces, runtime compilation and startup flags. Platform recipes are distinguished from tested target-platform builds. |

## Page content conventions

### Process reference pages

Use the displayed process name as the title, `parent: Processes`, `grand_parent: Reference`, and a `/processes/name.html` permalink, following neighboring process pages. Confirm the process is registered and available under the documented build conditions before assigning it a page.

Begin with what the process does and where it fits in a patch or timeline. Describe input and output ports by visible label, type, direction and role; explain settings, units, trigger behavior and meaningful interactions. Include a short connection or editing workflow, actual limitations and links to existing related pages. A shared overview may cover a coherent family, but must distinguish its selectable members and their different ports. Do not fill pages with internal class inventories or empty headings.

### Device and protocol pages

Reuse the front matter and hierarchy of existing device or reference pages as appropriate; a transport is not automatically a process. State how to add the device, the settings the user must supply, discovery behavior and how the resulting address tree is used. Explain send/receive direction, required external software or hardware, platform/build conditions and connection troubleshooting. An optional protocol must be labeled optional at the point where the setup instructions depend on it.

### API and workflow pages

Place API details in the relevant scripting or development guide, retaining its established hierarchy. Name the runtime context, imports, exposed object, method or property, argument and result types, and side effects. Note lifetime, threading or platform restrictions only when they affect the documented contract. Keep code samples short and complete for that context; label unexecuted examples honestly rather than claiming they were tested.

A workflow page should connect reference material into a concrete sequence: prerequisites, user actions, expected result and relevant limitations. Use actual UI labels and existing links. Screenshots and downloadable examples require their own provenance; neither should be implied by prose describing an unexercised workflow.

## Verification boundary

The audit checked implementations, registrations, controls and build conditions. It also exercised these limited runtime paths on Linux:

- The development `ossia-score` binary ran an offscreen scripting smoke covering scenario, interval and automation creation, command macros, curve points, comments, outlet lookup, preset serialization, object-path round trips, undo state and time conversion; it exited successfully.
- Startup-script checks observed successful exit, explicit exit status `7`, evaluation-error status `3` and unreadable-script status `2`. Core command-line help was inspected.
- `tools/create-app.sh --help` was run to verify the packaging interface; no packaged application was created or validated.

These checks do not establish hardware, GPU, plug-in, browser-application or target-platform compatibility. Examples and workflows elsewhere are source-inspected unless their page states otherwise. Publication checks validate the documentation's build, navigation and rendering, not score's multimedia behavior.
