---
layout: default

title: Address system
description: Working with various units in ossia score

parent: In depth

permalink: /in-depth/unit-system.html
---

# Unit system

*score* provides various features to ease the management of parameters. These are specially useful when writing complex processes (e.g automations).

## Addressing items in arrays

When a parameter of a declared device defines a set of values (e.g parameters defining an XYZ position or an RGB color), items in this array can be accessed independently using a special syntax: a parameter address may be followed by an integer (starting from zero) in brackets, which will select a given member.

For example, using `aDevice:/anAddress@[1]` as a destination address of an automation will send the automation value to the *second* element in the array.

If the array contains sub-arrays (for instance for a matrix), it is possible to address sub-elements like this:

```
aDevice:/anAddress@[1][0]
```

For instance, given

```
aDevice:/anAddress == [ [a, b], [c, d] ]
```

the above address will change the value of `c`.

> Note that without specifying an index, messages and automations sent to array parameters (i.e. `vec2f`, `vec3f`, `list`) will affect all items in the array.

## Where units come from

Parameters of a device may be declared with a specific unit (for instance, parameters defining a position in space or a color). *score* embeds an automatic unit conversion mechanism, so that a process can work in the unit that is convenient for it while the device receives the unit it expects.

A port of a process gets its unit from two possible places:

- **The process itself.** Some ports declare what they are: a color control is `color.rgb`, a gain is `gain.db`, an XYZ control is `position.xyz`.
- **The address it is bound to.** Any address can be followed by a unit in brackets, with the same syntax as for array indexing: `aDevice:/anAddress@[angle.radian]`. This overrides the process's own declaration, and goes away when the address is cleared.

> When an address is dragged from the [[Device explorer]] onto a port, the unit of the parameter is added to the address automatically: a parameter declared in metres arrives as `aDevice:/height@[distance.m]`.

> The complete list of supported units is available [in the libossia documentation](https://ossia.io/ossia-docs/#units).

## The rules

When a value goes from a parameter to a port, from a port to a parameter, or from one port to another, *score* looks at three things on each side: its **type** (float, vec3, ...), its **range** (min and max), and its **unit**. What happens follows from a few rules.

**1. A unit only counts when both sides have one, and they belong to the same family.**

Metres and millimetres are both distances; quaternions and euler angles are both orientations; rgb and hsv are both colors. Then the value is converted, and nothing else rescales it, since the conversion already says what the number is.

| Sent | Received by | Result |
|---|---|---|
| `1.5` from `/height@[distance.m]` | a port in `distance.mm` | `1500` |
| a quaternion from `/head@[orientation.quaternion]` | a port in `orientation.euler` | the same orientation, as three angles |

**2. When a unit counts, the range of the receiving side only clips.**

A range is a limit, not a scale. It clips whether or not the sending side has a range of its own.

| Sent | Received by | Result |
|---|---|---|
| `1.5` from `/height@[distance.m]` | a port in `distance.mm` ranged `[0; 10]` | `10`, not 0.5 |
| `1.5` from `/height@[distance.m]`, ranged `[0; 2]` | a port in `distance.m` ranged `[0; 1]` | `1`, not 0.75 |

**3. In every other case, the ranges map.**

If neither side has a unit, if only one side has one, or if the two units belong to different families (a distance sent to a color), the units are ignored and the value is scaled from the sending range to the receiving range. This is what a slider bound to a ranged parameter has always done. With a range on only one side, the value passes through unchanged.

| Sent | Received by | Result |
|---|---|---|
| `1.5` from `/x`, ranged `[0; 2]` | a slider ranged `[0; 10]` | `7.5` |
| `1.5` from `/height@[distance.m]`, ranged `[0; 2]` | a slider without a unit, ranged `[0; 10]` | `7.5` |
| `-42` from `/level@[gain.db]`, ranged `[-96; 12]` | a knob in `angle.degree` ranged `[0; 360]` | `180`: the two units say nothing to each other |
| `1.5` from `/x`, ranged `[0; 2]` | a port without a range | `1.5` |

**4. A port without a unit accepts anything.**

It receives the value as it was sent, in the unit of the sender, and only rule 3 applies to it.

**5. A value is never dropped because of a unit.**

A conversion that makes no sense (a single number sent to a color port, or a color sent to a distance) leaves the value as it is.

**6. A component can be selected, in the unit named.**

In the case of multi-dimensional quantities (colors, 3D positions, orientations), it is possible to select a single component:

```
aDevice:/anAddress@[color.rgb.r]
```

as the output of an automation will only update the red component. This also works across units of the same family: if the device has a parameter declared with the `color.rgb` unit, it is possible to control its hue with `aDevice:/anAddress@[color.hsv.h]`. The current color is converted to hsv, the hue is replaced, and the result is converted back to rgb before being sent. Two processes writing two components of the same address at the same time each set their own.

A plain index, `aDevice:/anAddress@[1]`, selects the second element without any conversion.

**7. The same rules apply everywhere.**

They hold when a process reads an address from the network, when it reads an address that another process wrote earlier in the same tick, when two processes are connected with a cable, and when a process writes to an address. On the way out, the value is converted to the unit of the device's parameter, and the parameter's own clip mode decides what happens if it is out of range: *score* does not clip it beforehand.

| Written by | To | Sent to the device |
|---|---|---|
| a port in `distance.m` writing `1.5` | `/height`, declared in `distance.mm` | `1500` |
| a port in `distance.m` writing `1.5`, ranged `[0; 2]` | `/height`, declared in `distance.m`, ranged `[0; 10]` | `1.5`: the clip mode of `/height` applies |
| a port without a unit writing `1.5`, ranged `[0; 2]` | `/x`, ranged `[0; 10]` | `7.5` |
