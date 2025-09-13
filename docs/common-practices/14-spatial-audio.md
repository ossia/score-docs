---
layout: default

title: "Spatial audio techniques"
description: "Sound spatialization workflows in ossia score"

nav_order: 15
parent: Common practices

permalink: /common-practices/14-spatial-audio.html
---

# Spatial audio techniques

*score* comes packed with tools for creating immersive spatial audio experiences: from simple stereo panning to complex 3D installations with dozens of speakers. Whether you're working on a concert hall piece, an art installation, or experimental spatial audio, this guide will get you up and running.

## The basics: what is spatialization?

Spatial audio is about placing sounds in 3D space around your audience. 
Instead of just "left" and "right", you can position sounds anywhere: behind, above, moving in circles, or scattered across a field of speakers.

*score* gives you several approaches to achieve this, and also integrates with multiple industry-standard tools and protocols for spatial audio.

You can either generate object-based spatial audio scenes completely within *score*, leverage industry-standard sound spatialization plug-ins, or act purely as a controller for separate sound spatialization servers such as SpatGRIS.

Some of the main features are:

- **[[DBAP]]** - Works with any speaker layout, handles irregular arrangements.
- **[[GBAP]]** - Grid-based spatialization for regular speaker arrays.
- **[[Faust]]** spatialization - Including professional libraries like abclib for VBAP and ambisonics as well as simpler circular spatializers.
- **[[Spatialization Matrix]]** routing - Applying a spatialization matrix to the actual speakers.
- SpatGRIS control - built-in support for the SpatGRIS OSC API.
- Channel-based spatialization - many audio effects will scale to the number of input channels and will allow polyphonic controls.

In addition, *score* supports loading many kinds of audio plug-ins: VST, JSFX, etc. For instance, the SPARTA and IEM suites of audio plug-ins are well-suited to sound spatialization ; likewise, it is possible to use the Reaper Ambitools inside ossia, and even combine all these tools together.

## Quick start: a first spatial audio scene

![Basic Spatial Setup]({{ site.img }}/common-practices/spatialization/spatialization-dbap.png)

A few tools are required to properly spatialize an audio object: 

- A sound source: generally a mono sound file, synthesizer, etc.
- A loudspeaker layout: 2D or 3D data representing how loudspeakers are physically located in the space you wish to spatialize audio in.

> Note: it is also possible to simulate sound spatialization with headphones thanks to HRTF plug-ins and objects.

- A spatialization trajectory: 2D or 3D position changes that will move the source over time. 
- A spatialization algorithm: given trajectories and loudspeakers, computes how much of the signal spreads to each loudspeaker. This can be for instance [[DBAP]], [[GBAP]], VBAP or even a custom algorithm tailored to the use-case at hand.

This can come from instance from pre-written trajectories with the [[2D Spline]] object, or from tools such as [[Path generator]].

Finally, the [[Spatialization Matrix]] object will take the sound source and the loudspeaker weights output by the spatialization algorithm, and output the resulting audio signal.

Let's create a simple moving sound that travels in a circle around a 4-speaker (classic quadriphonic) setup.

### 1. Set up your speakers

First, tell *score* about your speaker arrangement:

1. For this example we will operate mainly in patch mode. Switch to patch mode with the relevant toggle.
2. Add a [[Multi-Cursor Manager]] object and add four points: these will represent our loudspeakers. Remember that it is possible to visualize the loudspeakers with the [[Point2D View]] object. Alternatively, you can use [[Arraygen]] or [[Math expressions|Expression Value Generator]] to generate position through simple math expressions: for Arraygen, `return [ cos(2pi i / n), sin(2pi i / n) ];` would for instance lay out points on a circle. [[Math expressions|Expression Value Generator]] is the easiest way to directly return coordinates: `return [ 0, 0, 1, -1, 2, -2 ];`
3. Add a sound file from your collection by dropping it in the interface, and make it loop from the inspector.

### 2. Add movement

Now let's make the sound move:

1. Add a [[Path generator]] object and draw a simple line. The trajectory will loop over that line. Other modes are for circular and spiral motion, with more to be added over time.
2. Add a [[DBAP]] process.
3. Add a [[Spatialization Matrix]] process. Set the appropriate number of outputs for your layout.
4. Now, let's connect everything: 

 - The multi-cursor or expression defining the loudspeaker layout's output goes to the first DBAP inlet.
 - The path generator output goes to the "Source" DBAP inlet as it is what defines the movement of our spatialized audio source.
 - The DBAP output goes into the Matrix's data inlet.
 - The sound file output goes into the Matrix's audio inlet.
 
Press play, and you should hear the sound move. Congratulations! You're tipping your toes into spatial audio creation.


