---
layout: default

title: Gradient Scrubber
description: "Interactive gradient manipulation and color control"

parent: Processes
grand_parent: Reference

permalink: /processes/gradient-scrubber.html
---
# Gradient Scrubber

![Gradient Scrubber]({{ site.img }}/reference/processes/gradient-scrubber.png "Gradient Scrubber")

Scrub through color gradients interactively to extract colors and create dynamic color sequences. This process lets you define color gradients and then "scrub" through them with a position control, outputting the resulting colors for use in lighting, video effects, or other visual applications.

Perfect for dynamic lighting control, color-based installations, or any project where you need smooth color transitions controlled by sensors, automation, or user interaction.

## How it works

Gradient Scrubber creates a color gradient from your defined color stops, then uses a position parameter (0-1) to extract colors from any point along the gradient.

**Gradient definition** - Set up your color gradient with multiple color stops and positions  
**Position control** - Scrub through the gradient (0.0 = start, 1.0 = end)  
**Color output** - Get RGB, HSV, or other color format outputs  
**Interpolation** - Smooth color blending between your defined stops

## Gradient creation

**Color stops**: Define key colors at specific positions along the gradient - you can have as many as needed for complex color schemes.

**Position mapping**: Each color stop has a position value, allowing for non-uniform color distribution along the gradient.

**Interpolation modes**: Choose between linear, cubic, or other interpolation methods for different color blending characteristics.

**Color spaces**: Work in RGB, HSV, or other color spaces depending on your desired color transitions.

## Creative applications

**Dynamic lighting**: Control LED installations, architectural lighting, or stage lighting with smooth color transitions based on musical content, sensor data, or user interaction.

**Video effects**: Generate color sequences for video processing, background generation, or visual effect parameters.

**Interactive installations**: Map user gestures, sensor readings, or other control data to color gradient positions for responsive color environments.

**Sunset/sunrise simulation**: Create natural color progressions that follow environmental or temporal patterns.

**Mood lighting**: Generate color sequences that respond to audio content, creating synchronized lighting and sound experiences.

## Integration techniques

**Sensor control**: Map sensor data to gradient position using [[Mapping Tool]] - temperature sensors could control warm/cool color transitions, motion sensors could trigger color changes.

**Audio synchronization**: Use [[Audio Effects|audio analysis]] to drive gradient position based on music tempo, frequency content, or amplitude.

**Timeline automation**: Automate gradient position over time for predetermined color sequences that sync with other timeline elements.

**Multi-gradient systems**: Use multiple Gradient Scrubbers for different color aspects - one for hue, another for brightness, creating complex color evolution.

## Technical features

**Real-time processing**: Fast color interpolation suitable for high-frequency control and smooth color transitions.

**Multiple outputs**: Simultaneous RGB, HSV, and other color format outputs for different types of devices and applications.

**Smooth interpolation**: Advanced color blending algorithms prevent harsh transitions and color banding.

**Preset management**: Save and recall gradient configurations for different moods, scenes, or installation requirements.

## Workflow tips

**Color theory**: Use complementary colors and natural color progressions for pleasing visual results.

**Position mapping**: Consider using [[Mapping Tool]] to shape the position control response - ease-in/out curves can create more natural color timing.

**Multiple gradients**: Layer different color aspects by using separate gradients for hue, saturation, and brightness control.

**Testing**: Always test gradients with your actual lighting or display hardware, as different devices reproduce colors differently.

## Integration with lighting

**RGB LED strips**: Direct connection to RGB color outputs for pixel-perfect color reproduction.

**DMX lighting**: Convert color outputs to DMX values for professional lighting control.

**Smart bulbs**: Control Philips Hue, LIFX, or other smart lighting systems through [[HTTP]] or other network protocols.

**Projection systems**: Feed color data to video systems for large-scale color projection and mapping.

## Related processes

Perfect companion to [[Mapping Tool]] for position control shaping, [[LFO]] for cyclical color movements, lighting device protocols for hardware control, or [[Video]] processes for visual color applications.