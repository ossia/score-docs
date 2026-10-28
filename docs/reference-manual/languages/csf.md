---
layout: default
title: CSF language reference
parent: Languages
grand_parent: Reference
nav_order: 22
permalink: /reference/languages/csf.html
---

# CSF language reference

This is the canonical shader contract for the [[Compute Shaders]] process. For GLSL syntax, generated declarations and portability, see [GLSL runtime reference]({{ site.baseurl }}/reference/languages/glsl.html). For worked tasks, see [[Shader cookbook]].

CSF is score's compute-shader extension of ISF, not part of the standard ISF specification. Its JSON header describes GPU allocations and dispatches; its body uses Vulkan-compatible GLSL. Shared controls and sampled inputs follow the [ISF input contract]({{ site.baseurl }}/reference/languages/isf.html#scalar-input-types), while the resource, buffer and geometry interfaces below are score-specific.

## Minimal file

```glsl
/*{
  "ISFVSN": "2.0",
  "MODE": "COMPUTE_SHADER",
  "RESOURCES": [
    { "NAME": "inputImage", "TYPE": "image", "ACCESS": "read_only", "FORMAT": "rgba8" },
    { "NAME": "outputImage", "TYPE": "image", "ACCESS": "write_only", "FORMAT": "rgba8",
      "WIDTH": "$WIDTH_inputImage", "HEIGHT": "$HEIGHT_inputImage" }
  ],
  "PASSES": [{
    "LOCAL_SIZE": [16, 16, 1],
    "EXECUTION_MODEL": { "TYPE": "2D_IMAGE", "TARGET": "outputImage" }
  }]
}*/

void main() {
    ivec2 p = ivec2(gl_GlobalInvocationID.xy);
    if (any(greaterThanEqual(p, imageSize(outputImage)))) return;
    vec4 c = IMG_LOAD(inputImage, p);
    IMG_STORE(outputImage, p, vec4(1.0 - c.rgb, c.a));
}
```

## Header fields

| Field | Required | Description |
|---|---:|---|
| `MODE` | yes | Must be `"COMPUTE_SHADER"`. |
| `PASSES` | yes | Compute dispatches to run each frame. |
| `RESOURCES` | no | GPU resources, ports, and controls. |
| `INPUTS` | no | Deprecated in a compute shader, with a warning: its entries keep their ISF meaning, see below. |
| `TYPES` | no | User-defined struct layouts used by buffers and geometry attributes. |
| `DESCRIPTION`, `CREDIT`, `CATEGORIES`, `ISFVSN` | no | Metadata. |