## Spatial audio file playback

There are two main cases of spatial audio files: classic multi-channel audio (e.g. 5.1, 7.1) and ambisonics.

For traditional sound files, *score* natively supports arbitrary number of channels (as many as your computer can handle).
Simply route them to the correct output.

For ambisonics, if you have a file providing spatialized audio in e.g. B-format, you will need an ambisonics decoder.
Multiple free decoders are available. 

The simplest solution in that case is to use one of the Faust ambisonics decoder, provided as part of Alain Bonardi and Paul Goutmann's abclib library. This library of efficient spatialized sound algorithms is provided in the [[Package manager]]: install it.
Then, you will be able to use objects such as abc_2d_stereodecoder, etc.


## Spatialization algorithms: choosing the right tool

### DBAP (Distance-Based Amplitude Panning)

DBAP is your go-to for most spatial audio work. It calculates speaker levels based on distance, making sounds feel naturally positioned in space.

**When to use DBAP:**
- Irregular speaker layouts (L-shaped rooms, scattered speakers)
- 3D installations with speakers at different heights
- When you want natural distance attenuation
- Small to large speaker arrays (2 to 100+ speakers)

### GBAP (Grid-Based Amplitude Panning)

GBAP works with regular grids of speakers or virtual sources. It's perfect when you want precise control over speaker arrays, or want to control your system through a hierarchical organization of spatialization with multiple GBAP processes in cascade. It is a useful tool to "weigh" an input across a generic grid.
For instance, a first GBAP process could handle spatialization at the building level, with then individual GBAP objects for each room.

**When to use GBAP:**
- Regular speaker grids (4x4, 6x2, 8x8 arrays)
- Installations with matrix-arranged speakers
- Hierarchical sound installations and management

### VBAP

### Ambisonics


## Faust spatialization: professional algorithms

*score* integrates with professional spatial audio libraries through [[Faust]], giving you access to industry-standard digital signal processing algorithms.
Faust is especially interesting in the context of sound spatialization due to its ability to optimize code for the current CPU you are running, and take advantage of its advanced vector instruction set (AVX2, NEON, etc.) which yields much greater performance than traditional C++ implementations.

### Built-in spat algorithms

The Faust standard library includes `sp.spat` - a professional circular spatialization algorithm developed by Laurent Pottier: it assumes that the listening point is surrounded by a circle of speakers.

```faust
// 8-channel circular spatialization
process = vgroup("Spatializer", sp.spat(8, angle, distance));
```

**To use it:**
1. **Drop the spat Faust preset from the user library**
2. **Connect angle and distance controls** from your spatial controllers
3. **Customize for your speaker count** by editing the Faust code

### abclib: advanced spatial audio library

The abclib package provides professional spatial audio tools:

**Ambisonics processing:**
- **2D ambisonics** up to order 7 (supporting 3-15 channels)
- **Encoders and decoders** for different speaker layouts
- **Rotation and optimization** tools for perfect speaker alignment

**Geometry objects:**
- **Trajectory generators** for complex movement patterns
- **Maps and mirrors** for spatial transformations
- **Decorrelators and granulators** for spatial texture

A lot of spatial audio effects and synthesizers are available, which makes this toolkit a fairly interesting creative tool.

**To access abclib:**
1. **Check the [[Faust]] user library** for abclib presets. You may need to download them from the package manager.
2. **Browse the available objects** 
3. **Drag'n'drop presets** into your score

### Comprehensive Faust spatialization objects

The Faust standard library (`spat.lib`) provides a rich collection of spatial audio algorithms. 
Most of them are available directly as built-in presets in the score library and can just be dropped into the score.
Here's what is available:

#### Core spatialization functions

**sp.spat** - Multi-channel spatialization with configurable speaker arrays:
```faust
// Basic usage
process = sp.spat(N, angle, distance);

// With custom speaker positions (angles in radians)
speakers_angles = (0, 45, 90, 135, 180, 225, 270, 315); 
process = sp.spat(8, angle, distance, speakers_angles);
```

**sp.stereoize** - Enhanced stereo spatialization:
```faust
// Creates natural stereo width with distance simulation
process = sp.stereoize(angle) : sp.wide;
```

#### Panning algorithms

**sp.panner** - Linear panning between speakers:
```faust
// N-channel panner with angle control (0-1)
process = sp.panner(N, angle);
```

**sp.constantPowerPan** - Equal-power panning for consistent loudness:
```faust
// Maintains perceived loudness during panning
process = sp.constantPowerPan(angle);
```

**sp.pannerMono** - Optimized mono-to-multichannel panning:
```faust
// Efficient single-source spatialization
process = sp.pannerMono(N, angle);
```

