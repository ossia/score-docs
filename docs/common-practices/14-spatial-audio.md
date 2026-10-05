---
layout: default

title: Spatial audio techniques
description: "Sound spatialization workflows in ossia score"

nav_order: 15
parent: Common practices

permalink: /common-practices/14-spatial-audio.html
---

# Spatial audio techniques

score can spatialize audio itself or control an external renderer. For loudspeaker playback, DBAP and GBAP calculate gain coefficients; Matrix Spatialization applies those coefficients to audio. Faust and audio plug-ins provide other approaches, including ambisonics.

* TOC
{:toc}

## A moving source on four loudspeakers

![Basic spatial setup]({{ site.img }}/common-practices/spatialization/spatialization-dbap.png)

This patch uses one mono audio source, four loudspeaker positions and a moving XY position.

1. Select patch mode and add [[Multi-Cursor Manager]], [[Path Generator]], Array Flattener, [[DBAP]] (the 2D version) and [[Matrix Spatialization]].
2. In Multi-Cursor Manager, create four points around the corners of the XY area. Their order determines the order of the output channels. Use the same coordinate system for the loudspeaker layout and the source trajectory.
3. Add a mono sound file and enable looping in its inspector.
4. In Path Generator, create one trajectory, select Circle and keep Output mode set to XY. Adjust the on-screen handles to put the circle inside the speaker layout; Speed controls its movement. Array Flattener converts the one-element list of XY positions into the coordinate pair expected by DBAP.
5. In Matrix Spatialization, set Audio outs to `4`, Channel offset to `0` and Gain to `1`.
6. Connect these ports:

   | From | To |
   |---|---|
   | Multi-Cursor Manager: out | DBAP (2D): Speakers |
   | Path Generator: Output | Array Flattener: input |
   | Array Flattener: output | DBAP (2D): Source |
   | DBAP (2D): Output | Matrix Spatialization: Weights |
   | Mono sound file: audio output | Matrix Spatialization: Input |
   | Matrix Spatialization: Output | Your four-channel audio output |

Configure four output channels on your audio device and check their physical speaker order. Start playback. The trajectory changes the DBAP weights, and Matrix Spatialization distributes the source across the four outputs.

The DBAP Source inlet comes before Speakers; connect by name rather than assuming that the first inlet is the speaker layout.

The [DBAP speaker gains and paths example]({{ site.baseurl }}/common-practices/sound-spatialization/spat-example-dbap.html) provides a downloadable patch for inspecting positions and coefficients.

### Matrix Spatialization

[[Matrix Spatialization]] takes an audio input and a list of weights. With Channel offset set to zero, output channel `k` receives the mono input multiplied by weight `k` and Gain.

Use one weight per output channel. If the list is shorter than the output count, the process repeats its last weight. Channel offset adds silent leading channels; for the patch above, leave it at zero.

Use a separate DBAP and Matrix Spatialization pair for each independently positioned mono source, then mix their audio outputs. Matrix Spatialization is not a general multichannel matrix mixer: its current implementation does not sum multiple input channels.

## Choosing the gain algorithm

### DBAP

[[DBAP]] uses the distance from one source position to each loudspeaker. The 2D version takes XY coordinates; the 3D version takes XYZ coordinates. Loudspeakers need not form a regular array.

- Source is one position, not a list of independent sources.
- Speakers is a list of positions, in output-channel order.
- Blur spreads the gains by adding a distance term.
- Roll-off controls how strongly relative distance affects the gains. Its default is `6`.

The implementation normalizes the coefficients so that the sum of their squares is one. Moving the source away from all speakers therefore does not create overall distance attenuation. Add a separate gain control if that is required.

### GBAP

[[GBAP]] calculates weights for a rectangular grid. Sink X # and Sink Y # set the grid dimensions, each from 1 to 12. Position moves a source in the grid; Input Multicursor accepts several XY positions.

For a single-source patch:

1. Leave Input Multicursor unconnected and move the source with Position.
2. Send the list `[1]` to Input Weights and set System Number to `1`. GBAP selects an incoming weight with this one-based index; without a valid selection, its output weights are zero.
3. Connect Output Weights through Array Flattener to Matrix Spatialization's Weights inlet. GBAP returns a list of weight lists, one per source; Matrix Spatialization expects a flat list.
4. Set Matrix Spatialization's Audio outs to the number of grid cells and Channel offset to zero.

