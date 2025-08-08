---
layout: default

title: Meshes
description: "3D mesh loading and processing"

parent: Processes
grand_parent: Reference

permalink: /processes/meshes.html
---
# 3D Meshes

![Meshes]({{ site.img }}/reference/processes/meshes.png "Meshes") 

Ossia score provides comprehensive support for loading and processing 3D mesh data through the **Object Loader** process, supporting both traditional mesh formats and point cloud data.

## Object Loader {#obj-loader}

The Object Loader process loads 3D geometry from external files and makes it available for rendering in ossia score's graphics pipeline.

### Supported Formats

#### OBJ Files (.obj)
- Complete Wavefront OBJ specification support
- Vertex positions, normals, and texture coordinates
- Multi-material support
- Face definitions (triangles, quads, polygons)
- Material library (.mtl) files

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
**Content**: Loaded mesh data with all attributes

The output provides complete mesh data including:
- Vertex positions
- Normals (for lighting calculations)
- UV texture coordinates
- Color information (when available)
- Multiple mesh objects (for complex models)

### Usage Examples

#### Architectural Visualization
```
OBJ Loader (building.obj) → ISF Shader → 3D Renderer
```

Load architectural models and apply procedural shading for real-time visualization.

#### Character Animation
```
OBJ Loader (character.obj) → Geometry Filter → Animation System
```

Load character models and apply transformations for interactive performances.

#### Point Cloud Visualization
```
OBJ Loader (scan.ply) → Point Cloud to Mesh → Visual Effects
```

Load PLY point cloud files from 3D scanners and convert them for further processing.

### Technical Details

#### Coordinate System
Uses standard 3D graphics conventions:
- **Right-handed coordinate system**
- **Y-up orientation** (can be adjusted with rotation)
- **Counter-clockwise** face winding

#### Performance Considerations
- Large meshes are loaded asynchronously
- Mesh data is cached for repeated use
- GPU memory usage scales with model complexity

### Integration Workflows

#### Game Asset Pipeline
```
3D Modeling Software → Export OBJ/PLY → Object Loader → ossia score
```

#### 3D Scanning Workflow
```
3D Scanner → PLY Export → Object Loader → Point Cloud Processing
```

#### Procedural Generation
```
Parametric Generator → OBJ Export → Object Loader → Real-time Visualization
```

### Best Practices

#### File Organization
- Use relative paths when possible for project portability
- Keep texture files in the same directory as OBJ files
- Use descriptive filenames for complex scenes

#### Performance Optimization
- Optimize mesh resolution for real-time use
- Consider level-of-detail (LOD) versions for complex models
- Use efficient UV layouts for texture mapping

#### Quality Guidelines
- Ensure proper normals for lighting
- Use consistent scaling across models
- Validate mesh integrity before import

### Troubleshooting

#### Common Issues
- **Missing textures**: Ensure MTL files and textures are in the correct paths
- **Incorrect scale**: Adjust the scale parameter or re-export at correct size
- **Lighting problems**: Check normal vectors and face winding

#### File Format Limitations
- Some advanced OBJ features may not be supported
- Complex PLY variants might require preprocessing
- Very large files may impact loading performance

### Related Processes

- **Point Cloud to Mesh**: Convert point cloud data to renderable geometry
- **Geometry Filter**: Transform and modify loaded meshes
- **ISF Shader**: Apply materials and effects to 3D geometry
- **3D Renderer**: Final visualization and compositing