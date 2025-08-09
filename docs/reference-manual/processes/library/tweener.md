---
layout: default

title: Tweener
description: "Smooth parameter interpolation and easing"

parent: Processes
grand_parent: Reference

permalink: /processes/tweener.html
---
# Tweener

![Tweener]({{ site.img }}/reference/processes/tweener.png "Tweener")

Create smooth transitions between values with professional easing curves. Instead of abrupt parameter changes, Tweener provides fluid, organic movement that feels natural and polished.

Essential for creating smooth animations, gentle parameter transitions, or any time you need to interpolate between different values with precise timing control.

## How it works

Tweener takes a start value, an end value, and a duration, then generates a smooth interpolation between them using selectable easing curves.

**From** - Starting value  
**To** - Target value  
**Duration** - How long the transition takes  
**Easing** - The interpolation curve (linear, ease-in, ease-out, bounce, elastic, etc.)  
**Trigger** - Start the tween with an impulse

## Easing curve types

**Linear** - Constant rate of change  
**Ease In/Out** - Accelerate at start, decelerate at end  
**Quadratic/Cubic** - Various polynomial curves  
**Bounce** - Bouncing ball effect at the end  
**Elastic** - Spring-like overshoot and settle  
**Back** - Slight reverse before moving forward

Each curve creates a different feeling of movement - mechanical, organic, playful, or dramatic.

## Creative applications

**Parameter automation**: Create smooth filter sweeps, volume fades, or spatial movement that feels natural rather than robotic.

**Visual transitions**: Smooth color changes, brightness fades, or position animations for video and graphics processing.

**Audio morphing**: Gradual transitions between different audio effect settings for seamless sonic evolution.

**Interactive response**: When sensors or controllers trigger changes, use Tweener to make the response feel fluid rather than jarring.

**Sequence building**: Chain multiple Tweeners to create complex, multi-stage parameter journeys.

## Advanced techniques

**Chaining**: Connect the completion output of one Tweener to trigger the next for sequential animations.

**Parallel movement**: Run multiple Tweeners simultaneously for coordinated multi-parameter changes.

**Interactive interruption**: Retrigger Tweeners mid-transition for responsive, dynamic parameter control.

**Curve layering**: Use different easing curves on related parameters for complex, organic movement patterns.

Perfect for smoothing out [[Mapping Tool]] responses, creating fluid transitions between [[Preset]] states, or adding polish to any parameter changes in your score.

## Related processes

Works with [[LFO]] for cyclical movements, [[Trigger]] for conditional tweening, [[Preset]] systems for smooth state transitions, or any process that benefits from smooth parameter changes rather than instant jumps.