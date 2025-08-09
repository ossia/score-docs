---
layout: default

title: "Spatial audio techniques"
description: "Sound spatialization workflows in ossia score"

nav_order: 15
parent: Common practices

permalink: /common-practices/14-spatial-audio.html
---

# Spatial audio techniques

*score* comes packed with tools for creating immersive spatial audio experiences - from simple stereo panning to complex 3D installations with dozens of speakers. Whether you're working on a concert hall piece, an art installation, or experimental spatial audio, this guide will get you up and running.

![Spatial Audio Setup]({{ site.img }}/common-practices/spatial-audio-overview.png "Spatial Audio in ossia score")

## The basics: what is spatialization?

Spatial audio is about placing sounds in 3D space around your audience. Instead of just "left" and "right", you can position sounds anywhere - behind, above, moving in circles, or scattered across a field of speakers.

*score* gives you several approaches:
- **[[DBAP]]** - Works with any speaker layout, handles irregular arrangements beautifully
- **[[GBAP]]** - Grid-based spatialization for regular speaker arrays  
- **[[Faust]]** spatialization - Including professional libraries like abclib for ambisonics
- **[[Matrix]]** routing - Essential for connecting spatial algorithms to your speakers

## Quick start: your first spatial audio scene

Let's create a simple moving sound that travels in a circle around a 4-speaker setup.

### 1. Set up your speakers (5 minutes)

First, tell *score* about your speaker arrangement:

1. **Add a [[DBAP]] process** to your timeline
2. **Click the DBAP process** to see its parameters
3. **Set up your speaker positions** in the Speaker Positions parameter:
   ```javascript
   [
     [-1, -1],  // Left rear
     [1, -1],   // Right rear  
     [1, 1],    // Right front
     [-1, 1]    // Left front
   ]
   ```
4. **Connect your audio source** to the DBAP input

### 2. Add movement (5 minutes)

Now let's make the sound move in a circle:

1. **Add a [[Path Generator]]** process
2. **Set it to circular mode** with radius 0.8
3. **Connect the Path Generator's XY output** to DBAP's Position input
4. **Start playback** and hear your sound travel in a circle!

**🎉 Success!** You've just created your first spatial audio piece.

![Basic Spatial Setup]({{ site.img }}/common-practices/basic-spatial-setup.png)

## Spatialization algorithms: choosing the right tool

### DBAP (Distance-Based Amplitude Panning)

DBAP is your go-to for most spatial audio work. It calculates speaker levels based on distance, making sounds feel naturally positioned in space.

**When to use DBAP:**
- Irregular speaker layouts (L-shaped rooms, scattered speakers)
- 3D installations with speakers at different heights
- When you want natural distance attenuation
- Small to large speaker arrays (2 to 100+ speakers)

**Key features:**
- **Position input**: Vec2 for 2D or Vec3 for 3D spatialization
- **Rolloff control**: How quickly sound fades with distance (0.1-50.0)
- **Multiple sources**: Can spatialize several sounds simultaneously
- **3D dome support**: Perfect for planetariums and immersive installations

Try these settings:
- **Concert hall**: Rolloff 2.0 for realistic distance feel
- **Installation art**: Rolloff 6.0 for dramatic proximity effects
- **Ambient spaces**: Rolloff 1.0 for gentle, wide spatialization

### GBAP (Grid-Based Amplitude Panning)

GBAP works with regular grids of speakers or virtual sources. It's perfect when you want precise control over rectangular speaker arrays, or a hierarchical organization of spatialization with multiple GBAP processes in cascade.

**When to use GBAP:**
- Regular speaker grids (4x4, 6x2, 8x8 arrays)
- When you want visual cursor control
- Integration with [[Multi-Cursor]] for multiple sources
- Installations with matrix-arranged speakers

**Interactive control:**
- **Drag the cursor** in the 2D interface to position sounds
- **Combine with [[Path Generator]]** for automated movement
- **Use [[Multi-Cursor]]** to control multiple sound sources simultaneously

### Matrix routing: the spatial audio backbone

The [[Matrix]] process is essential for spatial audio - it's how you connect spatial algorithms to your actual speakers with individual gain control.

