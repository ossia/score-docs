---
layout: default

title: Render Pipeline
description: "Using raw raster render pipelines in the ossia score graphics pipeline"

parent: Processes
grand_parent: Reference

permalink: /processes/render-pipeline.html
---

# Render Pipeline (Raw Raster)

The Render Pipeline process provides a raw vertex/fragment shader pipeline with full control over vertex inputs, outputs, blending, and topology. Unlike [[ISF Shader|ISF shaders]] which operate on a fullscreen quad, the Render Pipeline renders arbitrary geometry received through its input port.

This is the process to use when you need custom 3D rendering: connect a geometry source (e.g., a [[Compute Shader|CSF compute shader]], [[Model Display]], or geometry loader) and write your own vertex and fragment shaders.

# File structure

A Render Pipeline consists of two files with the same base name:

- `MyShader.fs` — Fragment shader (contains the JSON header)
- `MyShader.vs` — Vertex shader

Place these files in the [[library|user library]] and they will be detected automatically.

# JSON header

The JSON header is placed in the **fragment shader** (`.fs`) file, enclosed in `/*{ ... }*/`.

## Required fields

```json
{
  "MODE": "RAW_RASTER_PIPELINE",
  "VERTEX_INPUTS": [...],
  "VERTEX_OUTPUTS": [...],
  "FRAGMENT_INPUTS": [...],
  "FRAGMENT_OUTPUTS": [...]
}
```

## Optional fields

- `"DESCRIPTION"`: Human-readable description.
- `"CREDIT"`: Author credit.
- `"ISFVSN"`: Version string (use `"2"`).
- `"CATEGORIES"`: Array of category strings.
- `"INPUTS"`: Array of scalar input declarations (same as ISF: `float`, `bool`, `long`, `point2D`, `point3D`, `color`, `event`, `image`).

# Attribute declarations

## VERTEX_INPUTS

Declares what vertex attributes the vertex shader expects. These are matched against the incoming geometry by **semantic** (attribute name → known semantic) or by **name** (for custom attributes).

```json
"VERTEX_INPUTS": [
  { "TYPE": "vec4", "NAME": "position" },
  { "TYPE": "vec4", "NAME": "normal" },
  { "TYPE": "vec4", "NAME": "color" }
]
```

| Field | Description |
|---|---|
| `"NAME"` | Variable name in the vertex shader. Also used for semantic matching (see below). |
| `"TYPE"` | GLSL type (`float`, `vec2`, `vec3`, `vec4`, `mat4`, `int`, `ivec2`, etc.) |
| `"LOCATION"` | *(optional)* Explicit location. Auto-assigned sequentially if omitted. |

### Semantic matching

When the pipeline receives geometry, vertex inputs are matched to geometry attributes by name-to-semantic mapping. The following names are recognized as standard semantics:

| Name | Semantic |
|---|---|
| `position` | Position |
| `normal` | Normal |
| `texcoord` | Texture coordinate |
| `color` | Color |
| `tangent` | Tangent |

Any other name is treated as a custom semantic and matched by exact name against the geometry's attribute names. This means that if a [[Compute Shader|CSF compute shader]] outputs an attribute with `"SEMANTIC": "translation"`, your vertex shader should declare a `VERTEX_INPUT` named `translation` to receive it.

## VERTEX_OUTPUTS

Declares what the vertex shader passes to the fragment shader.

```json
"VERTEX_OUTPUTS": [
  { "TYPE": "vec3", "NAME": "v_normal" },
  { "TYPE": "vec4", "NAME": "v_color" }
]
```

## FRAGMENT_INPUTS

Declares what the fragment shader receives from the vertex shader. Must match `VERTEX_OUTPUTS` in order and types.

```json
"FRAGMENT_INPUTS": [
  { "TYPE": "vec3", "NAME": "v_normal" },
  { "TYPE": "vec4", "NAME": "v_color" }
]
```

## FRAGMENT_OUTPUTS

Declares the fragment shader outputs.

```json
"FRAGMENT_OUTPUTS": [
  { "TYPE": "vec4", "NAME": "isf_FragColor" }
]
```

If omitted, defaults to a single `vec4` output named `isf_FragColor` at location 0.

# Built-in controls

The Render Pipeline automatically adds the following controls to the process inspector (they do not need to be declared in `"INPUTS"`):

## Topology

- **Mode**: `Triangles` (default), `Points`, or `Lines`

## Blending

- **EnableBlend**: Toggle alpha blending
- **SrcColor** / **DstColor**: Source and destination color blend factors
- **OpColor**: Color blend operation
- **SrcAlpha** / **DstAlpha**: Source and destination alpha blend factors
- **OpAlpha**: Alpha blend operation

### Blend factors

`Zero`, `One`, `SrcColor`, `OneMinusSrcColor`, `DstColor`, `OneMinusDstColor`, `SrcAlpha`, `OneMinusSrcAlpha`, `DstAlpha`, `OneMinusDstAlpha`, `ConstantColor`, `OneMinusConstantColor`, `ConstantAlpha`, `OneMinusConstantAlpha`, `SrcAlphaSaturate`

