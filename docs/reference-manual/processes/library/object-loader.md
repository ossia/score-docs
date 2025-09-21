---
layout: default

title: Object loader
description: "Loader 3D geometry files (OBJ, PLY)"

parent: Processes
grand_parent: Reference

permalink: /processes/object-loader.html
---

# Object loader

![Object loader]({{ site.img }}/reference/processes/object-filter.png "Object loader")

Ossia score provides comprehensive support for loading and processing 3D mesh data through the **Object Loader** process, supporting both traditional mesh formats and point cloud data.

The Object Loader process loads 3D geometry from external files and makes it available for rendering in ossia score's graphics pipeline.

### Supported Formats

#### OBJ Files (.obj)
- Complete Wavefront OBJ specification support
- Vertex positions, normals, color, texture coordinates
- Multi-geometry support

#### PLY Files (.ply)
- Stanford PLY format support
- Point cloud data with positions and colors
- Mesh data with connectivity information
- Binary and ASCII PLY formats
- Vertex properties: position, normal, color, texture coordinates

### Parameters

#### 3D File
**Type**: File input  
**Supported Extensions**: `*.obj`, `*.ply`

Select the 3D file to load. The process will automatically detect the format and parse the geometry data accordingly.

#### Position
**Type**: 3D Vector (X, Y, Z)  
**Default**: (0, 0, 0)

Sets the world position of the loaded mesh in 3D space.

#### Rotation
**Type**: 3D Vector (X, Y, Z) - Euler angles  
**Default**: (0, 0, 0)

Sets the rotation of the loaded mesh around each axis in degrees.

#### Scale
**Type**: 3D Vector (X, Y, Z)  
**Default**: (1, 1, 1)

Sets the scale factor for the mesh along each axis.

### Output

#### Geometry
**Type**: Dynamic 3D geometry collection  


## Related Processes

- [Model Display](/processes/model-display.html) - Displays a 3D model
- [Structure Synth](/processes/structure-synth.html) - Generative procedural geometry

## Try it!

Try it by downloading this [simple example!]({{ site.scores }}/reference/processes/3d.score)