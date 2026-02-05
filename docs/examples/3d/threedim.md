---
layout: default

title: 3D meshes
description: "An example showing how to load and manipulate 3D meshes"

parent: 3D Graphics
grand_parent: Examples

permalink: /examples/3d/threedim.html
---

# 3D Meshes

This example demonstrates loading and displaying 3D meshes in ossia score.

## Overview

ossia score can load 3D models and render them in real-time, with parameters that can be animated and modulated.

## Procedural mesh generators

Built-in geometry primitives include:
- Icosahedron
- Sphere
- Cube
- Torus
- Plane
- Custom parametric shapes

## 3D rendering features

The Model Display process supports:
- Diffuse textures
- Normal mapping
- PBR materials
- Custom shaders
- Multiple light sources

## Animating 3D objects

3D parameters can be controlled by:
- Timeline automation
- LFOs and modulators
- Audio analysis
- External devices (OSC, MIDI)
- Script processes

## Try it

Open this example to see animated 3D geometry. Try changing the LFO parameters to alter the animation!

[Download this example]({{ site.scores }}/examples/3d/threedim.score)

## Learn more

- [[3D primitive]] - Built-in procedural mesh generators
- [[Object loader]] - Loading 3D models and supported formats
- [[Model display]] - 3D mesh rendering process
- [[Graphics pipeline]] - How rendering works in ossia score
- [[Supported protocols and formats]] - Complete list of supported 3D formats
