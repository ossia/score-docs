---
layout: default

title: Display Utilities
description: "Display management and output utilities"

parent: Processes
grand_parent: Reference

permalink: /processes/display-utilities.html
---
# Display Utilities

![Display Utilities]({{ site.img }}/reference/processes/display-utilities.png "Display Utilities")

Manage displays, screens, and output devices for multi-screen installations, projection mapping, and complex visual setups. These utilities help you route visual content to different displays with precise control over positioning, scaling, and configuration.

Essential for installations with multiple projectors, LED walls, or any setup where you need to distribute visual content across multiple display devices.

## Display management features

**Multi-screen support**: Route different visual content to different displays simultaneously, perfect for wraparound installations or multi-projector setups.

**Resolution handling**: Automatically adapt content to different display resolutions and aspect ratios without losing quality or proportions.

**Positioning control**: Precise placement of visual content within display boundaries, essential for edge-blending and geometric correction.

**Fullscreen management**: Switch between windowed and fullscreen modes programmatically for different performance scenarios.

**Display detection**: Automatic discovery and configuration of connected displays and projectors.

## Projection mapping support

**Geometric correction**: Tools for keystone correction, perspective adjustment, and surface mapping to project onto irregular surfaces.

**Edge blending**: Smooth blending between overlapping projectors for seamless large-scale displays.

**Warping controls**: Real-time geometric warping to fit projections onto curved or complex surfaces.

**Calibration tools**: Alignment and calibration utilities for precise multi-projector installations.

## Creative applications

**Immersive environments**: Create 360-degree visual experiences using multiple projectors or displays arranged around the audience.

**Architectural projection**: Map visuals onto buildings, sculptures, or architectural features with precise geometric alignment.

**Performance stages**: Distribute visual content across multiple screens for theater, concerts, or multimedia performances.

**Gallery installations**: Manage complex multi-screen installations with different content on each display.

**Control room displays**: Distribute monitoring, control, and performance information across multiple screens for technical operations.

## Integration with score

Display Utilities work closely with [[Video]] processes to route content to appropriate displays. They can be controlled by [[Mapping Tool]] for dynamic display switching, integrated with [[OSC]] for remote display control, or synchronized with [[Audio Effects]] for audio-reactive display management.

**Real-time switching**: Change display configurations during performance without interrupting visual flow.

**Content scaling**: Automatically adapt visual content to different display configurations and resolutions.

**Synchronization**: Ensure frame-accurate synchronization across multiple displays for seamless visual experiences.

## Technical considerations

**Graphics performance**: Multi-display setups require significant GPU resources - plan hardware accordingly for your installation size.

**Cable management**: Consider signal degradation over long cable runs for large installations - use appropriate signal boosters or fiber optic solutions.

**Display timing**: Different displays may have different refresh rates and timing characteristics - Display Utilities help manage these differences.

**Color calibration**: Multiple displays may have different color characteristics - use calibration tools to ensure consistent appearance.

## Setup workflow

1. **Connect displays** and verify recognition by the operating system
2. **Configure Display Utilities** to recognize and map your display arrangement  
3. **Route content** from video sources to appropriate displays
4. **Calibrate geometry** and color for consistent appearance
5. **Test transitions** and switching between different display configurations

## Performance optimization

**GPU usage**: Monitor GPU utilization when using multiple high-resolution displays - consider dedicated graphics hardware for complex installations.

**Memory management**: High-resolution multi-display setups use significant video memory - ensure adequate VRAM for your content.

**Refresh synchronization**: Synchronize refresh rates across displays when possible for smoothest visual performance.

## Related processes

Display Utilities work with [[Video]] for content routing, [[Graphics Utilities]] for visual processing, and can be controlled by [[OSC]] for remote management or [[Mapping Tool]] for parameter automation.