**Basic setup:**
1. **Connect your spatial algorithm** (DBAP, GBAP) to the Matrix input
2. **Configure Matrix** for your speaker count (e.g., 4 inputs, 8 outputs)
3. **Connect Matrix outputs** to your audio interface channels
4. **Fine-tune levels** for each speaker using the Matrix interface

**Pro tip:** Save Matrix presets for different venues - you can quickly switch between speaker configurations without rebuilding your spatial audio patches.

![Matrix Routing]({{ site.img }}/common-practices/matrix-routing.png)

## Faust spatialization: professional algorithms

*score* integrates with professional spatial audio libraries through [[Faust]], giving you access to industry-standard algorithms.

### Built-in spat algorithms

The Faust standard library includes `sp.spat` - a professional spatialization algorithm:

```faust
// 8-channel circular spatialization
process = vgroup("Spatializer", sp.spat(8, angle, distance));
```

**To use it:**
1. **Create a [[Faust]] process**  
2. **Use the sp.spat template** or write your own
3. **Connect angle and distance controls** from your spatial controllers
4. **Customize for your speaker count** by editing the Faust code

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

**To access abclib:**
1. **Check the [[Faust]] user library** for abclib presets
2. **Browse the ambisonics and spat folders** 
3. **Drag'n'drop presets** into your score for instant professional spatialization

### Comprehensive Faust spatialization objects

The Faust standard library (`spat.lib`) provides a rich collection of spatial audio algorithms. Here's what's available:

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

### SPARTA VST integration

The SPARTA (Spatial Audio Real-time Applications) suite provides professional VST plugins for advanced spatial audio processing. These work seamlessly within *score*'s plugin hosting capabilities.

#### Available SPARTA plugins

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

1. **Load as [[VST|VST plugins]]** in your score
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

Many audio effects in *score* automatically become polyphonic when you feed them multichannel audio - perfect for spatial processing.

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

## 3D and dome spatialization

For full 3D spatial audio installations, DBAP excels with irregular speaker arrangements:

### Dome configurations

**Speaker positioning:**
```javascript
// Hemispherical dome example
[
  [0, 1, 0],      // Top center
  [0.7, 0.7, 0],  // Upper ring
  [-0.7, 0.7, 0],
  [0.7, -0.7, 0], 
  [-0.7, -0.7, 0],
  [1, 0, -0.5],   // Lower ring
  [-1, 0, -0.5],
  [0, 1, -0.5],
  [0, -1, -0.5]
]
```

## Integration with external tools

### SpatGris connection

*score* can control external spatialization software via the [[SpatGris Device]]:

1. **Add SpatGris device** in the [[Device explorer]]
2. **Configure OSC connection** to your SpatGris instance
3. **Control spatial parameters** from *score* while using SpatGris algorithms
4. **Best of both worlds**: *score*'s temporal control with SpatGris' spatial processing

### Hardware integration

**Audio interfaces:**
- **Multichannel interfaces** for large speaker arrays
- **ADAT expansion** for 16+ channel spatial audio
- **Consider latency** for real-time spatial interaction

**Control surfaces:**
- **XY controllers** mapped to spatial position
- **Hardware encoders** for real-time spatial parameter control  
- **[[Mapping Tool]]** for custom controller response curves

## Troubleshooting spatial audio

### Common issues and solutions

**"I don't hear spatialization":**
- **Check Matrix routing** - are outputs connected to correct speakers?
- **Verify speaker positions** - coordinates should match physical layout
- **Test with simple content** - try sine waves before complex audio

**"Movement sounds choppy":**
- **Increase Path Generator resolution** for smoother trajectories  
- **Check audio buffer settings** - larger buffers reduce glitches
- **Use [[Rate Limiter]]** if spatial updates are too frequent

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
- **Use [[AI]] processes** to generate spatial movement patterns
- **Connect with [[Video]] processing** for audiovisual spatial installations

Spatial audio in *score* is designed to grow with your artistic vision - start simple and gradually build complexity as you explore the creative possibilities of sound in space.

## Related processes

Essential spatial audio processes: [[DBAP]], [[GBAP]], [[Matrix]], [[Path Generator]], [[Multi-Cursor]], [[Faust]], [[Audio Utilities]], [[Mapping Tool]], and [[SpatGris Device]].