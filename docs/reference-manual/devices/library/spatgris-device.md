---
layout: default

title: Spatialization device
description: "Control spatial audio applications with SpatGRIS, ADM-OSC or SPAT Revolution messages"

parent: Devices
grand_parent: Reference

permalink: /devices/spatgris-device.html
---

The **Spatialization** device controls an external spatial audio application over
OSC/UDP. Select **SpatGRIS**, **ADM-OSC** or **SPAT Revolution** in its **Format**
setting; these are three formats of the same device, not separate device types.
The receiver performs the spatialization. This device sends control values, not
audio, and does not configure your audio routing.

This device is provided by the optional `score-addon-spatgris` add-on. It appears
in the **Software** category when that add-on is available in your score build.
The add-on builds all three format implementations together and links to score's
engine; its CMake configuration does not impose a separate operating-system
restriction. Availability in a particular binary still depends on the add-on
being included and loaded.

![SpatGRIS device setup example]({{ site.img }}/reference/devices/spatgris-device.png "SpatGRIS setup example")

The illustration shows the SpatGRIS setup; current versions use the
**Spatialization** name and expose the format selector and settings below.

## Setup

1. In the receiving application, enable OSC input and note its UDP listening
   port. Create or configure the sources or objects you intend to control.
2. Add a device in score's Device Explorer and choose **Spatialization**.
3. Select the **Format** first: changing it also changes the suggested device
   name and ports. Then enter your own name, host and port values.
4. Set **Source/Object count** to the number of local source entries you need.
   Set **Source offset** if they should address a later group of remote sources.
5. For SPAT Revolution, set **Program/Room count** to the number of room entries.
   For incoming ADM-OSC values, configure a nonzero **Input Port** and explicitly
   configure the remote sender to send to score's computer at that port.
6. Accept the dialog and expand the generated tree. Send a value to one source
   and check the receiving application's display before automating a full scene.

| Setting | Meaning |
|---|---|
| **Name** | Local device prefix used in score addresses, such as `SpatGRIS:/1/position`. |
| **Format** | Message format and generated parameter tree. |
| **Host** | Receiver's IP address; `127.0.0.1` for an application on the same computer. |
| **Output Port** | Receiver's OSC/UDP input port. Selecting SpatGRIS suggests `18032`, ADM-OSC `4001`, and SPAT Revolution `9000`. These must match the receiver's actual configuration. |
| **Input Port** | Local UDP port for incoming values; `0` disables reception. Selecting SpatGRIS suggests `18033`; selecting ADM-OSC suggests `4002`. It is disabled for SPAT Revolution. Initial SpatGRIS settings can have input disabled, so inspect this field rather than assuming feedback is active. |
| **Source/Object count** | `1`–`256` local entries, numbered from `1`. This generates a tree; it does not discover or create remote sources. |
| **Source offset** | `0`–`255`; local source `n` is sent as remote source `n + offset`. The local tree stays numbered from `1`. The receiver must support the resulting source numbers. |
| **Program/Room count** | SPAT room count, up to `16`. Although the widget permits `0`, the SPAT implementation clamps it to at least one room. It has no effect on the SpatGRIS or ADM-OSC trees. |

## Routing values from a score

Use the generated addresses as message destinations in states or as destinations
for control processes. For example, with the default SpatGRIS device name, a
state message to `SpatGRIS:/1/position` with a three-component value
`[0.5, 0, 0]` moves source 1; `SpatGRIS:/1/hspan` with `0.25` changes its
horizontal span. Automate a scalar span directly, or route a three-component
position output to the position address.

For ADM-OSC, a device named `ADM-OSC` exposes destinations such as
`ADM-OSC:/adm/obj/1/xyz`. For a device named `SPAT`, use
`SPAT:/source/1/xyz` or individual coordinates such as `SPAT:/source/1/x`.
The device name is local to score and is not part of the OSC address on the wire.

Use an explicit initial state to send the position and other controls needed by
your scene. The initial values displayed in the generated tree are not a
discovery of the receiver's current state. Choose one coordinate representation
for a given automation: the adapter does not keep all scalar, vector, polar and
Cartesian addresses synchronized with one another.

## SpatGRIS format

Each source has the following controls, under `/<n>/`:

| Address suffix | Type and advertised domain | Meaning |
|---|---|---|
| `position` | Three floats; Cartesian 3D unit; `-1.66`–`1.66` | Source position. These are SpatGRIS coordinates, not a parameter tagged in metres. |
| `hspan` | Float, `0`–`1` | Horizontal span. |
| `vspan` | Float, `0`–`1` | Vertical span. |
| `algorithm` | String: `dome` or `cube` | Selects the spatialization algorithm. |
| `clear` | Impulse | Sends a clear command for this source. |

The tree is an adapter, not a literal copy of the remote OSC addresses.
Position and span changes each send `/spat/serv` with the arguments
`"car", source-number, x, y, z, hspan, vspan`. The adapter remembers the other
position and span components, initially zero, so set the complete desired
position and spans when initializing a scene. Clear sends
`"clr", source-number` to the same address.