Gain, RollOff and Normalize adjust the resulting weights. GBAP produces control data, not audio. With several cursors, extract each source's weight list and use a separate Matrix Spatialization process for its audio.

## Trajectories

[[Path Generator]] provides Linear, Circle, Spiral, Lissajous, Rose and Polygon paths. Speed controls traversal; Ping Pong reverses it at the ends. Its Output mode selects XY, XY0 or XYZ. XYZ adds the Z control to a planar trajectory; it does not turn the curve into a three-dimensional path.

Use XY for DBAP (2D), and XYZ for DBAP (3D). Path Generator outputs a list of positions, one per trajectory: flatten a single trajectory's output as above, or extract the position needed for each DBAP. The speaker positions must have the same number of coordinates as the source. [[2D Spline]] provides another way to draw a trajectory on the timeline. Sensor values or OSC messages can also control the source position.

![Complex trajectories]({{ site.img }}/common-practices/spatialization/complex-paths.gif)

## Faust spatialization

[[Faust]] can process a mono source into several audio channels directly, without a separate Matrix Spatialization process.

For a circular array of eight speakers, create a Faust process with:

```faust
import("stdfaust.lib");

rotation = hslider("Rotation", 0, 0, 1, 0.001);
distance = hslider("Distance", 0.5, 0, 1, 0.001);
process = sp.spat(8, rotation, distance);
```

Connect a mono audio source to its input and route its eight output channels to the loudspeakers. Automate Rotation to move the source around the array. Both controls range from zero to one; Rotation is a fraction of a turn, not an angle in radians. Change `8` in the code to change the number of outputs.

The [Faust spatialization library](https://faustlibraries.grame.fr/libs/spats/) defines `sp.spat(N, rotation, distance)` for this workflow. It does not take an additional list of speaker angles.

For other Faust spatial processors, install the [abclib package](https://github.com/jcelerier/abclib) through the [[Package manager]] and drag its processes from the user library into the score. Follow each processor's channel layout and control definitions.

## Multichannel and ambisonic files

A multichannel sound file can be routed to a matching multichannel output. Check the file's channel order against the loudspeaker connections.

An ambisonic recording needs a decoder between the file and the loudspeakers or headphones. Select a decoder that matches the recording's order, channel ordering and normalization, then configure the decoder's speaker layout or binaural output.

The same routing applies to a hosted ambisonic encoder and decoder:

```text
Mono sources → encoder → ambisonic channels → decoder → loudspeakers or headphones
```

Load the required [[Audio effects|audio plug-ins]], connect their audio ports and automate their exposed parameters. DBAP outputs are gain lists, not ambisonic audio: they are not a substitute for an ambisonic encoder.

## Controlling SpatGRIS

The [[Spatialization device]] sends spatial control messages to external software. Audio travels separately.

1. Add a Spatialization device in the [[Device explorer]] and select SpatGRIS in Format.
2. Set Host and Output Port to the address on which SpatGRIS receives OSC.
3. Set Source/Object count to the number of sources you need.
4. Connect or automate the source parameters exposed in the device tree. Source offset shifts the remote source numbers: an offset of `4` sends local source `1` as remote source `5`.
5. Route the corresponding audio tracks to SpatGRIS through your audio system, for example with JACK or PipeWire routing.

The device also offers ADM-OSC and SPAT Revolution formats. Select the format used by the receiving application.

## Troubleshooting spatial audio

If the sound does not move, check the data and audio routes separately:

- Observe DBAP or GBAP's weight output while changing the source position.
- Check that the weights reach Matrix Spatialization, Audio outs matches the speaker count and Channel offset is zero for the basic patch.
- Check each physical output channel with a simple signal.
- Check that the loudspeaker coordinates and source trajectory use the same scale.

For a more concentrated DBAP distribution, increase Roll-off; increase Blur for a broader distribution. Roll-off changes the gains, not the number of calculations or the audio buffer size.

When controlling an external renderer, [[Rate Limiter]] can reduce the OSC update rate. This is separate from audio buffering and speaker calibration.

## Related processes

[[DBAP]], [[GBAP]], [[Matrix Spatialization]], [[Path Generator]], [[Multi-Cursor Manager]], [[Faust]], [[Audio Utilities]], [[Mapping Tool]] and [[Spatialization device]].