The header follows the [ISF header syntax]({{ site.baseurl }}/reference/languages/isf.html#header-syntax) (case-independent keys, comments, error messages) and the [input name rules]({{ site.baseurl }}/reference/languages/isf.html#input-names), which apply to resource names.

A compute shader declares its controls and resources in `RESOURCES`. An `INPUTS` list is still read, with the ISF meaning of its entries: an `image` there is a sampled texture unless it declares `ACCESS` or `FORMAT`, and `IS_DEPTH` is refused on it. The shader then gets the warning *INPUTS is deprecated in a COMPUTE_SHADER*: move the entries to `RESOURCES`, turning the sampled images into `texture` entries.

## Resource types

Each resource has `NAME` and `TYPE`; a `RESOURCES` entry without a `TYPE`, or with one the parser does not know, is an error naming the entry. Type names are case-independent, but lower-case matches most *score* examples.

| Type | Meaning |
|---|---|
| `image` | Storage image (`image2D`, `image3D`, `image2DArray`), read and written with `IMG_LOAD` / `IMG_STORE`. |
| `image_cube` | Writable cubemap storage image. |
| `texture` | Read-only sampled texture. |
| `cubemap` | Read-only sampled cubemap. |
| `storage` | Structured SSBO. |
| `uniform` | std140 UBO. Read-only, small data. |
| `geometry` | GPU geometry port with per-attribute buffers. |
| `float`, `long`, `bool`, `event`, `point2D`, `point3D`, `color` | UI controls and uniforms. |
| `audio`, `audioFFT`, `audioHistogram` | Audio textures. |

`event` inputs accept an impulse as well as `true`, and fire for one rendered frame. Use an event for a simulation reset rather than a permanently enabled boolean.

## Images

A CSF `image` resource is a storage image: it can be read, written, or read/write. To sample an image with a filter, declare a [`texture`](#sampled-textures) instead.

```json
{
  "NAME": "outputImage",
  "TYPE": "image",
  "ACCESS": "write_only",
  "FORMAT": "rgba16f",
  "WIDTH": "$WIDTH_inputImage",
  "HEIGHT": "$HEIGHT_inputImage"
}
```

| Field | Description |
|---|---|
| `ACCESS` | `read_only`, `write_only`, or `read_write`. |
| `FORMAT` | GLSL image format, see [Image formats](#image-formats). The image is allocated in that format. |
| `WIDTH`, `HEIGHT`, `DEPTH` | Size expressions. `DEPTH` creates a 3D image. Each of `WIDTH` and `HEIGHT` takes its expression, else the size of the first input image, else the render size. |
| `DIMENSIONS` | `2` or `3`. Alternative way to declare 3D images. |
| `IS_ARRAY` / `ARRAY` | 2D texture array image. Not with a cubemap or a 3D image: both are refused. |
| `LAYERS` | Array layer count expression. |
| `CUBEMAP` / `IS_CUBE` | Cubemap storage image, as `TYPE: "image_cube"`. |
| `PERSISTENT` | Image history; the previous frame is available as `<name>_prev`. Requires `ACCESS: "read_write"`. |
| `GENERATE_MIPS` | Generate mipmaps after the dispatch. Valid for 2D images. |
| `VISIBILITY` | Shader stages that see the image: `compute` (the default in a compute shader), `fragment`, `vertex`, `vertex+fragment` (also spelled `both`, `graphics` or `all`) or `none`, in any case. Another value is an error. |
| `COMPOSITE` | How the published image composites when consumed directly: `over`, `add`, `multiply`, `screen`, `replace`. |

Use the portable image helpers when orientation matters:

```glsl
vec4 c = IMG_LOAD(inputImage, ivec2(x, y));
IMG_STORE(outputImage, ivec2(x, y), c);
IMG_STORE_LAYER(arrayImage, ivec3(x, y, layer), c);
```

Integer storage formats such as `rgba32ui` require Qt 6.10 or newer, plus device support. With earlier Qt versions, they are allocated as RGBA8; that fallback does not preserve integer shader semantics. See [[Graphics pipeline]] for sizing and backend restrictions.

Raw `imageLoad` / `imageStore` also work, but they do not apply *score*'s coordinate-origin fixups.

### 3D image

```json
{
  "NAME": "volume",
  "TYPE": "image",
  "ACCESS": "write_only",
  "FORMAT": "r32f",
  "WIDTH": 128,
  "HEIGHT": 128,
  "DEPTH": 128
}
```

Dispatch with `EXECUTION_MODEL: { "TYPE": "3D_IMAGE", "TARGET": "volume" }` and write with `ivec3` coordinates.

### Persistent image

```json
{ "NAME": "state", "TYPE": "image", "ACCESS": "read_write", "FORMAT": "rgba32f",
  "WIDTH": 1024, "HEIGHT": 1024, "PERSISTENT": true }
```

`state` is the current writable image. `state_prev` is a separate read-only image holding the previous frame. On the first frame, `state_prev` is filled from `state` before each pass, so a pass reads what the earlier passes of that frame wrote, never what it is writing itself. The image the node outputs is the one written this frame. `PERSISTENT` requires `read_write`: with `read_only` or `write_only` the header is refused.

## Sampled textures

A read-only sampled texture is declared with `TYPE: "texture"` (or `"cubemap"` for a cubemap).

```json
{ "NAME": "lookup", "TYPE": "texture", "FILTER": "nearest", "WRAP": "clamp_to_edge" }
{ "NAME": "volumeTex", "TYPE": "texture", "DIMENSIONS": 3 }
{ "NAME": "layers", "TYPE": "texture", "IS_ARRAY": true }
{ "NAME": "sky", "TYPE": "cubemap", "MIPMAP_MODE": "linear" }
```

| Field | Description |
|---|---|
| `DIMENSIONS` | `2` or `3` (`sampler3D`). |
| `IS_ARRAY` | A 2D texture array (`sampler2DArray`). |
| `CUBE` | A cubemap (`samplerCube`), without `DIMENSIONS: 3` or `IS_ARRAY`. |
| `STATIC` | Bind the producer's texture directly instead of rendering it into the input's own target. |

`IS_DEPTH` is refused on a `texture`: the `<name>_depth` companion only exists for an [ISF image input]({{ site.baseurl }}/reference/languages/isf.html#sampleable-depth).

Sampler fields and their resolution are the same as in ISF: `WRAP`, `WRAP_S`, `WRAP_T`, `WRAP_R`, `FILTER`, `MIN_FILTER`, `MAG_FILTER`, `MIPMAP_MODE` and `COMPARE`, each field taken from the inlet when the user set it, else from the JSON, else the default. See [ISF sampler state]({{ site.baseurl }}/reference/languages/isf.html#sampler-state), which also lists the keys accepted without effect.

## Storage buffers

`storage` declares an SSBO using std430 layout rules.

```json
{
  "NAME": "particles",
  "TYPE": "storage",
  "ACCESS": "read_write",
  "PERSISTENT": true,
  "LAYOUT": [
    { "NAME": "count", "TYPE": "uint" },
    { "NAME": "pos", "TYPE": "vec4[]" }
  ]
}
```

Fields:

| Field | Description |
|---|---|
| `ACCESS` | `read_only`, `write_only`, or `read_write`. |
| `LAYOUT` | Struct fields, required. The last field may be a flexible array with `[]`. |
| `PERSISTENT` | Buffer history; previous frame is `<name>_prev`. Requires `ACCESS: "read_write"`. |
| `VISIBILITY` | Graphics-stage visibility when shared: `compute`, `fragment`, `vertex`, `vertex+fragment`, or `none`. |
| `BUFFER_USAGE` | Special usage: `indirect_draw` or `indirect_draw_indexed`. Indirect dispatch needs no special usage: point `EXECUTION_MODEL` `TYPE: "INDIRECT"` at an ordinary storage buffer (see [Indirect dispatch](#indirect-dispatch)). |

Access fields as members:

```glsl
uint n = particles.count;
vec4 p = particles.pos[i];
```

A field `TYPE` may have several array extents, each a positive integer constant expression: `vec4[2][3]`, `float[4 * 8]`. Only the outermost one may be runtime-sized (`vec4[][3]`). A layout that cannot be sized this way is refused with a message naming the field.

A writable buffer whose `LAYOUT` ends in a flexible array gets a **`<name> size`** control (1 to 536870911, default 1024): the element count of that array. Changing it recreates the buffer, zero-filled; a `PERSISTENT` buffer and its `_prev` start again from zeros. A buffer is limited by what the device binds (Vulkan `maxStorageBufferRange`, OpenGL `GL_MAX_SHADER_STORAGE_BLOCK_SIZE`); one that cannot be allocated at its declared size stops the shader's passes, with a warning naming it, until its size is reduced.

A read-only storage resource fed by a cable binds the range of the buffer its producer publishes, at the device's offset alignment, so `.length()` is the published element count. A buffer without storage usage, or published at an unaligned offset, is not bound: the resource keeps its own zero-filled buffer, and a warning is printed once.

## Uniform buffers

`uniform` declares a std140 UBO. Use it for small read-only data such as cameras, counts, and constants.

```json
{
  "NAME": "camera",
  "TYPE": "uniform",
  "VISIBILITY": "vertex+fragment",
  "LAYOUT": [
    { "NAME": "viewProjection", "TYPE": "mat4" },
    { "NAME": "position", "TYPE": "vec4" }
  ]
}
```

A `uniform` resource gets an inlet. It binds the buffer cabled there, at the range its producer publishes, when that buffer has uniform usage and holds at least the block's fixed part plus one element of a trailing array. Otherwise the block reads a zero-filled buffer sized from its `LAYOUT`, and a warning is printed once.

For writable or large data, use `storage` instead.

## Geometry resources

A `geometry` resource publishes or consumes GPU-resident geometry. It is the bridge from compute to [[Render Pipeline]] and [[Model Display]].

```json
{
  "NAME": "geo",
  "TYPE": "geometry",
  "VERTEX_COUNT": 36,
  "INSTANCE_COUNT": "$USER",
  "TOPOLOGY": "triangles",
  "ATTRIBUTES": [
    { "NAME": "position", "SEMANTIC": "position", "TYPE": "vec4", "ACCESS": "write_only", "RATE": "vertex" },
    { "NAME": "normal", "SEMANTIC": "normal", "TYPE": "vec4", "ACCESS": "write_only", "RATE": "vertex" },
    { "NAME": "translation", "SEMANTIC": "translation", "TYPE": "vec4", "ACCESS": "write_only", "RATE": "instance" },
    { "NAME": "color", "SEMANTIC": "color", "TYPE": "vec4", "ACCESS": "write_only", "RATE": "instance" }
  ]
}
```

### Generator or filter

- If `VERTEX_COUNT` is present, the CSF creates its own geometry buffers.
- If `VERTEX_COUNT` is omitted, the CSF acts as a geometry filter and adopts upstream geometry sizes.

Set `TOPOLOGY` explicitly when producing points or lines. The topology travels with the generated geometry, but the downstream Render Pipeline **Mode** must be **Geometry** to follow it automatically. An explicit raster `PIPELINE_STATE.TOPOLOGY` overrides that control. A buffer of three positions alone does not tell a renderer whether you intend one triangle or three points.

### Geometry fields

| Field | Description |
|---|---|
| `VERTEX_COUNT` | Vertex count expression. May use `$USER`, scalar inputs, texture sizes, or other geometry counts. |
| `INSTANCE_COUNT` | Instance count expression. |
| `TOPOLOGY` | `triangles`, `triangle_strip`, `triangle_fan`, `lines`, `line_strip`, or `points`. |
| `FORMAT_ID` | Optional format tag stamped on the output geometry. |
| `PERSISTENT` | For filters, read/write attributes work on persistent upstream buffers instead of a fresh per-frame copy. |
| `INDIRECT` | Allocate GPU-written indirect draw commands. |
| `AUXILIARY` | Structured buffers or textures that travel with this geometry. |
| `ATTRIBUTES` | Per-vertex and per-instance attribute buffers. |

### Attribute fields

| Field | Description |
|---|---|
| `NAME` | GLSL attribute name. |
| `SEMANTIC` | Semantic used by downstream renderers. Defaults to `NAME`. Standard examples: `position`, `normal`, `color`, `texcoord`, `tangent`, `velocity`, `instance_draw_id`. |
| `TYPE` | GLSL type such as `float`, `vec2`, `vec3`, `vec4`, `uint`, `mat4`, or a type from `TYPES`. |
| `ACCESS` | `read_only`, `write_only`, `read_write`, or `gather`. |
| `RATE` | `vertex` or `instance`. Defaults to `vertex`. |
| `REQUIRED` | `false` allows missing upstream attributes to use a fallback. |
| `COPY_FROM` | Forward an attribute from another geometry without shader writes. |

An attribute read from an upstream geometry is decoded from its source format (32-bit float, 8-bit normalized, half float, 32-bit signed or unsigned integer) into the type the shader declares, with the usual `(0, 0, 0, 1)` fill for missing components. A float read as `uint` or `int` is truncated and clamped to the type's range, NaN and negative values giving 0 for `uint`. Scalar and vector types convert into each other this way.

An attribute the shader writes is published as what it is: `int` / `ivec*` with signed formats, `uint` / `uvec*` with unsigned ones. A `bool`, matrix or struct attribute is published as a user struct carrying its GLSL type name and std430 element size. A compute shader reads such an attribute only as the same type at the same size; otherwise it reads zeros, and one warning names both types. A raster vertex input matching it refuses its pipeline with a warning.

`ACCESS: "gather"` means read/write plus foreign-index reads. Use it for neighbour loops, N-body interactions, stencils, and any shader that reads indices other than its own invocation. It forces separate `_in` and `_out` buffers so reads see a stable snapshot.

Access attributes with macros:

```glsl
vec4 p = ISF_READ(geo, position)[idx];
ISF_WRITE(geo, position)[idx] = p + vec4(0.0, 0.01, 0.0, 0.0);
uint count = uint(ISF_READ(geo, position).length());
```

For `read_write`, `ISF_READ` expands to the input/snapshot buffer and `ISF_WRITE` to the output buffer.

### COPY_FROM

Forwarding is useful when an output geometry combines computed attributes with unchanged data from another input.

```json
{ "NAME": "normal", "TYPE": "vec4", "COPY_FROM": { "GEOMETRY": "source", "ATTRIBUTE": "normal" } }
```

The forwarded attribute is not bound for shader reads or writes.

### Indirect draw

```json
"INDIRECT": { "COUNT": "$USER", "DRAW_COUNT": true, "INDEXED": false }
```

`INDIRECT` allocates an indirect-command buffer associated with the geometry. The shader fills draw commands and optionally a draw-count buffer. The runtime uses GPU indirect drawing when available and compatible fallbacks otherwise.

Use `ISF_INDIRECT(geo)` and, with `DRAW_COUNT`, `ISF_INDIRECT_COUNT(geo)` in GLSL; both work for any number of `INDIRECT` geometries in one shader. The records are the GPU's own command layouts, five words each:

```glsl
struct DrawIndirectCommand {        // "INDEXED": false
    uint vertexCount; uint instanceCount; uint firstVertex; uint firstInstance;
    int  baseVertex;                // unused by a non-indexed draw
};
struct DrawIndexedIndirectCommand { // "INDEXED": true
    uint indexCount; uint instanceCount; uint firstIndex; int baseVertex;
    uint firstInstance;
};
```

With `DRAW_COUNT`, the commands at or past the count the shader writes are not drawn, whatever they hold, on every backend: where the device has no draw-count support, a compute pass copies the commands with those slots zeroed before drawing, without reading anything back.

When allocating a capacity of commands, guard indirectly dispatched work against the live count. Some backends use bounded dispatch or draw fallbacks rather than native GPU-count execution. [[Shader cookbook]] shows the corresponding corpus recipe, plus geometry forwarding and audio input examples.

## Auxiliary buffers and textures

Geometry can carry extra data besides attributes.

### SSBO auxiliary

```json
"AUXILIARY": [
  {
    "NAME": "physics",
    "ACCESS": "read_write",
    "SIZE": "$USER",
    "LAYOUT": [
      { "NAME": "totalEnergy", "TYPE": "float" },
      { "NAME": "velocity", "TYPE": "vec4[]" }
    ]
  }
]
```

A `read_write` auxiliary is one buffer that keeps its contents from frame to frame, also when the geometry is fed back into the same shader: `<name>_in`, `<name>_out` and the plain name all refer to it. For a previous-frame copy, use a `PERSISTENT` storage buffer (`<name>_prev`), an attribute with `ACCESS: "gather"`, or two buffers alternated on even and odd frames.

### UBO auxiliary

```json
"AUXILIARY": [
  {
    "NAME": "scene_counts",
    "TYPE": "uniform",
    "LAYOUT": [ { "NAME": "drawCount", "TYPE": "uint" } ]
  }
]
```

### Texture auxiliary

Auxiliary textures travel with the geometry and do not create score input ports.

```json
"AUXILIARY": [
  { "NAME": "base_color", "TYPE": "texture", "FILTER": "linear" },
  { "NAME": "shadow_atlas", "TYPE": "image", "IS_DEPTH": true, "COMPARE": "less" },
  { "NAME": "history", "TYPE": "storage_image", "FORMAT": "rgba16f", "ACCESS": "read_write", "WIDTH": 1024, "HEIGHT": 1024 }
]
```

Auxiliary texture `TYPE` values include `image`, `texture`, `cubemap`, `image_cube`, `storage_image`, `storage_cube`, `storage_image_array`, and `storage_3d`. An auxiliary texture is a storage image only when its `TYPE` is one of the `storage_*` ones; a `FORMAT` alone does not make it one, and a `"STORAGE"` key is refused.

`IS_DEPTH: true` marks a texture that holds depth, sampled with `COMPARE` for shadows; it binds that one texture, with no `_depth` companion. `DEPTH` is the depth of a volume, a number or an expression.

## Custom types

`TYPES` declares reusable struct layouts.

```json
"TYPES": [
  { "NAME": "Particle", "LAYOUT": [
    { "NAME": "position", "TYPE": "vec4" },
    { "NAME": "velocity", "TYPE": "vec4" },
    { "NAME": "life", "TYPE": "float" }
  ] }
]
```

Use type names in storage layouts and geometry attributes.

## Passes and execution models

CSF shaders run one or more dispatch passes per frame.

```json
"PASSES": [
  { "LOCAL_SIZE": [16, 16, 1], "EXECUTION_MODEL": { "TYPE": "2D_IMAGE", "TARGET": "outputImage" } }
]
```

| Pass field | Description |
|---|---|
| `LOCAL_SIZE` | Workgroup size `[x, y, z]`, three integers of at least 1. Defaults to `[16, 16, 1]`. |
| `EXECUTION_MODEL` | Dispatch strategy. |

Every `PASSES` entry of a compute shader is a dispatch, with or without `LOCAL_SIZE`, run in the order written. `PASSINDEX` is the current pass number.

Workgroup counts are computed in 64 bits against the device's per-dimension limit. A pass that needs more workgroups than the device dispatches is skipped, with a warning.

### Execution model types

| Type | Dispatches over | Required / useful fields |
|---|---|---|
| `2D_IMAGE` | Width and height of target image | `TARGET`, optional `STRIDE_X`, `STRIDE_Y` |
| `3D_IMAGE` | Width, height, depth of target image | `TARGET`, optional `STRIDE_X/Y/Z` |
| `PER_VERTEX` | Vertex count of a geometry | optional strides |
| `PER_INSTANCE` | Instance count of a geometry | optional strides |
| `1D_BUFFER` | Elements of a storage buffer: the element count of its trailing array, `$COUNT_<TARGET>` | `TARGET`; without one, the storage buffer the shader outputs, or with none, the vertices of the first geometry |
| `MANUAL` | Fixed workgroup count | `WORKGROUPS` |
| `USER` | User-controlled workgroup count | creates X/Y/Z dispatch controls |
| `INDIRECT` | Workgroups read from a storage buffer | `TARGET`, `WORKGROUPS` fallback ceiling, optional `OFFSET` |

`STRIDE`, `STRIDE_X`, `STRIDE_Y`, and `STRIDE_Z` reduce dispatched workgroups. Strides can be integers or expressions.

### Indirect dispatch

```json
{
  "LOCAL_SIZE": [64, 1, 1],
  "EXECUTION_MODEL": {
    "TYPE": "INDIRECT",
    "TARGET": "dispatchArgs",
    "WORKGROUPS": [1024, 1, 1],
    "OFFSET": 0
  }
}
```

`TARGET` is a storage buffer containing a `{x, y, z}` `uint` triplet at byte `OFFSET`, relative to the part of the buffer the shader sees. `WORKGROUPS` is the fallback ceiling used when the backend cannot dispatch indirectly; the shader must still bounds-check. When `OFFSET` is not a multiple of 4, or the 12 bytes of the triplet do not fit in the buffer from there, the pass runs with its `WORKGROUPS` ceiling and a warning is printed once.

## Expressions

Many fields accept expressions:

| Variable | Meaning |
|---|---|
| `$inputName` | Value of a scalar input. |
| `$USER` | Dedicated user integer slider. |
| `$WIDTH_name`, `$HEIGHT_name`, `$DEPTH_name`, `$LAYERS_name` | Texture dimensions. |
| `$VERTEX_COUNT`, `$INSTANCE_COUNT` | Counts of the first geometry. |
| `$VERTEX_COUNT_geo`, `$INSTANCE_COUNT_geo` | Counts of a named geometry. |
| `$COUNT_buf` | Element count of the trailing array of a storage or uniform buffer: the elements its allocation holds for a flexible array, the product of the extents for a fixed one, 1 when the layout ends in no array. A capacity, not the number of elements a shader has written. |
| `$BYTESIZE_buf` | Byte size of that buffer's allocation. |

`$COUNT_` and `$BYTESIZE_` cover the buffers the shader declares and those carried by its input geometries. When both have the same name, the one the shader declares at the top level is used.

Supported operators include `+`, `-`, `*`, `/`, `%`, comparisons, `&&`, and `||`. Supported functions include `abs`, `sqrt`, `sin`, `cos`, `tan`, `exp`, `log`, `ceil`, `floor`, `round`, `min`, `max`, `pow`, `clamp`, `lerp`, `step`, and `smoothstep`. `lerp`, `step` and `smoothstep` take their arguments in another order than in GLSL: see [ISF size expressions]({{ site.baseurl }}/reference/languages/isf.html#size-expressions).

## Built-in uniforms

| Uniform | Type | Description |
|---|---|---|
| `TIME` | `float` | Playback time in seconds. |
| `TIMEDELTA` | `float` | Time since previous frame. |
| `PROGRESS` | `float` | Timeline progress from 0 to 1. |
| `FRAMEINDEX` | `int` | Frame counter. Starts at 0. |
| `PASSINDEX` | `int` | Current pass index. |
| `RENDERSIZE` | `vec2` | Render size in pixels. |
| `DATE` | `vec4` | `(year, month, day, seconds)`. |
| `SAMPLERATE` | `float` | Audio sample rate. |
| `gl_NumWorkGroups` / `isf_NumWorkGroups` | `uvec3` | Workgroup count of the current dispatch. On Direct3D it is a uniform: in an `INDIRECT` pass it holds the `WORKGROUPS` ceiling, not the count the GPU dispatches, and a warning says so. |

## Image formats

The storage image formats are the ones the engine can allocate:

| Category | Formats |
|---|---|
| Float / normalized | `rgba32f`, `rgba16f`, `rgba8`, `rg8`, `rg16`, `r32f`, `r16f`, `r16`, `r8`, `rgb10_a2` |
| Signed integer (Qt 6.10+) | `rgba32i`, `rg32i`, `r32i`, `r8i` |
| Unsigned integer (Qt 6.10+) | `rgba32ui`, `rg32ui`, `r32ui`, `r8ui` |

Format names are case-independent. `bgra8` is read as `rgba8`, which reads and writes the same values. Any other format, including valid GLSL ones the engine cannot allocate (`snorm`, `rg16f`, `rgba16`, 16-bit integers...), falls back to `rgba8` in the shader declaration and the allocation alike, with a warning shown in the shader's editor.

## Patterns

### Image filter

```glsl
/*{
  "ISFVSN": "2.0",
  "MODE": "COMPUTE_SHADER",
  "RESOURCES": [
    { "NAME": "inputImage", "TYPE": "texture" },
    { "NAME": "outputImage", "TYPE": "image", "ACCESS": "write_only", "FORMAT": "rgba8",
      "WIDTH": "$WIDTH_inputImage", "HEIGHT": "$HEIGHT_inputImage" },
    { "NAME": "gain", "TYPE": "float", "DEFAULT": 1.0, "MIN": 0.0, "MAX": 4.0 }
  ],
  "PASSES": [{ "LOCAL_SIZE": [16, 16, 1], "EXECUTION_MODEL": { "TYPE": "2D_IMAGE", "TARGET": "outputImage" } }]
}*/

void main() {
    ivec2 p = ivec2(gl_GlobalInvocationID.xy);
    if (any(greaterThanEqual(p, imageSize(outputImage)))) return;
    vec2 uv = (vec2(p) + 0.5) / vec2(imageSize(outputImage));
    vec4 c = texture(inputImage, uv);
    IMG_STORE(outputImage, p, vec4(c.rgb * gain, c.a));
}
```

### Geometry filter

```json
"RESOURCES": [
  { "NAME": "strength", "TYPE": "float", "DEFAULT": 0.1, "MIN": 0.0, "MAX": 2.0 },
  { "NAME": "geo", "TYPE": "geometry",
    "ATTRIBUTES": [
      { "NAME": "position", "SEMANTIC": "position", "TYPE": "vec4", "ACCESS": "read_write" },
      { "NAME": "normal", "SEMANTIC": "normal", "TYPE": "vec4", "ACCESS": "read_only" }
    ] }
],
"PASSES": [ { "LOCAL_SIZE": [64, 1, 1], "EXECUTION_MODEL": { "TYPE": "PER_VERTEX" } } ]
```

```glsl
void main() {
    uint i = gl_GlobalInvocationID.x;
    uint n = uint(ISF_READ(geo, position).length());
    if (i >= n) return;
    vec4 p = ISF_READ(geo, position)[i];
    vec3 normal = normalize(ISF_READ(geo, normal)[i].xyz);
    ISF_WRITE(geo, position)[i] = p + vec4(normal * strength, 0.0);
}
```

### Particle feedback

For particle simulations, use `read_write` or `gather` attributes plus a feedback cable from the geometry output back to the geometry input. The runtime allocates snapshots / ping-pong buffers so reads see the previous state and writes produce the next state.

Use `gather` when each invocation reads neighbours:

```json
{ "NAME": "position", "SEMANTIC": "position", "TYPE": "vec4", "ACCESS": "gather" }
```