Although `algorithm` appears under every source, it sends
`/spat/serv "alg" "dome"` or `/spat/serv "alg" "cube"` **without a source
number**. Do not treat these as independent per-source algorithm settings.

**Direction limit:** output commands are implemented. A nonzero input port can
accept ordinary OSC messages matching the local tree, such as `/1/position`.
However, the native `/spat/serv` feedback parser is disabled in this source
version. Enabling an input port therefore does not provide native SpatGRIS
position feedback or synchronization. SpatGRIS also has no implemented
value-query operation.

## ADM-OSC format

Object controls live under `/adm/obj/<n>/`. Outgoing OSC uses these same paths,
with the source offset added to the object number.

| Address suffix | Type and advertised domain |
|---|---|
| `azim` | Float, `-180`–`180` degrees. |
| `elev` | Float, `-90`–`90` degrees. |
| `dist` | Float, `0`–`1`, initially `1`; no metre unit is attached. |
| `aed` | Three floats in azimuth/elevation/distance order, tagged with the AED position unit; initially `[0, 0, 1]`. |
| `x`, `y`, `z` | Individual floats, `-1`–`1`. |
| `xyz` | Three floats, Cartesian 3D unit, `-1`–`1`. |
| `w` | Width float, `0`–`1`. |
| `gain` | Gain float, `0`–`2`, initially `1`; not tagged as decibels. |

Additional controls are:

- `/adm/env/change`: a string sent to the receiver for environment changes.
  The adapter does not enumerate environment names.
- `/adm/lis/ypr`: a three-float yaw/pitch/roll value in degrees, with an
  advertised domain of `-180`–`180`.
- `/adm/lis/yaw`, `/adm/lis/pitch`, `/adm/lis/roll`: separate float controls in
  degrees, each `-180`–`180`.
- `/adm/lis/xyz`: a Cartesian 3D vector, `-1`–`1`.
- `/adm/lis/x`, `/adm/lis/y`, `/adm/lis/z`: separate floats, `-1`–`1`.

**Direction:** this format sends controls and can receive OSC values when
**Input Port** is nonzero. Observed object parameters are registered using the
offset remote address, so with offset `8`, local object `1` is sent and listened
for as `/adm/obj/9/...`. Listener and environment paths are not offset.
Configure the receiver's feedback destination yourself; setting a local port
does not negotiate a return route.

The value-query packet code is disabled in this source version. Do not rely on
refresh or a value request to fetch the receiver's state: incoming values must
be sent by the remote application. No ADM program tree is generated.

## SPAT Revolution format

This is an **output-only** OSC adapter. Sources live under `/source/<n>/`
and rooms under `/room/<n>/`. Each parameter is sent to its corresponding
OSC path. The source offset changes only `/source/` numbers, not room numbers.

Source controls:

| Address suffix | Type and advertised domain |
|---|---|
| `select`, `enable`, `mute`, `solo` | Booleans. |
| `name` | String. |
| `gain` | Float, `-144.5`–`24` dB. |
| `x`, `y`, `z` | Floats, `-100`–`100` metres. |
| `xyz` | Cartesian 3D vector, initially `[0, 2, 0]`; no explicit numeric domain. |
| `azim` | Float, `-180`–`180` degrees. |
| `elev` | Float, `-90`–`90` degrees. |
| `dist` | Float, `0.01`–`100` metres. |
| `aed` | Three floats for azimuth/elevation/distance, initially `[0, 0, 2]`; unlike ADM-OSC's `aed`, this parameter has no attached unit metadata. |
| `yaw` | Float, `-180`–`180` degrees. |
| `pitch`, `roll` | Floats, `-90`–`90` degrees. |
| `pres`, `prer` | Presence and room presence floats, `0`–`120`. |
| `warmth`, `bril` | Warmth and brilliance floats, `0`–`60`. |
| `spread` | Float, `0`–`100`. |

Each room exposes `enable` (boolean), `gain` (`-144.5`–`24` dB),
`size` (float, `10`–`15000`, without attached unit metadata), and listener
position `x`, `y`, `z` (`-100`–`100` metres).

This is the implemented subset, not the complete SPAT Revolution control API.
There is no input socket, feedback observation or value query in this format.

## Troubleshooting and limits

- **No Spatialization choice:** check that the optional add-on is installed and
  loaded in your build; looking for three separate device choices will not work.
- **Tree appears but nothing moves:** the tree is generated locally even without
  a responding receiver. Check format, host, output port, receiver OSC input,
  source numbering and UDP/firewall rules. A populated tree is not proof of a
  working connection.
- **Wrong source moves:** check the offset. With offset `8`, local source `1`
  addresses source `9` on the receiver.
- **No incoming values:** check the format's direction limits above and the
  remote sender's destination. A failed input-socket setup does not necessarily
  prevent outgoing control from working.
- **Missing remote controls:** this device has a fixed generated tree. It does
  not discover the receiver's complete namespace, and adding, removing,
  renaming or changing properties of individual nodes is disabled.

The domains above describe the parameter metadata in score, not a guarantee
that every receiver accepts or clamps every value. Configure the receiving
application and its audio connections separately. This reference describes the
implemented adapters; it does not certify runtime interoperability with every
receiver or receiver version.