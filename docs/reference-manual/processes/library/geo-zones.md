---
layout: default

title: Geo Zones
description: "2D spatial zone-based parameter interpolation"

parent: Processes
grand_parent: Reference

permalink: /processes/geo-zones.html
---
# Geo Zones

![Geo Zones]({{ site.img }}/reference/processes/geo-zones.png "Geo Zones")

Create interactive zones in 2D space where parameters change based on position within those zones. Define areas with different behaviors and interpolate smoothly between them as objects or people move through the space.

Perfect for location-based installations, interactive floor projections, or any system where you want different behaviors in different areas of a physical or virtual space.

## How it works

Geo Zones lets you define multiple zones in a 2D coordinate system, each with its own parameter values. As a position input moves through this space, the system interpolates between zone values to create smooth transitions.

**Position input** - XY coordinates representing location in 2D space  
**Zone definition** - Create zones with shapes, positions, and parameter values  
**Interpolation** - Smooth blending between zone parameters  
**Multiple outputs** - Different parameters can have different zone configurations

## Zone types and shapes

**Circular zones**: Define zones as circles with center points and radii - perfect for proximity-based interactions.

**Rectangular zones**: Rectangular areas aligned to coordinate axes for architectural spaces or screen regions.

**Polygonal zones**: Custom polygon shapes for irregular spaces or complex architectural layouts.

**Point zones**: Single points that influence surrounding areas with distance-based falloff.

## Parameter interpolation

**Distance-based**: Parameters change based on distance from zone centers, creating smooth gradients.

**Weighted blending**: Multiple zones can influence the same position, with weights based on proximity and zone strength.

**Sharp boundaries**: Option for zones to have hard edges rather than smooth transitions for discrete area behaviors.

**Falloff curves**: Customizable curves that determine how quickly influence decreases with distance.

## Creative applications

**Interactive floors**: Create floor projections where different areas trigger different sounds, visuals, or lighting as people walk through them.

**Spatial audio zones**: Use position tracking to control [[DBAP]] or [[GBAP]] spatialization parameters, creating areas with different acoustic characteristics.

**Installation narratives**: Create story-driven installations where different physical locations trigger different narrative elements or media content.

**Performance spaces**: Design performance areas where musicians or dancers moving to different stage positions automatically affect sound or lighting parameters.

**Gallery interactivity**: Let gallery visitors discover different content by exploring different areas of an exhibition space.

## Integration techniques

**Position tracking**: Combine with [[Kinect]] for body tracking, camera-based computer vision, or other position tracking systems.

**Multi-user support**: Track multiple people simultaneously and blend their influences on the parameter space.

**3D extension**: Use multiple Geo Zones processes for different height levels to create 3D interactive spaces.

**Time-based changes**: Animate zone parameters over time to create evolving spatial behaviors.

## Zone configuration workflow

1. **Define your physical space** - Map your installation area to coordinate system
2. **Create zones** - Add zones where you want different behaviors  
3. **Assign parameters** - Set what each zone should control and how
4. **Test interpolation** - Check smooth transitions between zones
5. **Fine-tune boundaries** - Adjust zone sizes and falloff characteristics

## Advanced features

**Zone priorities**: Set which zones take precedence when areas overlap.

**Conditional zones**: Zones that only become active under certain conditions or at certain times.

**Dynamic zones**: Zones that can move, resize, or change parameters during operation.

**Layered systems**: Multiple Geo Zones processes controlling different aspects of the same space.

## Integration with tracking systems

**[[Kinect]] tracking**: Use skeletal tracking data to get precise body positions for zone interaction.

**Camera tracking**: Computer vision systems can provide position data for multiple people or objects.

**Mobile devices**: Smartphones or tablets can provide position data through GPS, accelerometers, or manual input.

**Custom sensors**: Any system that provides XY coordinates can drive Geo Zones.

## Performance considerations

**Zone complexity**: More complex zone shapes and overlapping zones require more processing - balance complexity with performance needs.

**Update rates**: Consider how often position data updates and adjust zone responsiveness accordingly.

**Interpolation quality**: Smoother interpolation looks better but requires more computation - find the right balance for your application.

## Related processes

Geo Zones works perfectly with position tracking from [[Kinect]], [[Computer Vision Utilities]], or [[OSC]]-based tracking systems. Output can control [[DBAP]]/[[GBAP]] for spatial audio, [[Audio Effects]] for zone-based processing, or [[Video]] systems for visual zone effects.