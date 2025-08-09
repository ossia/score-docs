---
layout: default

title: Kinect device
description: "3D depth sensing and body tracking"

parent: Devices
grand_parent: Reference

permalink: /devices/kinect-device.html
---
# Kinect device

![Kinect device]({{ site.img }}/reference/devices/kinect.png "Kinect device")

Transform any space into an interactive environment with Microsoft Kinect sensors. Get real-time 3D depth data, RGB camera feeds, and skeletal body tracking for responsive installations and performances.

Perfect for gallery installations, interactive performances, or any project where you need to sense people and objects in 3D space without requiring them to wear anything or hold controllers.

## Setting up a Kinect device

1. **Connect your Kinect sensor** via USB (USB 3.0 required for Kinect v2)
2. **Install drivers** - libfreenect for Kinect v1, libfreenect2 for Kinect v2
3. **Add device** in the [[Device explorer]] and choose "Kinect"
4. **Configure settings** for your space and intended use

The Kinect works best in well-lit environments and needs about 1-4 meters of clear space in front of the sensor for optimal tracking.

## Available data streams

### Depth sensing
**Resolution**: 512×424 (Kinect v2) or 640×480 (Kinect v1)  
**Range**: 0.5-4.5 meters effective sensing distance  
**Data**: Real-time depth maps with millimeter precision  
**Output**: Point clouds, depth images, distance measurements

### RGB camera
**Quality**: High-resolution color image capture  
**Sync**: Synchronized with depth data for precise registration  
**Use cases**: Visual feedback, color-based tracking, documentation

### Skeletal tracking
**Bodies**: Up to 6 people simultaneously (Kinect v2)  
**Joints**: 25 tracked body joints per person  
**Data**: 3D coordinates, rotation, and confidence levels for each joint  
**Applications**: Gesture recognition, pose analysis, motion capture

### Point cloud data
**Registration**: Depth and color data aligned in 3D space  
**Export**: Real-time 3D point clouds for spatial analysis  
**Integration**: Perfect for feeding into [[Point Cloud]] processing

## Creative applications

**Responsive environments**: Create installations that react to people entering, moving through, or interacting with specific zones in your space.

**Gesture control**: Map specific body movements to audio parameters, visual effects, or scene changes - wave your hand to control reverb, raise your arms to brighten lights.

**Proximity interactions**: Use distance data to create gradual responses - sounds that get louder as people approach, visuals that change based on how many people are present.

**3D visualization**: Feed depth data into visualization systems for real-time 3D representation of your space and the people within it.

**Motion analysis**: Track movement patterns, analyze crowd behavior, or create systems that respond to the energy level of activity in your space.

## Integration with score processes

**[[Mapping Tool]]**: Convert raw skeleton coordinates into useful parameter ranges - map arm height to audio frequency or walking speed to tempo changes.

**[[DBAP]]/[[GBAP]]**: Use tracked body positions for spatial audio that literally follows people around the room.

**[[Geometry Filter]]**: Process point cloud data to detect specific shapes, poses, or spatial arrangements.

**[[Computer Vision Utilities]]**: Combine Kinect depth data with traditional computer vision for robust tracking and recognition.

**[[Point Cloud]]**: Direct integration with point cloud processing for advanced 3D analysis and visualization.

## Advanced techniques

**Zone detection**: Create virtual zones in 3D space and trigger events when people enter, exit, or occupy them for specific durations.

**Pose recognition**: Train systems to recognize specific poses or gestures and trigger complex sequences in response.

**Crowd analysis**: Use multiple body tracking to analyze group behavior, social distancing, or collective movement patterns.

**Persistence tracking**: Maintain identity of individuals as they move through the space for more sophisticated interaction design.

## Technical considerations

**Hardware versions**: Kinect v1 uses USB 2.0 and older tracking algorithms, Kinect v2 requires USB 3.0 but provides much better resolution and tracking.

**Lighting requirements**: Infrared depth sensing works in low light, but skeletal tracking performs better with good ambient lighting. Avoid direct sunlight or IR interference.

**Processing load**: Real-time depth processing and skeletal tracking can be CPU-intensive - consider dedicated hardware for complex installations.

**Range limitations**: Effective tracking range is 1-4 meters - plan your installation space accordingly. Too close or too far reduces tracking accuracy.

## Troubleshooting

**Poor tracking**: Check lighting conditions, ensure clear line of sight, verify people are within the optimal 1.5-3 meter range.

**Driver issues**: Ensure correct libfreenect version for your Kinect model, check USB port power and data transfer capabilities.

**Performance problems**: Reduce tracking resolution or frame rate if experiencing lag, consider running Kinect processing on dedicated hardware.

**Calibration**: Some installations benefit from manual calibration to account for mounting angle and height - use the built-in calibration tools.

The Kinect device works beautifully with [[Computer Vision Utilities]] for enhanced tracking, combines with [[OSC]] for network distribution of tracking data, and integrates with [[Video]] processing for augmented reality applications.

## Related devices

Enhance with [[Camera]] devices for additional visual tracking, use [[OSC]] to network Kinect data between systems, or combine with [[Wiimote]] for hybrid gesture and depth sensing setups.