### Blend operations

`Add`, `Subtract`, `ReverseSubtract`, `Min`, `Max`

Changing any blend or topology setting recreates the GPU pipeline, so these are best treated as setup parameters rather than animated values.

# Built-in uniforms

The Render Pipeline provides the following uniforms:

## Standard uniforms (same as ISF)

| Uniform | Type | Description |
|---|---|---|
| `TIME` | `float` | Playback time in seconds |
| `TIMEDELTA` | `float` | Time since last frame |
| `PROGRESS` | `float` | Timeline progress 0-1 |
| `FRAMEINDEX` | `int` | Frame counter |
| `RENDERSIZE` | `vec2` | Output size in pixels |
| `DATE` | `vec4` | `(year, month, day, seconds)` |
| `clipSpaceCorrMatrix` | `mat4` | Platform clip space correction matrix |

## Model transform

| Uniform | Type | Description |
|---|---|---|
| `MODEL_MATRIX` | `mat4` | Model transform matrix from upstream geometry source |

Multiply your view/projection matrices with `clipSpaceCorrMatrix` and use `MODEL_MATRIX` for the object transform:

```glsl
gl_Position = clipSpaceCorrMatrix * proj * view * MODEL_MATRIX * position;
```

Note that `clipSpaceCorrMatrix` is **not** a projection matrix — it only corrects for platform differences in clip space conventions. You must build your own view and projection matrices in the vertex shader (see examples below).

# Depth testing

The Render Pipeline enables depth testing and depth writing by default, unlike ISF shaders. This is necessary for correct 3D rendering with overlapping geometry.

# Writing shaders

## Vertex shader (.vs)

The vertex shader receives geometry attributes as `in` variables and must write `gl_Position`. Pass data to the fragment shader via `out` variables declared in `VERTEX_OUTPUTS`.

```glsl
void main() {
    // Build your own view/projection, then apply clipSpaceCorrMatrix
    gl_Position = clipSpaceCorrMatrix * proj * view * vec4(position.xyz, 1.0);
    v_normal = normal.xyz;
    v_color = color;

#if defined(QSHADER_SPIRV) || defined(QSHADER_HLSL) || defined(QSHADER_MSL)
    gl_Position.y = -gl_Position.y;
#endif
}
```

The Y-flip guard is necessary for correct rendering across graphics backends (Vulkan, Metal, Direct3D flip Y relative to OpenGL).

## Fragment shader (.fs)

The fragment shader receives interpolated values from the vertex shader and writes the output color:

```glsl
void main() {
    vec3 n = normalize(v_normal);
    vec3 lightDir = normalize(vec3(0.3, 0.7, 0.5));
    float diffuse = max(dot(n, lightDir), 0.0);
    isf_FragColor = vec4(v_color.rgb * (0.25 + 0.75 * diffuse), v_color.a);
}
```

# Examples

## Instanced cubes with diffuse lighting

This example renders instanced geometry from a [[Compute Shader|CSF compute shader]] with per-vertex positions/normals and per-instance translations/colors.

### Fragment shader (InstancedGrid.fs)

```glsl
/*{
  "DESCRIPTION": "Renders instanced geometry with simple diffuse lighting",
  "ISFVSN": "2",
  "MODE": "RAW_RASTER_PIPELINE",
  "CATEGORIES": ["3D"],
  "VERTEX_INPUTS": [
    { "TYPE": "vec4", "NAME": "position" },
    { "TYPE": "vec4", "NAME": "normal" },
    { "TYPE": "vec4", "NAME": "translation" },
    { "TYPE": "vec4", "NAME": "color" }
  ],
  "VERTEX_OUTPUTS": [
    { "TYPE": "vec3", "NAME": "v_normal" },
    { "TYPE": "vec4", "NAME": "v_color" }
  ],
  "FRAGMENT_INPUTS": [
    { "TYPE": "vec3", "NAME": "v_normal" },
    { "TYPE": "vec4", "NAME": "v_color" }
  ],
  "FRAGMENT_OUTPUTS": [
    { "TYPE": "vec4", "NAME": "isf_FragColor" }
  ],
  "INPUTS": []
}*/

void main() {
    vec3 n = normalize(v_normal);
    vec3 lightDir = normalize(vec3(0.3, 0.7, 0.5));
    float diffuse = max(dot(n, lightDir), 0.0);
    isf_FragColor = vec4(v_color.rgb * (0.25 + 0.75 * diffuse), v_color.a);
}
```

### Vertex shader (InstancedGrid.vs)

