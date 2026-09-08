---
layout: default

title: Meshes
description: "Generate and load 3D meshes: primitives, OBJ/PLY loader, noise, splats"

parent: Processes
grand_parent: Reference

permalink: /processes/meshes.html
---
# Meshes

<!-- TODO screenshot: ![Meshes]({{ site.img }}/reference/processes/meshes.png "Meshes") -->

A family of processes that produce or modify mesh geometry for the 3D pipeline. Each
outputs a **Geometry** that can be rendered or fed to geometry utilities. All of them share
**Position**, **Rotation** and **Scale** transform controls.

## Mesh Primitive

Generates a parametric primitive: **Plane**, **Cube**, **Sphere**, **Icosahedron**,
**Cone**, **Cylinder** or **Torus**. Each primitive exposes its own parameters (subdivision,
radius, …).

## Object loader

Loads a 3D model from an **OBJ** or **PLY** file. Drop a file on the **3D file** port; the
process outputs the loaded mesh(es).

## Splat loader

Loads a [Gaussian splatting](https://en.wikipedia.org/wiki/Gaussian_splatting) model
(3DGS) from a PLY file and outputs it as a GPU buffer for splat rendering.

## Mesh Noise

Deforms an incoming geometry with noise. Each axis (**X / Y / Z**) can be displaced using
**None**, **Noise** or **Sine**, with an independent **Intensity** per axis. Connect a
geometry to its input and route the output to a renderer.
