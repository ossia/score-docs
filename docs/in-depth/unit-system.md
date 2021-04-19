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

When a parameter of a declared device defines a set of values (e.g parameters defining an XYZ position or an RGB color), items in this array can accessed independently using a special syntax: a parameter address may be followed by an integer (starting from zero) in brackets, which will select a given member.

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

## Using unit conversion

Parameters of a device may be declared with a specific unit (for instance, parameters defining a position in space or a color).
*score* embeds an automatic unit conversion mechanism for advanced automations.

When using these parameters in ports of processes, it is also possible to set an unit set on them, with the same syntax than for array indexing: using `aDevice:/anAddress@[angle.radian]` as a destination address of an automation will send the value in this unit (ie. radian). The value will be converted back to the address's original unit when sent over the network protocol, which may be for instance degrees.

> The complete list of supported units is available [in the libossia documentation](https://ossia.io/ossia-docs/#units).

In the case of multi-dimensional quantities (for instance, colors, 3D positions), it is also possible to select a single component:

```
aDevice:/anAddress[color.rgb.r]
```

as the output of an automation will only update the red component.

This also works with different units: for instance, if the device has a parameter declared with the `color.rgb` unit, it is possible to control its hue with `parameter@[color.hsv.h]`.

## Pattern matching

It is possible to control a set of addresses with pattern matching.

For instance, given the following OSC device:

![An OSC device with repeated parameters]({{ site.img }}/in-depth/pattern-match.png)

It is possible to send an automation to
```
OSCdevice:/sub/*/level
```

to control all the levels with a single curve.

> The complete reference of the supported pattern matching syntax is available [here](https://ossia.io/ossia-docs/#pattern-matching).

<!-- TODO

	Execution semantics
	The automation tries to send values that are graphically as close as possible as the shown curve.
	For the case where the address has no unit :

	 	If the address is integer or floating point, the behavior is as expected.
	 	If the address is a fixed-width array, then :

	 	If there is no array accessor (such as an:/address[1]), all the values of the array are set to the value of the automation ([1, 1], [2, 2], [3, 3], etc.).
	 	If there is an array accessor, only the accessed value will be set : [1, 1], [1, 2], [1, 3], etc...



	For the case where the address has an unit, the value will be converted to the correct unit afterwards.

	An interesting case is the cascading of units.
	For instance, given this case :



	First, the current value of aDevice:/light will be fetched, converted to the hue-saturation-value color space and its value will be set according to the first curve.
	Then, in the red-green-blue color-space, the red component will be increased.
	The result will be applied.
	-->

<!-- TODO
	## Pattern matching
	-->