```glsl
// Simple perspective projection matrix
mat4 perspective(float fovy, float aspect, float near, float far) {
    float f = 1.0 / tan(fovy * 0.5);
    float nf = 1.0 / (near - far);
    return mat4(
        f / aspect, 0.0, 0.0,                    0.0,
        0.0,        f,   0.0,                    0.0,
        0.0,        0.0, (far + near) * nf,     -1.0,
        0.0,        0.0, 2.0 * far * near * nf,  0.0
    );
}

// Look-at view matrix
mat4 lookAt(vec3 eye, vec3 center, vec3 up) {
    vec3 f = normalize(center - eye);
    vec3 s = normalize(cross(f, up));
    vec3 u = cross(s, f);
    return mat4(
         s.x,          u.x,         -f.x,         0.0,
         s.y,          u.y,         -f.y,         0.0,
         s.z,          u.z,         -f.z,         0.0,
        -dot(s, eye), -dot(u, eye),  dot(f, eye), 1.0
    );
}

void main() {
    vec3 worldPos = position.xyz + translation.xyz;

    float aspect = RENDERSIZE.x / RENDERSIZE.y;
    mat4 proj = perspective(1.2, aspect, 0.1, 100.0);
    mat4 view = lookAt(vec3(2.0, 2.0, 2.0), vec3(0.0), vec3(0.0, 1.0, 0.0));

    gl_Position = clipSpaceCorrMatrix * proj * view * vec4(worldPos, 1.0);
    v_normal = normal.xyz;
    v_color = color;

#if defined(QSHADER_SPIRV) || defined(QSHADER_HLSL) || defined(QSHADER_MSL)
    gl_Position.y = -gl_Position.y;
#endif
}
```

## Simple textured mesh

Renders a mesh with a texture input.

### Fragment shader (TexturedMesh.fs)

```glsl
/*{
  "DESCRIPTION": "Renders a textured mesh",
  "ISFVSN": "2",
  "MODE": "RAW_RASTER_PIPELINE",
  "VERTEX_INPUTS": [
    { "TYPE": "vec4", "NAME": "position" },
    { "TYPE": "vec2", "NAME": "texcoord" }
  ],
  "VERTEX_OUTPUTS": [
    { "TYPE": "vec2", "NAME": "v_uv" }
  ],
  "FRAGMENT_INPUTS": [
    { "TYPE": "vec2", "NAME": "v_uv" }
  ],
  "FRAGMENT_OUTPUTS": [
    { "TYPE": "vec4", "NAME": "isf_FragColor" }
  ],
  "INPUTS": [
    { "NAME": "tex", "TYPE": "image" }
  ]
}*/

void main() {
    isf_FragColor = IMG_NORM_PIXEL(tex, v_uv);
}
```

### Vertex shader (TexturedMesh.vs)

```glsl
void main() {
    gl_Position = clipSpaceCorrMatrix * MODEL_MATRIX * position;
    v_uv = texcoord;

#if defined(QSHADER_SPIRV) || defined(QSHADER_HLSL) || defined(QSHADER_MSL)
    gl_Position.y = -gl_Position.y;
#endif
}
```

## Point cloud renderer

Renders point geometry with per-vertex colors. Set the topology to **Points** in the inspector.

### Fragment shader (PointCloud.fs)

```glsl
/*{
  "DESCRIPTION": "Renders colored point cloud",
  "ISFVSN": "2",
  "MODE": "RAW_RASTER_PIPELINE",
  "VERTEX_INPUTS": [
    { "TYPE": "vec4", "NAME": "position" },
    { "TYPE": "vec4", "NAME": "color" }
  ],
  "VERTEX_OUTPUTS": [
    { "TYPE": "vec4", "NAME": "v_color" }
  ],
  "FRAGMENT_INPUTS": [
    { "TYPE": "vec4", "NAME": "v_color" }
  ],
  "FRAGMENT_OUTPUTS": [
    { "TYPE": "vec4", "NAME": "isf_FragColor" }
  ],
  "INPUTS": [
    { "NAME": "pointSize", "TYPE": "float", "DEFAULT": 3.0, "MIN": 1.0, "MAX": 20.0 }
  ]
}*/

void main() {
    // Circular point shape
    vec2 pt = gl_PointCoord * 2.0 - 1.0;
    if (dot(pt, pt) > 1.0) discard;
    isf_FragColor = v_color;
}
```

### Vertex shader (PointCloud.vs)

```glsl
void main() {
    gl_Position = clipSpaceCorrMatrix * MODEL_MATRIX * position;
    gl_PointSize = pointSize;
    v_color = color;

#if defined(QSHADER_SPIRV) || defined(QSHADER_HLSL) || defined(QSHADER_MSL)
    gl_Position.y = -gl_Position.y;
#endif
}
```

## Related Processes

- [[ISF Shader]]: Fragment shaders with automatic fullscreen quad rendering.
- [[Compute Shader]]: Compute shaders for generating geometry, processing images, or GPU computation.
- [[Model Display]]: Built-in 3D model renderer with standard lighting.
- [[Vertex Shader Art|VSA Shader]]: Procedural vertex-based rendering.
