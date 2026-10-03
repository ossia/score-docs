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

The Compute Shader process runs CSF shaders: *score*'s compute-shader extension of ISF. Use CSF when a fullscreen fragment pass is not the right model: image processing, storage images, GPU simulations, particle systems, geometry generation, geometry filters, buffer writes, volume generation, and indirect draw preparation.

A CSF file is a GLSL compute shader with a JSON header. It can be dropped from the file explorer or user library. Controls, GPU resources, input and output ports are built from the header.

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
| `RESOURCES` | no | GPU resources, ports, and controls. Preferred CSF spelling. |
| `INPUTS` | no | Alias accepted by the parser; useful for shared ISF-style conventions. |
| `TYPES` | no | User-defined struct layouts used by buffers and geometry attributes. |
| `DESCRIPTION`, `CREDIT`, `CATEGORIES`, `ISFVSN` | no | Metadata. |

`RESOURCES` and `INPUTS` are parsed with the same resource vocabulary. In CSF examples, use `RESOURCES` to make the compute intent clear.

## Resource types

Each resource has `NAME` and `TYPE`. Type names are case-insensitive in practice, but lower-case matches most *score* examples.

| Type | Meaning |
|---|---|
| `image` | Storage image when `ACCESS` or `FORMAT` is present; otherwise sampled texture input. |
| `texture` | Read-only sampled texture. |
| `cubemap` | Read-only sampled cubemap. |
| `storage` | Structured SSBO. If `TYPE` is omitted, storage is the default. |
| `uniform` | std140 UBO. Read-only, small data. |
| `geometry` | GPU geometry port with per-attribute buffers. |
| `float`, `long`, `bool`, `event`, `point2D`, `point3D`, `color` | UI controls and uniforms. |
| `audio`, `audioFFT`, `audioHist` | Audio textures. |

`event` inputs accept an impulse as well as `true`, and fire for one rendered frame. Use an event for a simulation reset rather than a permanently enabled boolean.

## Images

A CSF `image` resource can be read, written, or read/write.

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
| `FORMAT` | GLSL image format such as `rgba8`, `rgba16f`, `rgba32f`, `r32f`, `rgba32ui`. |
| `WIDTH`, `HEIGHT`, `DEPTH` | Size expressions. `DEPTH` creates a 3D image. |
| `DIMENSIONS` | `2` or `3`. Alternative way to declare 3D images. |
| `IS_ARRAY` / `ARRAY` | 2D texture array image. |
| `LAYERS` | Array layer count expression. |
| `CUBEMAP` / `IS_CUBE` | Cubemap storage image. |
| `PERSISTENT` | Ping-pong image history; the previous frame is available as `<name>_prev`. |
| `GENERATE_MIPS` | Generate mipmaps after the dispatch. Valid for 2D images. |
| `VISIBILITY` | Binding visibility when the resource is shared with graphics stages: `compute`, `fragment`, `vertex`, or `vertex+fragment`. |
| `COMPOSITE` | How the published image composites when consumed directly: `over`, `add`, `multiply`, `screen`, `replace`. |

Use the portable image helpers when orientation matters:

```glsl
vec4 c = IMG_LOAD(inputImage, ivec2(x, y));
IMG_STORE(outputImage, ivec2(x, y), c);
IMG_STORE_LAYER(arrayImage, ivec3(x, y, layer), c);
```

Integer storage formats such as `rgba32ui` require Qt 6.10 or newer in the current format mapping, plus device support. Older builds fall back to RGBA8 for unsupported format names; that fallback does not preserve integer shader semantics. See [[Graphics pipeline]] for sizing and backend restrictions.

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

`state` is the current writable image. `state_prev` is the previous frame's read-only image. `PERSISTENT` with `write_only` is invalid because there is no meaningful previous read path.

## Sampled textures

A read-only sampled texture is declared with `TYPE: "texture"`, or with `TYPE: "image"` when no `ACCESS` / `FORMAT` is present.

```json
{ "NAME": "lookup", "TYPE": "texture", "FILTER": "nearest", "WRAP": "clamp_to_edge" }
{ "NAME": "volumeTex", "TYPE": "texture", "DIMENSIONS": 3 }
{ "NAME": "sky", "TYPE": "cubemap", "MIPMAP_MODE": "linear" }
```

