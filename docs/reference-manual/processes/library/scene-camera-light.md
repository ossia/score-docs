---
layout: default
title: Cameras and lighting
description: "Author native scene cameras, lights and shadow-cascade data"
parent: Processes
grand_parent: Reference
permalink: /processes/scene-camera-light.html
---

# Cameras and lighting

These tools emit scene contributions. Combine them with models using **Scene Group**, then preprocess and render the result; see [[3D scene pipeline]]. They are distinct from the built-in camera controls of [[Model display]] and from QML cameras in Qt Quick 3D.

## Camera

Emits a **Scene** containing a perspective camera and its transform. **Eye** is the camera position, **Target** is the look-at point, **FOV** is the field of view in degrees, **Near/Far** set clipping distances, and **Roll** rotates around the viewing direction. The initial Eye is `(1, 1, 1)` looking toward the origin.

Automate Eye and Target for a camera move. Keep the clipping range appropriate for the asset scale; a camera inside geometry or an overly large near plane can hide the model.

## Camera Array

Emits six cameras around **Origin**, facing the cubemap directions `+X`, `-X`, `+Y`, `-Y`, `+Z`, `-Z`. **Near** and **Far** set their clipping range. The views are square cubemap faces, not six arbitrary camera positions.

Use this with a compatible multiview render pipeline for cubemap captures, reflection probes or point-light shadow views. A non-multiview consumer sees the active `+X` camera rather than an automatically stitched panoramic image. Backend multiview support and the renderer's target configuration still matter.

## Camera Switch

Accepts **Camera 0–3** scene inputs. In **Select** mode, **Index** chooses one input. In **Blend** mode, **Weights** supplies four weights: negative values are clamped to zero, missing inputs contribute nothing, and usable weights are normalized.

Blend interpolates position, clipping distances and field of view, and blends orientation quaternions. Use camera-only inputs for predictable transitions; it is not a general scene morph. With no effective input weight the output is empty.

## Light

Emits a **Scene** with a light. **Mode** selects Directional, Point, Spot, Rect, Disk, Sphere or Dome. **Color** and **Intensity** apply to all modes. Positional lights use **Range** (`0` for unbounded falloff), with **Falloff** None, Linear, Quadratic (physical) or Cubic.

- Spot lights use **Inner cone °** and **Outer cone °**.
- Area modes use **Width**, **Height** or **Radius** according to their shape.
- **Position** and **Rotation** place the light; rotation determines directional/spot orientation.
- **Cast shadow**, **Shadow bias** and **Shadow normal bias** author shadow settings.

A light component describes the light; the downstream shader determines which light shapes and shading models it implements. Creating a light does not make an unlit shader evaluate it.

## Shadow Cascade Setup

Takes **Scene In** and produces **Scene Out** with directional-shadow cascade data. Set **Cascade count** (`1–8`), **Shadow distance** and **Split lambda** (linear/logarithmic split mix). Keep **Camera near** and **Camera far** consistent with the view camera. **Light direction** can override the scene's directional-light direction.

This is setup data, not a complete shadow renderer. The patch still needs shadow-map rendering, a matching shadow texture resource and a shader that samples it. See **Scene Resource Route** in [[Environments and cubemaps]] and [[Render Pipeline]] for the resource/rendering side.