#### Advanced spatial processors

**sp.encoder3D** - 3D ambisonics encoding:
```faust
// Encodes to 3D ambisonics (requires x, y, z coordinates)
process = sp.encoder3D(order, azimuth, elevation, radius);
```

**sp.decoder** - Ambisonics decoding to speaker arrays:
```faust
// Decode ambisonics to your speaker configuration
process = sp.decoder(order, mode);  // mode: "regular", "maxre", "inphase"
```

**sp.wider** - Stereo width enhancement:
```faust
// Adjustable stereo widening (0 = mono, 1 = normal, >1 = wider)
process = sp.wider(width);
```

#### Practical Faust spatial examples

TOREVIEW

**Moving source with reverb zones:**
```faust
import("stdfaust.lib");

angle = hslider("angle", 0, 0, 1, 0.01);
distance = hslider("distance", 0.5, 0, 1, 0.01);
reverb_mix = 1 - distance : smooth(0.99);  // More reverb when distant

process = sp.spat(8, angle, distance) 
        : par(i, 8, _ <: _, *(reverb_mix) : _, re.mono_freeverb : +);
```

**Frequency-dependent spatialization:**
```faust
// High frequencies focused, low frequencies omnidirectional
splitfreq = 500;
process = fi.filterbank(3, (splitfreq)) 
        : sp.spat(8, angle * 0.3, distance),  // Bass: less directional
          sp.spat(8, angle, distance);        // Treble: fully directional
```

**Multi-layer ambisonics with decorrelation:**
```faust
// 2nd order ambisonics with decorrelation for diffuse field
process = sp.encoder3D(2, azimuth, elevation, 1)
        : par(i, 9, de.delay(ma.SR/1000, i*2+1))  // Decorrelate channels
        : sp.decoder(2, "maxre");
```

### Ambix VST integration

TODO

### IEM VST integration

TODO

### SPARTA VST integration

The SPARTA (Spatial Audio Real-time Applications) suite provides professional VST plugins for advanced spatial audio processing. These work seamlessly within *score*'s plugin hosting capabilities.

#### Available SPARTA plugins

TOREVIEW

**AmbiENC** - Ambisonic encoder:
- **Multi-source encoding** up to 64 simultaneous sources
- **Up to 7th order ambisonics** (64 channels)
- **Real-time automation** of source positions via VST parameters

**AmbiDEC** - Ambisonic decoder:
- **Flexible speaker layouts** including irregular arrays
- **Multiple decoding methods**: AllRAD, EPAD, MMD
- **Built-in test signals** for speaker alignment

**COMPASS** - Binaural rendering:
- **Direct binaural synthesis** from ambisonics
- **Multiple HRTF datasets** included
- **Head-tracking support** via OSC

**PowerMap** - Spatial analysis:
- **Real-time visualization** of spatial sound field
- **Activity maps** showing sound source directions
- **Perfect for monitoring** spatial mixes

#### Using SPARTA in *score*

1. **Load as [[audio effects|VST]]** in your score
2. **Connect to spatial control data** via parameter automation
3. **Chain with *score* processes** for hybrid workflows

**Example workflow:**
```
[Multi-source audio] → [SPARTA AmbiENC] → [Ambisonic mix] → [SPARTA AmbiDEC] → [Speaker array]
                              ↑
                    [Position automation from score]
```

**Integration benefits:**
- **Professional algorithms** tested in research and production
- **Scientific accuracy** for precise spatial reproduction  
- **CPU efficiency** through optimized C++ implementation
- **Standard VST automation** for all spatial parameters

**Pro tip:** Combine SPARTA's scientific precision with *score*'s creative control - use [[DBAP]] for artistic spatialization, then encode to ambisonics with SPARTA for archival or binaural rendering.

## Advanced spatial workflows

### Multi-source spatialization

Create complex soundscapes with multiple moving sources:

1. **Use [[Multi-Cursor]]** to control several XY positions graphically
2. **Connect to multiple DBAP processes** for independent spatial processing
3. **Or use a single DBAP** with multiple position inputs via [[Combine]]
4. **Route through [[Matrix]]** for flexible speaker assignment

**Creative applications:**
- **Swarm effects**: Many small sounds moving independently  
- **Call and response**: Sources moving in relation to each other
- **Spatial counterpoint**: Different musical lines in different spatial areas

### Automated spatial trajectories

Go beyond simple circular movement with [[Path Generator]] combinations:

**Linear sweeps:**
- **Cross-fades**: Sound moving from left to right
- **Fly-bys**: Sound approaching from distance and receding

**Complex patterns:**
- **Chain multiple Path Generators** for figure-8 patterns
- **Use different speeds** for polyrhythmic spatial patterns  
- **Combine with [[LFO]]** for organic, breathing movement