Sampler fields are the same as ISF: `WRAP`, `WRAP_S`, `WRAP_T`, `WRAP_R`, `FILTER`, `MIN_FILTER`, `MAG_FILTER`, `MIPMAP_MODE`, `BORDER_COLOR`, `COMPARE`, `ANISOTROPY`, `LOD_BIAS`, `MIN_LOD`, `MAX_LOD`.

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
| `LAYOUT` | Struct fields. Last field may be a flexible array with `[]`. |
| `SIZE` | Flexible array length when needed. |
| `PERSISTENT` | Ping-pong buffer history; previous frame is `<name>_prev`. |
| `VISIBILITY` | Graphics-stage visibility when shared: `compute`, `fragment`, `vertex`, `vertex+fragment`, or `none`. |
| `BUFFER_USAGE` | Special usage: `indirect_draw`, `indirect_draw_indexed`, or `dispatch_args`. Allows empty `LAYOUT`. |

Access fields as members:

```glsl
uint n = particles.count;
vec4 p = particles.pos[i];
```

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

Use `ISF_INDIRECT(geo)` and, with `DRAW_COUNT`, `ISF_INDIRECT_COUNT(geo)` in GLSL.

When allocating a capacity of commands, initialize inactive slots to zero and guard indirectly dispatched work against the live count. Some backends use bounded dispatch or draw fallbacks rather than native GPU-count execution. [[Shader cookbook]] shows the corresponding corpus recipe, plus geometry forwarding and audio input examples.

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
  { "NAME": "shadow_atlas", "TYPE": "image", "DEPTH": true, "COMPARE": "less" },
  { "NAME": "history", "TYPE": "storage_image", "FORMAT": "rgba16f", "ACCESS": "read_write", "WIDTH": 1024, "HEIGHT": 1024 }
]
```

Auxiliary texture `TYPE` values include `image`, `texture`, `cubemap`, `image_cube`, `storage_image`, `storage_cube`, `storage_image_array`, and `storage_3d`.

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
| `LOCAL_SIZE` | Workgroup size `[x, y, z]`. Defaults to `[16, 16, 1]`. |
| `EXECUTION_MODEL` | Dispatch strategy. |

`PASSINDEX` is the current pass number.

### Execution model types

| Type | Dispatches over | Required / useful fields |
|---|---|---|
| `2D_IMAGE` | Width and height of target image | `TARGET`, optional `STRIDE_X`, `STRIDE_Y` |
| `3D_IMAGE` | Width, height, depth of target image | `TARGET`, optional `STRIDE_X/Y/Z` |
| `PER_VERTEX` | Vertex count of a geometry | optional strides |
| `PER_INSTANCE` | Instance count of a geometry | optional strides |
| `1D_BUFFER` | Elements of a storage buffer | `TARGET` |
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

`TARGET` is a storage buffer containing a `{x, y, z}` `uint` triplet. `WORKGROUPS` is the fallback ceiling used when the backend cannot dispatch indirectly; the shader must still bounds-check.

## Expressions

Many fields accept expressions:

| Variable | Meaning |
|---|---|
| `$inputName` | Value of a scalar input. |
| `$USER` | Dedicated user integer slider. |
| `$WIDTH_name`, `$HEIGHT_name`, `$DEPTH_name`, `$LAYERS_name` | Texture dimensions. |
| `$VERTEX_COUNT`, `$INSTANCE_COUNT` | Counts of the first geometry. |
| `$VERTEX_COUNT_geo`, `$INSTANCE_COUNT_geo` | Counts of a named geometry. |

Supported operators include `+`, `-`, `*`, `/`, `%`, comparisons, `&&`, and `||`. Supported functions include `abs`, `sqrt`, `sin`, `cos`, `tan`, `exp`, `log`, `ceil`, `floor`, `round`, `min`, `max`, `pow`, `clamp`, `lerp`, `step`, and `smoothstep`.

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
| `gl_NumWorkGroups` / `isf_NumWorkGroups` | `uvec3` | Actual workgroup count for the current dispatch. |

## Image formats

Common image formats:

| Category | Formats |
|---|---|
| Float / normalized | `rgba32f`, `rgba16f`, `rgba8`, `rg32f`, `rg16f`, `rg8`, `r32f`, `r16f`, `r8`, `rgb10_a2` |
| Signed integer | `rgba32i`, `rgba16i`, `rgba8i`, `rg32i`, `rg16i`, `rg8i`, `r32i`, `r16i`, `r8i` |
| Unsigned integer | `rgba32ui`, `rgba16ui`, `rgba8ui`, `rg32ui`, `rg16ui`, `rg8ui`, `r32ui`, `r16ui`, `r8ui` |

Format names are case-insensitive, but lower-case GLSL qualifiers are the safest spelling.

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

## Related Processes

- [[ISF Shaders]]: Fullscreen fragment shaders and post-processing.
- [[Render Pipeline]]: Draw CSF-generated or filtered geometry.
- [[Model Display]]: Display geometry with a built-in renderer.
- [[Pixel Utilities|Lightness Computer]]: Convert texture outputs to pixel arrays.
