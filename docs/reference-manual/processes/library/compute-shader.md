---
layout: default

title: Compute Shaders
description: "Using compute shaders in the ossia score graphics pipeline"

parent: Processes
grand_parent: Reference

permalink: /processes/compute-shaders.html
---

# CSF Compute Shaders

![Shader]({{ site.img }}/reference/processes/compute-shader.gif "Shader Example")

The compute shader process allows you to add and [[Live coding|live-code]] your own compute shader to process images, generate geometry, or perform general-purpose GPU computations.

Compute shaders are written with CSF (Compute Shader Format), a variation of the [Interactive Shader Format (ISF)](https://isf.video), using GLSL.

They can be drag'n'dropped from the library, or from the explorer ; controls and inputs will be created automatically.

# JSON header

Every CSF shader starts with a JSON block enclosed in `/*{ ... }*/`. The header **must** contain:

```json
"MODE": "COMPUTE_SHADER"
```

## Required fields

- `"MODE"`: Must be `"COMPUTE_SHADER"`.
- `"PASSES"`: Array of dispatch configurations (see [Passes and execution models](#passes-and-execution-models)).

## Optional fields

- `"DESCRIPTION"`: Human-readable description.
- `"CREDIT"`: Author credit.
- `"ISFVSN"`: Version string (use `"2.0"`).
- `"CATEGORIES"`: Array of category strings.
- `"RESOURCES"`: Array of all resource and input declarations (see below).
- `"TYPES"`: Array of custom struct type definitions (for structured storage buffers).

# Resource types

Everything is declared in the `"RESOURCES"` array: GPU resources (images, textures, storage buffers, geometry) as well as scalar inputs (float, bool, long, point2D, point3D, color, event). Each entry has a `"NAME"` and a `"TYPE"`.

## IMAGE (read/write images)

A GPU image accessible via `imageLoad()` and `imageStore()`.

```json
{
  "NAME": "outputImage",
  "TYPE": "IMAGE",
  "ACCESS": "write_only",
  "FORMAT": "RGBA8",
  "WIDTH": "1024",
  "HEIGHT": "768"
}
```

| Field | Description |
|---|---|
| `"ACCESS"` | `"read_only"`, `"write_only"`, or `"read_write"` |
| `"FORMAT"` | Image format (see [supported formats](#image-formats)) |
| `"WIDTH"` | Width expression |
| `"HEIGHT"` | Height expression |
| `"DEPTH"` | Depth expression (makes the image 3D) |

### Size expressions

Size fields (`"WIDTH"`, `"HEIGHT"`, `"DEPTH"`) accept:

- Integer literals: `"1024"`
- `"$USER"`: Creates a user-controllable integer slider.
- References to other images: `"$WIDTH_otherImage"`, `"$HEIGHT_otherImage"`
- References to scalar inputs: `"$mySlider"` (where `mySlider` is a `float` or `long` input)
- References to geometry counts: `"$VERTEX_COUNT_geoName"`, `"$INSTANCE_COUNT_geoName"` (or `"$VERTEX_COUNT"`, `"$INSTANCE_COUNT"` for the first geometry)
- Math expressions combining any of the above: `"$WIDTH_inputImage / 2"`, `"$gridSize * $gridSize"`

The expression evaluator supports standard arithmetic (`+`, `-`, `*`, `/`, `%`), comparison operators, and common math functions (`min`, `max`, `sqrt`, `ceil`, `floor`, `pow`, `sin`, `cos`, etc.).

For example, if you have a `float` resource named `resolution`:

```json
"RESOURCES": [
  { "NAME": "resolution", "TYPE": "float", "DEFAULT": 512, "MIN": 64, "MAX": 2048 },
  { "NAME": "output", "TYPE": "IMAGE", "ACCESS": "write_only", "FORMAT": "RGBA8",
    "WIDTH": "$resolution", "HEIGHT": "$resolution" }
]
```

### GLSL access

```glsl
// write_only
writeonly uniform image2D outputImage;
imageStore(outputImage, ivec2(x, y), vec4(...));

// read_only
readonly uniform image2D inputImage;
vec4 color = imageLoad(inputImage, ivec2(x, y));

// read_write
restrict uniform image2D buffer;
vec4 old = imageLoad(buffer, ivec2(x, y));
imageStore(buffer, ivec2(x, y), new_val);
```

### 3D images

Add a `"DEPTH"` field to create a 3D image:

```json
{
  "NAME": "volume",
  "TYPE": "IMAGE",
  "ACCESS": "write_only",
  "FORMAT": "R32F",
  "WIDTH": "128",
  "HEIGHT": "128",
  "DEPTH": "128"
}
```

Access with `ivec3` coordinates: `imageStore(volume, ivec3(x, y, z), vec4(...))`.

## TEXTURE (sampled textures)

A read-only sampled texture, accessed with `textureLod()` or `texture()` instead of `imageLoad()`.

```json
{ "NAME": "lookup", "TYPE": "TEXTURE" }
```

For 3D sampled textures:

```json
{ "NAME": "volumeTex", "TYPE": "TEXTURE", "DIMENSIONS": 3 }
```

## STORAGE (structured storage buffers)

A structured SSBO with named fields, following std430 layout rules.

```json
{
  "NAME": "params",
  "TYPE": "STORAGE",
  "ACCESS": "read_write",
  "LAYOUT": [
    { "NAME": "count", "TYPE": "int" },
    { "NAME": "threshold", "TYPE": "float" },
    { "NAME": "transform", "TYPE": "mat4" }
  ]
}
```

### Flexible arrays

The last field in a storage buffer layout can be a flexible (unsized) array, declared with `[]` suffix. Use `"SIZE"` to control the array length:

```json
{
  "NAME": "particles",
  "TYPE": "STORAGE",
  "ACCESS": "read_write",
  "SIZE": "$USER",
  "LAYOUT": [
    { "NAME": "count", "TYPE": "int" },
    { "NAME": "positions", "TYPE": "vec4[]" }
  ]
}
```

`"SIZE"` is only needed when the layout contains a flexible array. It supports the same expressions as image size fields (`$USER`, `$inputName`, math expressions).

### GLSL access

Fields are accessed as `bufferName.fieldName`:

```glsl
// Fixed fields
int n = params.count;
float t = params.threshold;
mat4 m = params.transform;

// Flexible array
particles.positions[idx] = vec4(x, y, z, 1.0);
```

## Scalar inputs

Scalar inputs create UI controls (sliders, toggles, color pickers) and become uniforms in the shader. They use the same types as ISF:

| Type | GLSL type | Fields |
|---|---|---|
| `float` | `float` | `DEFAULT`, `MIN`, `MAX` |
| `long` | `int` | `VALUES`, `LABELS`, `DEFAULT` (index) |
| `bool` | `bool` | `DEFAULT` |
| `event` | `bool` | (true for one frame when triggered) |
| `point2D` | `vec2` | `DEFAULT`, `MIN`, `MAX` (arrays of 2) |
| `point3D` | `vec3` | `DEFAULT`, `MIN`, `MAX` (arrays of 3) |
| `color` | `vec4` | `DEFAULT`, `MIN`, `MAX` (arrays of 4, RGBA) |

Example:

```json
"RESOURCES": [
  { "NAME": "strength", "TYPE": "float", "DEFAULT": 5.0, "MIN": 0.0, "MAX": 50.0 },
  { "NAME": "mode", "TYPE": "long", "VALUES": [0, 1, 2], "LABELS": ["Add", "Multiply", "Replace"], "DEFAULT": 0 },
  { "NAME": "tint", "TYPE": "color", "DEFAULT": [1, 0.5, 0, 1] },
  { "NAME": "center", "TYPE": "point3D", "DEFAULT": [0, 0, 0], "MIN": [-10, -10, -10], "MAX": [10, 10, 10] }
]
```

## GEOMETRY (geometry output port)

Declares a geometry output with per-attribute SSBOs using Structure-of-Arrays (SoA) layout. The geometry can be connected to downstream nodes for rendering (e.g., [[Render Pipeline]] or [[Model Display]]).

```json
{
  "NAME": "geo",
  "TYPE": "geometry",
  "VERTEX_COUNT": 1000,
  "INSTANCE_COUNT": "$USER",
  "ATTRIBUTES": [
    { "NAME": "position",    "SEMANTIC": "position",    "TYPE": "vec4", "ACCESS": "write_only", "RATE": "vertex" },
    { "NAME": "normal",      "SEMANTIC": "normal",      "TYPE": "vec4", "ACCESS": "write_only", "RATE": "vertex" },
    { "NAME": "translation", "SEMANTIC": "translation", "TYPE": "vec4", "ACCESS": "write_only", "RATE": "instance" },
    { "NAME": "color",       "SEMANTIC": "color",       "TYPE": "vec4", "ACCESS": "write_only", "RATE": "instance" }
  ]
}
```

### Geometry fields

| Field | Description |
|---|---|
| `"VERTEX_COUNT"` | *(optional)* Number of vertices. Integer, `"$USER"` for user-controlled, or expression using `$inputName`, `$WIDTH_<imageName>`, `$HEIGHT_<imageName>`, `$VERTEX_COUNT_<otherGeoName>`, `$INSTANCE_COUNT_<otherGeoName>`. |
| `"INSTANCE_COUNT"` | *(optional)* Number of instances. Same expression support as `VERTEX_COUNT`. |
| `"ATTRIBUTES"` | Array of per-attribute SSBO declarations |

### Generators vs filters

When `VERTEX_COUNT` is specified, the node **generates** geometry: it pre-allocates its own buffers and owns the vertex/instance counts. This is for nodes that create geometry from scratch (e.g., procedural meshes, particle emitters).

When `VERTEX_COUNT` is omitted, the node is a **filter**: it operates on upstream geometry passed through its input port. Buffer sizes and counts are inherited from the upstream mesh. The node adopts upstream GPU buffers directly (zero-copy when the data layout matches). This is the pattern for forces, transforms, and other operations that modify existing geometry without changing its size.

### Attribute fields

| Field | Description |
|---|---|
| `"NAME"` | GLSL variable name (e.g., `"position"`) |
| `"SEMANTIC"` | Semantic identifier for downstream matching (e.g., `"position"`, `"normal"`, `"color"`, `"texcoord"`, `"tangent"`, or any custom string) |
| `"TYPE"` | GLSL type: `"float"`, `"vec2"`, `"vec3"`, `"vec4"`, `"mat4"`, `"int"`, `"uint"`, etc. |
| `"ACCESS"` | `"read_only"`, `"write_only"`, or `"read_write"` |
| `"RATE"` | `"vertex"` (default) or `"instance"` — controls whether the attribute is per-vertex or per-instance |
| `"REQUIRED"` | `true` (default) or `false` — optional attributes get zero-filled fallback buffers if missing from upstream |

### Per-vertex vs per-instance attributes

- **`"RATE": "vertex"`**: One element per vertex. Sized by `VERTEX_COUNT`. Each vertex in the mesh reads a distinct value.
- **`"RATE": "instance"`**: One element per instance. Sized by `INSTANCE_COUNT`. All vertices within an instance share the same value; each instance reads a distinct value.

This is essential for instanced rendering: per-vertex data defines the shape (e.g., cube geometry), while per-instance data defines placement (e.g., translations, colors per instance).

### GLSL access for geometry attributes

The generated SSBO name is `geo_attributeName`:

```glsl
// write_only
ISF_WRITE(geo, position)[idx] = vec4(x, y, z, 1.0);

// read_only
vec4 p = ISF_READ(geo, position)[idx];

// read_write (two SSBOs for double-buffering):
vec4 old = ISF_READ(geo, position)[idx];   // read from previous frame
ISF_WRITE(geo, position)[idx] = new_val;   // write for this frame

// Get buffer length:
uint count = uint(ISF_READ(geo, position).length());
```

`ISF_READ(geo, attr)` expands to `geo_attr_in` and `ISF_WRITE(geo, attr)` expands to `geo_attr_out`. For `write_only` attributes, `ISF_WRITE` is aliased to `geo_attr`; for `read_only`, `ISF_READ` is aliased to `geo_attr`.

### Presence check macros

For each declared attribute, a `HAS_` macro is defined:

```glsl
#ifdef HAS_POSITION
    // position attribute is available
#endif
```

### Auxiliary buffers

Structured SSBOs that travel with the geometry. Unlike attribute SSBOs (which are one value per vertex/instance), auxiliary buffers have arbitrary struct layouts.

A simple auxiliary buffer with only fixed-size fields does not need a `"SIZE"` field:

```json
"AUXILIARY": [
  {
    "NAME": "config",
    "ACCESS": "read_write",
    "LAYOUT": [
      { "NAME": "gravity", "TYPE": "vec4" },
      { "NAME": "damping", "TYPE": "float" }
    ]
  }
]
```

An auxiliary buffer with a flexible array needs `"SIZE"` to control the array length:

```json
"AUXILIARY": [
  {
    "NAME": "metadata",
    "ACCESS": "read_write",
    "SIZE": "$USER",
    "LAYOUT": [
      { "NAME": "total_weight", "TYPE": "float" },
      { "NAME": "node_id", "TYPE": "uint[]" },
      { "NAME": "weight", "TYPE": "float[]" }
    ]
  }
]
```

In this example, `total_weight` is a single fixed field, while `node_id` and `weight` are flexible arrays whose length is controlled by the `$USER` slider.

Auxiliary buffers are accessed with `ISF_READ`/`ISF_WRITE` just like attributes, using the struct field syntax:

```glsl
// Access fields of a "config" auxiliary buffer on geometry "geo":
vec4 g = ISF_READ(geo, config).gravity;
ISF_WRITE(geo, config).damping = 0.99;

// Flexible array access:
uint id = ISF_READ(geo, metadata).node_id[idx];
ISF_WRITE(geo, metadata).weight[idx] = 1.0;
```

Direct access by buffer name also works: `config.gravity`, `metadata.node_id[idx]`.

## Double-buffering and feedback

When a geometry attribute has `"ACCESS": "read_write"` and the node receives its own output back through a feedback connection, the system automatically allocates **two buffers** (ping-pong):

- `geo_attr_in[]` (read-only): previous frame's data
- `geo_attr_out[]` (write-only): current frame's output

After each frame, the buffers are swapped. This prevents read-write hazards and enables iterative simulations (particles, physics, etc.).

# Custom types

Define custom struct types in the `"TYPES"` array for use in storage buffer layouts:

```json
"TYPES": [
  {
    "NAME": "Particle",
    "LAYOUT": [
      { "NAME": "position", "TYPE": "vec4" },
      { "NAME": "velocity", "TYPE": "vec4" },
      { "NAME": "life", "TYPE": "float" }
    ]
  }
]
```

# Passes and execution models

CSF shaders require at least one pass in the `"PASSES"` array. Each pass specifies how the compute shader is dispatched.

## Pass fields

```json
{
  "LOCAL_SIZE": [16, 16, 1],
  "EXECUTION_MODEL": {
    "TYPE": "2D_IMAGE",
    "TARGET": "outputImage",
    "STRIDE_X": 1,
    "STRIDE_Y": 1,
    "STRIDE_Z": 1
  }
}
```

| Field | Description |
|---|---|
| `"LOCAL_SIZE"` | Workgroup dimensions `[x, y, z]` (default: `[16, 16, 1]`) |
| `"EXECUTION_MODEL"` | Dispatch strategy object (see below) |

## Execution model fields

The `"EXECUTION_MODEL"` object contains:

| Field | Description |
|---|---|
| `"TYPE"` | Dispatch strategy: `2D_IMAGE`, `3D_IMAGE`, `PER_VERTEX`, `PER_INSTANCE`, `1D_BUFFER`, `MANUAL`, `USER` |
| `"TARGET"` | Target resource name (for `2D_IMAGE`, `3D_IMAGE`, `1D_BUFFER`) |
| `"WORKGROUPS"` | Manual workgroup count `[x, y, z]` (for `MANUAL` mode only) |
| `"STRIDE_X"` | Per-axis X stride (integer or expression string) |
| `"STRIDE_Y"` | Per-axis Y stride (integer or expression string) |
| `"STRIDE_Z"` | Per-axis Z stride (integer or expression string) |

Stride values reduce the number of dispatched workgroups: each thread is responsible for processing `stride` elements along that axis. They default to 1 (no stride).

Stride expressions support the same variables as size expressions: `$inputName`, `$WIDTH_<imageName>`, `$HEIGHT_<imageName>`, `$VERTEX_COUNT`, `$INSTANCE_COUNT`, `$VERTEX_COUNT_<geoName>`, `$INSTANCE_COUNT_<geoName>`.

## Execution model types

### 2D_IMAGE

Dispatches enough workgroups to cover the target image's width and height.

```json
{ "TYPE": "2D_IMAGE", "TARGET": "outputImage" }
```

Dispatch count: `ceil(width / (localX * strideX))` x `ceil(height / (localY * strideY))` x 1

### 3D_IMAGE

Like 2D_IMAGE but also dispatches over the depth dimension of a 3D image.

```json
{ "TYPE": "3D_IMAGE", "TARGET": "volumeImage" }
```

Dispatch count: `ceil(width / (localX * strideX))` x `ceil(height / (localY * strideY))` x `ceil(depth / (localZ * strideZ))`

### PER_VERTEX

Dispatches one thread per vertex in a geometry resource.

```json
{ "TYPE": "PER_VERTEX" }
```

Dispatch count: `ceil(vertexCount / (threadsPerWorkgroup * strideX))` x 1 x 1

Use `gl_GlobalInvocationID.x` as the vertex index.

### PER_INSTANCE

Dispatches one thread per instance in a geometry resource.

```json
{ "TYPE": "PER_INSTANCE" }
```

Dispatch count: `ceil(instanceCount / (threadsPerWorkgroup * strideX))` x 1 x 1

Use `gl_GlobalInvocationID.x` as the instance index.

### 1D_BUFFER

Dispatches over the elements of a storage buffer.

```json
{ "TYPE": "1D_BUFFER", "TARGET": "myBuffer" }
```

### MANUAL

Specifies the exact number of workgroups as constants in the JSON header.

```json
{ "TYPE": "MANUAL", "WORKGROUPS": [64, 1, 1] }
```

### USER

Creates three integer sliders (X, Y, Z) in the user interface, allowing the end-user to control the dispatch dimensions at runtime.

```json
{ "TYPE": "USER" }
```

Each axis defaults to 1. The user can adjust the sliders to control how many workgroups are dispatched along each axis. This is useful for experimentation or when the dispatch size depends on external factors not known at shader authoring time.

## Multi-pass compute

Multiple passes execute sequentially within a single frame. Use `PASSINDEX` to branch logic:

```glsl
if (PASSINDEX == 0) {
    // First pass: generate data
} else if (PASSINDEX == 1) {
    // Second pass: process data
}
```

Each pass can have its own `LOCAL_SIZE` and `EXECUTION_MODEL`, allowing different dispatch strategies per pass:

```json
"PASSES": [
  { "LOCAL_SIZE": [36, 1, 1], "EXECUTION_MODEL": { "TYPE": "PER_VERTEX" } },
  { "LOCAL_SIZE": [64, 1, 1], "EXECUTION_MODEL": { "TYPE": "PER_INSTANCE" } }
]
```

# Image formats

The `"FORMAT"` field for IMAGE resources supports:

| Category | Formats |
|---|---|
| Float color | `RGBA32F`, `RGBA16F`, `RGBA8`, `RG32F`, `RG16F`, `RG8`, `R32F`, `R16F`, `R8`, `RGB10_A2` |
| Signed integer | `RGBA32I`, `RGBA16I`, `RGBA8I`, `RG32I`, `RG16I`, `RG8I`, `R32I`, `R16I`, `R8I` |
| Unsigned integer | `RGBA32UI`, `RGBA16UI`, `RGBA8UI`, `RG32UI`, `RG16UI`, `RG8UI`, `R32UI`, `R16UI`, `R8UI` |

Default if omitted: `RGBA8`. Format names are case-insensitive.

# Expression variables reference

Many fields in the JSON header accept math expressions instead of plain integers. All variables are prefixed with `$`. The following table lists all available variables and where they can be used.

| Variable | Description | Image size | Geometry count | Dispatch stride |
|---|---|---|---|---|
| `$inputName` | Value of a scalar input (`float` or `long`) | Yes | Yes | Yes |
| `$USER` | Dedicated user-controllable integer slider | Yes | Yes | No |
| `$WIDTH_<name>` | Width of an input texture or read-only image | Yes | Yes | Yes |
| `$HEIGHT_<name>` | Height of an input texture or read-only image | Yes | Yes | Yes |
| `$VERTEX_COUNT` | Vertex count of the first geometry | No | No* | Yes |
| `$INSTANCE_COUNT` | Instance count of the first geometry | No | No* | Yes |
| `$VERTEX_COUNT_<name>` | Vertex count of a named geometry | No | No* | Yes |
| `$INSTANCE_COUNT_<name>` | Instance count of a named geometry | No | No* | Yes |

\* Geometry count expressions (`VERTEX_COUNT`, `INSTANCE_COUNT`) cannot reference `$VERTEX_COUNT` or `$INSTANCE_COUNT` of the *same* geometry (that would be circular). However, a geometry can reference the counts of a *previously declared* geometry by name.

**Supported operators**: `+`, `-`, `*`, `/`, `%`, `==`, `!=`, `<`, `<=`, `>`, `>=`, `&&`, `||`

**Supported functions**: `abs`, `sqrt`, `sin`, `cos`, `tan`, `exp`, `log`, `log10`, `ceil`, `floor`, `round`, `min`, `max`, `pow`, `clamp`, `lerp`, `step`, `smoothstep`

# Built-in uniforms

CSF shaders have access to the following built-in uniforms:

| Uniform | Type | Description |
|---|---|---|
| `TIME` | `float` | Playback time in seconds |
| `TIMEDELTA` | `float` | Time since last frame in seconds |
| `PROGRESS` | `float` | Timeline progress from 0 to 1 |
| `FRAMEINDEX` | `int` | Frame counter |
| `PASSINDEX` | `int` | Current pass index |
| `RENDERSIZE` | `vec2` | Output size in pixels |
| `DATE` | `vec4` | Current date: `(year, month, day, seconds)` |
| `SAMPLERATE` | `float` | Audio sample rate in Hz |

# Examples

## Image processing: brightness/contrast

```glsl
/*{
  "DESCRIPTION": "Adjusts image brightness using compute shader",
  "CREDIT": "ossia score",
  "ISFVSN": "2.0",
  "MODE": "COMPUTE_SHADER",
  "CATEGORIES": ["COLOR"],
  "RESOURCES": [
    { "NAME": "inputImage", "TYPE": "IMAGE", "ACCESS": "read_only", "FORMAT": "RGBA8" },
    {
      "NAME": "outputImage", "TYPE": "IMAGE", "ACCESS": "write_only", "FORMAT": "RGBA8",
      "WIDTH": "$WIDTH_inputImage", "HEIGHT": "$HEIGHT_inputImage"
    },
    { "NAME": "brightness", "TYPE": "float", "DEFAULT": 1.0, "MIN": 0.0, "MAX": 2.0 },
    { "NAME": "contrast", "TYPE": "float", "DEFAULT": 1.0, "MIN": 0.0, "MAX": 2.0 }
  ],
  "PASSES": [{
    "LOCAL_SIZE": [16, 16, 1],
    "EXECUTION_MODEL": { "TYPE": "2D_IMAGE", "TARGET": "outputImage" }
  }]
}*/

void main() {
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    ivec2 size = imageSize(outputImage);
    if (any(greaterThanEqual(coord, size))) return;

    vec4 color = imageLoad(inputImage, coord);
    color.rgb = (color.rgb - 0.5) * contrast + 0.5;
    color.rgb *= brightness;
    color.rgb = clamp(color.rgb, 0.0, 1.0);
    imageStore(outputImage, coord, color);
}
```

## Instanced geometry generation

This example generates cube geometry with per-vertex positions/normals and per-instance translations/colors, arranged in a grid. Connect the output to a [[Render Pipeline]] for rendering.

```glsl
/*{
  "DESCRIPTION": "Generates a grid of cubes using instanced rendering",
  "ISFVSN": "2.0",
  "MODE": "COMPUTE_SHADER",
  "RESOURCES": [
    {
      "NAME": "geo",
      "TYPE": "geometry",
      "VERTEX_COUNT": 36,
      "INSTANCE_COUNT": "$USER",
      "ATTRIBUTES": [
        { "NAME": "position",    "SEMANTIC": "position",    "TYPE": "vec4", "ACCESS": "write_only", "RATE": "vertex" },
        { "NAME": "normal",      "SEMANTIC": "normal",      "TYPE": "vec4", "ACCESS": "write_only", "RATE": "vertex" },
        { "NAME": "translation", "SEMANTIC": "translation", "TYPE": "vec4", "ACCESS": "write_only", "RATE": "instance" },
        { "NAME": "color",       "SEMANTIC": "color",       "TYPE": "vec4", "ACCESS": "write_only", "RATE": "instance" }
      ]
    }
  ],
  "PASSES": [
    { "LOCAL_SIZE": [36, 1, 1], "EXECUTION_MODEL": { "TYPE": "PER_VERTEX" } },
    { "LOCAL_SIZE": [64, 1, 1], "EXECUTION_MODEL": { "TYPE": "PER_INSTANCE" } }
  ]
}*/

const vec4 cube_pos[36] = vec4[36](
    // Front face (z = +0.5)
    vec4(-0.5,-0.5, 0.5,1), vec4( 0.5,-0.5, 0.5,1), vec4( 0.5, 0.5, 0.5,1),
    vec4(-0.5,-0.5, 0.5,1), vec4( 0.5, 0.5, 0.5,1), vec4(-0.5, 0.5, 0.5,1),
    // Back face
    vec4( 0.5,-0.5,-0.5,1), vec4(-0.5,-0.5,-0.5,1), vec4(-0.5, 0.5,-0.5,1),
    vec4( 0.5,-0.5,-0.5,1), vec4(-0.5, 0.5,-0.5,1), vec4( 0.5, 0.5,-0.5,1),
    // Right, Left, Top, Bottom faces
    vec4( 0.5,-0.5, 0.5,1), vec4( 0.5,-0.5,-0.5,1), vec4( 0.5, 0.5,-0.5,1),
    vec4( 0.5,-0.5, 0.5,1), vec4( 0.5, 0.5,-0.5,1), vec4( 0.5, 0.5, 0.5,1),
    vec4(-0.5,-0.5,-0.5,1), vec4(-0.5,-0.5, 0.5,1), vec4(-0.5, 0.5, 0.5,1),
    vec4(-0.5,-0.5,-0.5,1), vec4(-0.5, 0.5, 0.5,1), vec4(-0.5, 0.5,-0.5,1),
    vec4(-0.5, 0.5, 0.5,1), vec4( 0.5, 0.5, 0.5,1), vec4( 0.5, 0.5,-0.5,1),
    vec4(-0.5, 0.5, 0.5,1), vec4( 0.5, 0.5,-0.5,1), vec4(-0.5, 0.5,-0.5,1),
    vec4(-0.5,-0.5,-0.5,1), vec4( 0.5,-0.5,-0.5,1), vec4( 0.5,-0.5, 0.5,1),
    vec4(-0.5,-0.5,-0.5,1), vec4( 0.5,-0.5, 0.5,1), vec4(-0.5,-0.5, 0.5,1)
);

const vec4 cube_nrm[36] = vec4[36](
    vec4(0,0,1,0), vec4(0,0,1,0), vec4(0,0,1,0),
    vec4(0,0,1,0), vec4(0,0,1,0), vec4(0,0,1,0),
    vec4(0,0,-1,0), vec4(0,0,-1,0), vec4(0,0,-1,0),
    vec4(0,0,-1,0), vec4(0,0,-1,0), vec4(0,0,-1,0),
    vec4(1,0,0,0), vec4(1,0,0,0), vec4(1,0,0,0),
    vec4(1,0,0,0), vec4(1,0,0,0), vec4(1,0,0,0),
    vec4(-1,0,0,0), vec4(-1,0,0,0), vec4(-1,0,0,0),
    vec4(-1,0,0,0), vec4(-1,0,0,0), vec4(-1,0,0,0),
    vec4(0,1,0,0), vec4(0,1,0,0), vec4(0,1,0,0),
    vec4(0,1,0,0), vec4(0,1,0,0), vec4(0,1,0,0),
    vec4(0,-1,0,0), vec4(0,-1,0,0), vec4(0,-1,0,0),
    vec4(0,-1,0,0), vec4(0,-1,0,0), vec4(0,-1,0,0)
);

void main() {
    uint idx = gl_GlobalInvocationID.x;

    if (PASSINDEX == 0) {
        // Per-vertex: write cube geometry
        if (idx >= 36u) return;
        ISF_WRITE(geo, position)[idx] = cube_pos[idx] * 0.1;
        ISF_WRITE(geo, normal)[idx]   = cube_nrm[idx];
    }
    else if (PASSINDEX == 1) {
        // Per-instance: arrange in a grid with colors
        uint count = uint(ISF_WRITE(geo, translation).length());
        if (idx >= count) return;

        uint side = uint(ceil(sqrt(float(count))));
        uint gx = idx % side;
        uint gy = idx / side;
        float spacing = 0.25;
        float offset = -float(side - 1u) * spacing * 0.5;

        ISF_WRITE(geo, translation)[idx] = vec4(offset + float(gx)*spacing, offset + float(gy)*spacing, 0, 0);
        ISF_WRITE(geo, color)[idx] = vec4(float(gx)/float(side), float(gy)/float(side), 0.5, 1.0);
    }
}
```

## Particle simulation with feedback

This example uses feedback (`read_write` attributes with `VERTEX_COUNT`) to simulate particles with gravity. On the first frame (`FRAMEINDEX == 0`), particles are initialized with random positions and velocities. On subsequent frames, they are updated in-place via ping-pong buffers.

Connect the geometry output to a [[Render Pipeline]] with topology set to **Points**.

```glsl
/*{
  "DESCRIPTION": "Simple particle fountain with gravity and floor bounce",
  "ISFVSN": "2.0",
  "MODE": "COMPUTE_SHADER",
  "RESOURCES": [
    {
      "NAME": "geo",
      "TYPE": "geometry",
      "VERTEX_COUNT": "$USER",
      "ATTRIBUTES": [
        { "NAME": "position", "SEMANTIC": "position", "TYPE": "vec4", "ACCESS": "read_write" },
        { "NAME": "velocity", "SEMANTIC": "custom",   "TYPE": "vec4", "ACCESS": "read_write" },
        { "NAME": "color",    "SEMANTIC": "color",     "TYPE": "vec4", "ACCESS": "write_only" }
      ],
      "AUXILIARY": [
        {
          "NAME": "state",
          "ACCESS": "read_write",
          "LAYOUT": [
            { "NAME": "initialized", "TYPE": "uint" }
          ]
        }
      ]
    }
  ],
  "PASSES": [
    { "LOCAL_SIZE": [64, 1, 1], "EXECUTION_MODEL": { "TYPE": "PER_VERTEX" } }
  ]
}*/

// Simple hash-based pseudo-random
float hash(uint n) {
    n = (n << 13u) ^ n;
    n = n * (n * n * 15731u + 789221u) + 1376312589u;
    return float(n & 0x7fffffffu) / float(0x7fffffff);
}

void main() {
    uint idx = gl_GlobalInvocationID.x;
    uint count = uint(ISF_READ(geo, position).length());
    if (idx >= count) return;

    // Initialize once (auxiliary buffers start zero-filled)
    if (ISF_READ(geo, state).initialized == 0u) {
        if (idx == 0u)
            ISF_WRITE(geo, state).initialized = 1u;

        float angle = hash(idx * 3u) * 6.2831;
        float radius = hash(idx * 3u + 1u) * 0.5;
        float height = hash(idx * 3u + 2u) * 2.0 - 1.0;

        ISF_WRITE(geo, position)[idx] = vec4(cos(angle) * radius, height, sin(angle) * radius, 1.0);
        ISF_WRITE(geo, velocity)[idx] = vec4(cos(angle) * 0.005, 0.01 + hash(idx) * 0.01, sin(angle) * 0.005, 0.0);
        ISF_WRITE(geo, color)[idx] = vec4(hash(idx * 7u), hash(idx * 11u), hash(idx * 13u), 1.0);
        return;
    }

    vec4 pos = ISF_READ(geo, position)[idx];
    vec4 vel = ISF_READ(geo, velocity)[idx];

    // Apply gravity
    vel.y -= 0.001;

    // Bounce off floor
    if (pos.y < -1.0) {
        pos.y = -1.0;
        vel.y = abs(vel.y) * 0.8;
    }

    pos += vel;

    ISF_WRITE(geo, position)[idx] = pos;
    ISF_WRITE(geo, velocity)[idx] = vel;

    // Color by height
    float h = clamp(pos.y * 0.5 + 0.5, 0.0, 1.0);
    ISF_WRITE(geo, color)[idx] = vec4(1.0 - h, 0.3, h, 1.0);
}
```

## 3D volume generation

```glsl
/*{
  "DESCRIPTION": "Generate a 3D sphere SDF volume",
  "ISFVSN": "2.0",
  "MODE": "COMPUTE_SHADER",
  "RESOURCES": [
    {
      "NAME": "volume", "TYPE": "IMAGE", "ACCESS": "write_only",
      "FORMAT": "R32F", "WIDTH": "64", "HEIGHT": "64", "DEPTH": "64"
    }
  ],
  "PASSES": [{
    "LOCAL_SIZE": [8, 8, 8],
    "EXECUTION_MODEL": { "TYPE": "3D_IMAGE", "TARGET": "volume" }
  }]
}*/

void main() {
    ivec3 pos = ivec3(gl_GlobalInvocationID.xyz);
    ivec3 size = imageSize(volume);
    if (any(greaterThanEqual(pos, size))) return;

    vec3 uv = vec3(pos) / vec3(size);
    float dist = length(uv - 0.5) - 0.3;
    imageStore(volume, pos, vec4(dist));
}
```

## Geometry with auxiliary structured buffer

```glsl
/*{
  "DESCRIPTION": "Particles with shared physics config and per-particle metadata",
  "ISFVSN": "2.0",
  "MODE": "COMPUTE_SHADER",
  "RESOURCES": [
    { "NAME": "gravity", "TYPE": "float", "DEFAULT": -9.8, "MIN": -20.0, "MAX": 0.0 },
    {
      "NAME": "geo",
      "TYPE": "geometry",
      "VERTEX_COUNT": "$USER",
      "ATTRIBUTES": [
        { "NAME": "position", "SEMANTIC": "position", "TYPE": "vec4", "ACCESS": "write_only" }
      ],
      "AUXILIARY": [
        {
          "NAME": "physics",
          "ACCESS": "read_write",
          "LAYOUT": [
            { "NAME": "total_energy", "TYPE": "float" },
            { "NAME": "velocities", "TYPE": "vec4[]" }
          ],
          "SIZE": "$USER"
        }
      ]
    }
  ],
  "PASSES": [
    { "LOCAL_SIZE": [64, 1, 1], "EXECUTION_MODEL": { "TYPE": "PER_VERTEX" } }
  ]
}*/

void main() {
    uint idx = gl_GlobalInvocationID.x;
    uint count = uint(ISF_WRITE(geo, position).length());
    if (idx >= count) return;

    // Read velocity from auxiliary flexible array
    vec4 vel = ISF_READ(geo, physics).velocities[idx];
    vel.y += gravity * TIMEDELTA;

    // Update position
    vec4 pos = vec4(vel.xyz * TIMEDELTA, 1.0);
    ISF_WRITE(geo, position)[idx] = pos;
    ISF_WRITE(geo, physics).velocities[idx] = vel;
}
```

## Geometry filter: vortex force

This example has no `VERTEX_COUNT` — it operates on upstream geometry as a filter. It reads particle positions and velocities from the input, applies a rotational vortex force, and writes the results back. Connect it between a particle emitter and a renderer.

```glsl
/*{
  "DESCRIPTION": "Rotational vortex force around an axis",
  "ISFVSN": "2.0",
  "MODE": "COMPUTE_SHADER",
  "CATEGORIES": ["PARTICLES"],
  "RESOURCES": [
    { "NAME": "center",   "TYPE": "point3D", "DEFAULT": [0.0, 0.0, 0.0],
      "MIN": [-20.0, -20.0, -20.0], "MAX": [20.0, 20.0, 20.0] },
    { "NAME": "axis",     "TYPE": "point3D", "DEFAULT": [0.0, 1.0, 0.0],
      "MIN": [-1.0, -1.0, -1.0], "MAX": [1.0, 1.0, 1.0] },
    { "NAME": "strength", "TYPE": "float", "DEFAULT": 5.0, "MIN": -50.0, "MAX": 50.0 },
    { "NAME": "pullIn",   "TYPE": "float", "DEFAULT": 0.0, "MIN": -20.0, "MAX": 20.0 },
    {
      "NAME": "geo",
      "TYPE": "geometry",
      "ATTRIBUTES": [
        { "NAME": "position", "SEMANTIC": "position", "TYPE": "vec4", "ACCESS": "read_write" },
        { "NAME": "velocity", "SEMANTIC": "velocity", "TYPE": "vec4", "ACCESS": "read_write" }
      ]
    }
  ],
  "PASSES": [
    { "LOCAL_SIZE": [64, 1, 1], "EXECUTION_MODEL": { "TYPE": "PER_VERTEX" } }
  ]
}*/

void main() {
    uint idx = gl_GlobalInvocationID.x;
    uint count = uint(ISF_READ(geo, position).length());
    if (idx >= count) return;

    vec3 pos = ISF_READ(geo, position)[idx].xyz;
    vec3 vel = ISF_READ(geo, velocity)[idx].xyz;
    vec3 ax  = normalize(axis);

    vec3 toParticle = pos - center;
    vec3 radial = toParticle - dot(toParticle, ax) * ax;
    float dist = length(radial);

    if (dist < 0.001) {
        ISF_WRITE(geo, position)[idx] = ISF_READ(geo, position)[idx];
        ISF_WRITE(geo, velocity)[idx] = ISF_READ(geo, velocity)[idx];
        return;
    }

    vec3 tangent = normalize(cross(ax, radial));
    vel += tangent * strength * TIMEDELTA;
    vel -= normalize(radial) * pullIn * TIMEDELTA;

    ISF_WRITE(geo, position)[idx] = ISF_READ(geo, position)[idx];
    ISF_WRITE(geo, velocity)[idx] = vec4(vel, 0.0);
}
```

## Boids flocking simulation (feedback)

This example demonstrates why double-buffering matters: each boid reads **every other boid's** previous position and velocity to compute flocking rules (separation, alignment, cohesion). Without ping-pong buffers, early threads would overwrite positions that later threads still need to read, creating asymmetric behavior and visual artifacts.

The `read_write` attributes on `position` and `velocity` combined with `VERTEX_COUNT` trigger feedback detection. The system allocates two SSBOs per attribute: `ISF_READ(geo, position)` is a frozen snapshot of the previous frame, `ISF_WRITE(geo, position)` is the current frame's output. They are swapped after each frame.

Connect the geometry output back to the geometry input to close the feedback loop, and connect it to a [[Render Pipeline]] with topology set to **Points**.

```glsl
/*{
  "DESCRIPTION": "Boids flocking simulation — separation, alignment, cohesion",
  "ISFVSN": "2.0",
  "MODE": "COMPUTE_SHADER",
  "CATEGORIES": ["PARTICLES"],
  "RESOURCES": [
    { "NAME": "separation", "TYPE": "float", "DEFAULT": 0.05,  "MIN": 0.0, "MAX": 0.2 },
    { "NAME": "alignment",  "TYPE": "float", "DEFAULT": 0.05,  "MIN": 0.0, "MAX": 0.2 },
    { "NAME": "cohesion",   "TYPE": "float", "DEFAULT": 0.005, "MIN": 0.0, "MAX": 0.05 },
    { "NAME": "maxSpeed",   "TYPE": "float", "DEFAULT": 0.01,  "MIN": 0.001, "MAX": 0.05 },
    { "NAME": "radius",     "TYPE": "float", "DEFAULT": 0.3,   "MIN": 0.05, "MAX": 1.0 },
    {
      "NAME": "geo",
      "TYPE": "geometry",
      "VERTEX_COUNT": "$USER",
      "ATTRIBUTES": [
        { "NAME": "position", "SEMANTIC": "position", "TYPE": "vec4", "ACCESS": "read_write" },
        { "NAME": "velocity", "SEMANTIC": "custom",   "TYPE": "vec4", "ACCESS": "read_write" },
        { "NAME": "color",    "SEMANTIC": "color",     "TYPE": "vec4", "ACCESS": "write_only" }
      ],
      "AUXILIARY": [
        {
          "NAME": "state",
          "ACCESS": "read_write",
          "LAYOUT": [ { "NAME": "initialized", "TYPE": "uint" } ]
        }
      ]
    }
  ],
  "PASSES": [
    { "LOCAL_SIZE": [64, 1, 1], "EXECUTION_MODEL": { "TYPE": "PER_VERTEX" } }
  ]
}*/

// Hash-based pseudo-random
float hash(uint n) {
    n = (n << 13u) ^ n;
    n = n * (n * n * 15731u + 789221u) + 1376312589u;
    return float(n & 0x7fffffffu) / float(0x7fffffff);
}

vec3 limitVec(vec3 v, float max_len) {
    float len = length(v);
    return len > max_len ? v * (max_len / len) : v;
}

void main() {
    uint idx = gl_GlobalInvocationID.x;
    uint count = uint(ISF_READ(geo, position).length());
    if (idx >= count) return;

    // Initialize once (auxiliary buffers start zero-filled)
    if (ISF_READ(geo, state).initialized == 0u) {
        if (idx == 0u)
            ISF_WRITE(geo, state).initialized = 1u;

        // Scatter boids randomly in a cube
        float x = hash(idx * 3u) * 2.0 - 1.0;
        float y = hash(idx * 3u + 1u) * 2.0 - 1.0;
        float z = hash(idx * 3u + 2u) * 2.0 - 1.0;

        ISF_WRITE(geo, position)[idx] = vec4(x, y, z, 1.0);

        // Random initial velocity
        float vx = (hash(idx * 7u) - 0.5) * 0.01;
        float vy = (hash(idx * 7u + 1u) - 0.5) * 0.01;
        float vz = (hash(idx * 7u + 2u) - 0.5) * 0.01;
        ISF_WRITE(geo, velocity)[idx] = vec4(vx, vy, vz, 0.0);

        ISF_WRITE(geo, color)[idx] = vec4(0.3, 0.6, 1.0, 1.0);
        return;
    }

    // Read this boid's previous state from the frozen snapshot
    vec3 pos = ISF_READ(geo, position)[idx].xyz;
    vec3 vel = ISF_READ(geo, velocity)[idx].xyz;

    // Flocking accumulators
    vec3 sep = vec3(0.0);  // Separation: steer away from close neighbors
    vec3 ali = vec3(0.0);  // Alignment: match neighbors' average velocity
    vec3 coh = vec3(0.0);  // Cohesion: steer toward neighbors' center of mass
    int neighbors = 0;

    float r2 = radius * radius;

    // Read ALL other boids from the previous-frame snapshot.
    // This is why feedback double-buffering is essential: every thread
    // sees the same consistent snapshot regardless of execution order.
    for (uint j = 0u; j < count; j++) {
        if (j == idx) continue;

        vec3 other_pos = ISF_READ(geo, position)[j].xyz;
        vec3 other_vel = ISF_READ(geo, velocity)[j].xyz;
        vec3 diff = pos - other_pos;
        float d2 = dot(diff, diff);

        if (d2 < r2 && d2 > 0.0001) {
            float d = sqrt(d2);

            // Separation: inversely proportional to distance
            sep += diff / d2;

            // Alignment + cohesion: accumulate
            ali += other_vel;
            coh += other_pos;
            neighbors++;
        }
    }

    if (neighbors > 0) {
        float fn = float(neighbors);

        // Separation: steer away from average repulsion direction
        vel += limitVec(sep / fn, maxSpeed) * separation;

        // Alignment: steer toward average neighbor velocity
        vec3 avg_vel = ali / fn;
        vel += limitVec(avg_vel - vel, maxSpeed) * alignment;

        // Cohesion: steer toward center of mass of neighbors
        vec3 center = coh / fn;
        vel += limitVec(center - pos, maxSpeed) * cohesion;
    }

    // Soft boundary: steer back when approaching the edges of a unit cube
    float boundary = 1.5;
    float margin = 0.3;
    float turn = 0.002;
    if (pos.x >  boundary - margin) vel.x -= turn;
    if (pos.x < -boundary + margin) vel.x += turn;
    if (pos.y >  boundary - margin) vel.y -= turn;
    if (pos.y < -boundary + margin) vel.y += turn;
    if (pos.z >  boundary - margin) vel.z -= turn;
    if (pos.z < -boundary + margin) vel.z += turn;

    // Clamp speed
    vel = limitVec(vel, maxSpeed);

    // Integrate
    pos += vel;

    ISF_WRITE(geo, position)[idx] = vec4(pos, 1.0);
    ISF_WRITE(geo, velocity)[idx] = vec4(vel, 0.0);

    // Color by velocity direction
    vec3 dir = vel / (length(vel) + 0.0001);
    ISF_WRITE(geo, color)[idx] = vec4(dir * 0.5 + 0.5, 1.0);
}
```

## Related Processes

- [[ISF Shader]]: Classic fragment shaders.
- [[Render Pipeline]]: Raw vertex/fragment pipeline for custom geometry rendering.
- [[Model Display]]: To apply the shader onto a 3D surface.
- [[Pixel Utilities|Lightness Computer]]: To convert texture data into pixel arrays, for instance for [[LED design]].