**Interactive control:**
- **Map sensors** to path parameters using [[Mapping Tool]]
- **Use [[MIDI]] controllers** to adjust trajectory in real-time
- **Connect [[OSC]]** devices for gestural control of spatial movement

![Complex Trajectories]({{ site.img }}/common-practices/complex-trajectories.png)

### Polyphonic spatial effects

Many audio effects in *score* automatically become polyphonic when you feed them multichannel audio, which opens another possibility for spatial processing.

**How it works:**
- **Single effect, multiple channels**: The [[Audio Effects]] automatically process each channel independently
- **List-based control**: Instead of single float values, send lists to control each channel separately
- **Perfect for spatial audio**: Apply different reverb to each speaker, or chorus effects that vary by position

**Example workflow:**
```
[Spatial Audio Source] → [DBAP 8-channel] → [Polyphonic Reverb] → [Speakers]
                                                      ↑
                                            [List of 8 different reverb amounts]
```

**Creative uses:**
- **Position-dependent effects**: More reverb for distant speakers
- **Spatial coloration**: Different EQ for each spatial zone
- **Dynamic spatial processing**: Effects that change as sounds move

Note that for Faust effects, it is important to make sure that the effect is mono (one input / one output). 
Many effects in the Faust library come with the stereo assumption: they may require slight change in their code to switch to polyphonic mode.
For instance: consider the smoothDelay.dsp file:

```
import("stdfaust.lib");

process = par(i, 2, voice)
	with { 
		voice 	= (+ : de.sdelay(N, interp, dtime)) ~ *(fback);
		N 		= int(2^19); 
		interp 	= hslider("interpolation[unit:ms][style:knob]",10,1,100,0.1)*ma.SR/1000.0; 
		dtime	= hslider("delay[unit:ms][style:knob]", 0, 0, 5000, 0.1)*ma.SR/1000.0;
		fback 	= hslider("feedback[style:knob]",0,0,100,0.1)/100.0; 
	};
```


The `par(i, 2, voice)` command instantiates the effect for two channels for stereo processing. To put it in mono mode, change 2 to 1 in that line.


## Integration with external tools

### SpatGris connection

*score* can control external spatialization software via the [[SpatGris Device]]:

1. **Add SpatGris device** in the [[Device explorer]]
2. **Configure OSC connection** to your SpatGris instance
3. **Control spatial parameters** from *score* while using SpatGRIS algorithms
4. **Best of both worlds**: *score*'s temporal control with SpatGRIS' spatial processing

You can use for instance JACK on Windows and Linux, PipeWire on Linux, and BlackHole on Mac to share different tracks between *score* and *SpatGRIS*.

## Troubleshooting spatial audio

### Common issues and solutions

**"I don't hear spatialization":**
- **Check Matrix routing** - are outputs connected to correct speakers?
- **Verify speaker positions** - coordinates should match physical layout
- **Test with simple content** - try sine waves before complex audio

**"Movement sounds choppy":**
- **Check audio buffer settings** - larger buffers reduce glitches
- **Use [[Rate Limiter]]** if to the contrary spatial updates are too frequent and overload for instance SpatGRIS.

**"Spatial effect is too subtle":**
- **Increase rolloff** in DBAP for more dramatic distance effects
- **Check speaker calibration** - all speakers at equal levels?
- **Verify room acoustics** - reflections can mask spatial effects

### Performance optimization

**For large installations:**
- **Use appropriate rolloff values** - higher values = less CPU usage
- **Consider speaker grouping** for very large arrays (50+ speakers)
- **Monitor CPU usage** with multiple spatial processes

**Real-time control:**
- **Limit update rates** using [[Rate Limiter]] for smooth performance
- **Use efficient control mappings** with [[Calibrator]] or [[Mapping Tool]]
- **Test latency** between control input and spatial response

## Next steps: expanding your spatial audio toolkit

Once you're comfortable with basic spatialization, explore these advanced techniques:

- **Combine DBAP and GBAP** for frequency-dependent spatialization
- **Layer multiple spatial algorithms** for complex spatial textures
- **Integrate with [[Computer Vision Utilities]]** for camera-based spatial control
- **Connect with [[Video]] processing** for audiovisual spatial installations

Spatial audio in *score* is designed to grow with your artistic vision - start simple and gradually build complexity as you explore the creative possibilities of sound in space.

## Related processes

Essential spatial audio processes: [[DBAP]], [[GBAP]], [[Matrix]], [[Path Generator]], [[Multi-Cursor]], [[Faust]], [[Audio Utilities]], [[Mapping Tool]], and [[SpatGris Device]].
