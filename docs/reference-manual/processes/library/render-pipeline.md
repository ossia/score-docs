---
layout: default

title: Render Pipeline
description: "Using raw raster render pipelines in the ossia score graphics pipeline"

parent: Processes
grand_parent: Reference

permalink: /processes/render-pipeline.html
---

# Render Pipeline (Raw Raster)

The Render Pipeline process runs a raw vertex + fragment shader pipeline. Unlike [[ISF Shaders]], which render fullscreen image passes, a raw raster pipeline draws geometry: meshes, point clouds, instanced geometry, CSF-generated buffers, flattened scenes, procedural vertices, cubemaps, layered targets, and custom material passes.

Use it when you need explicit control over vertex attributes, uniforms, buffers, raster state, output attachments, depth, blending, topology, or draw count.

For a cabled geometry's own topology, select **Geometry** in the **Mode** control. **Triangles**, **Points**, and **Lines** deliberately override it. A shader's explicit `PIPELINE_STATE.TOPOLOGY` takes precedence over the control. This matters particularly for CSF-generated point clouds and line strips.

## Files

A raw raster pipeline uses two files with the same base name:

- `MyShader.fs` or `MyShader.frag`: fragment shader and JSON header.
- `MyShader.vs` or `MyShader.vert`: vertex shader.

Place both files in the [[library|user library]] or drop the fragment file in the score. The JSON header must be in the fragment shader.

Shader sources can use `#include`; includes are resolved relative to the shader path and global shader search paths before parsing.

## Minimal geometry shader

### Fragment shader: `VertexColor.fs`

```glsl
/*{
  "ISFVSN": "2.0",
  "MODE": "RAW_RASTER_PIPELINE",
  "DESCRIPTION": "Render upstream geometry with vertex colors",
  "CATEGORIES": ["3D"],
  "VERTEX_INPUTS": [
    { "TYPE": "vec4", "NAME": "position" },
    { "TYPE": "vec4", "NAME": "color", "REQUIRED": false, "DEFAULT": [1, 1, 1, 1] }
  ],
  "VERTEX_OUTPUTS": [ { "TYPE": "vec4", "NAME": "v_color" } ],
  "FRAGMENT_INPUTS": [ { "TYPE": "vec4", "NAME": "v_color" } ],
  "FRAGMENT_OUTPUTS": [ { "TYPE": "vec4", "NAME": "isf_FragColor" } ],
  "PIPELINE_STATE": { "DEPTH_TEST": true, "DEPTH_WRITE": true, "TOPOLOGY": "triangles" }
}*/

void main() {
    isf_FragColor = v_color;
}
```

### Vertex shader: `VertexColor.vs`

```glsl
void main() {
    isf_vertShaderInit();

    gl_Position = clipSpaceCorrMatrix
                * VIEWPROJECTION_MATRIX
                * MODEL_MATRIX
                * vec4(position.xyz, 1.0);
    v_color = color;

    isf_vertShaderFinish();
}
```

`isf_vertShaderInit()` must be the first statement in `main()`. `isf_vertShaderFinish()` must be the last statement. They handle multiview plumbing and the one required clip-space correction for non-OpenGL backends. Do not add your own backend-specific Y flip.

## Header fields

| Field | Description |
|---|---|
| `MODE` | Must be `"RAW_RASTER_PIPELINE"`. |
| `VERTEX_INPUTS` | Geometry attributes read by the vertex shader. |
| `VERTEX_OUTPUTS` | Varyings written by the vertex shader. |
| `FRAGMENT_INPUTS` | Varyings read by the fragment shader. Must match vertex outputs. |
| `FRAGMENT_OUTPUTS` | Fragment outputs. Defaults to `isf_FragColor`. |
| `INPUTS` | UI controls, texture inputs, storage buffers, uniform buffers. |
| `OUTPUTS` | Offscreen outputs: color, depth, formats, layers, cubemaps, MSAA. |
| `PIPELINE_STATE` | Depth, blend, cull, topology, stencil, procedural draw controls. |
| `AUXILIARY` | Buffers and textures travelling with upstream geometry or scenes. |
| `TYPES` | User-defined struct layouts. |
| `MULTIVIEW` | Number of views for multiview rendering. |
| `EXECUTION_MODEL` | Repeated raster invocation: per mip, per layer, per cubemap face, manual. |
| `ALPHA`, `COMPOSITE`, `QUEUE`, `LAYER` | Alpha and compositing / transparent layering controls. |
| `EXTENSIONS` | GLSL extensions to require. |
| `CLIP_DISTANCES`, `CULL_DISTANCES`, `DEPTH_LAYOUT`, `PRIMITIVE_DATA` | Advanced raster features. |

## Vertex inputs

`VERTEX_INPUTS` declare the attributes consumed by the vertex shader.

```json
"VERTEX_INPUTS": [
  { "TYPE": "vec3", "NAME": "position", "SEMANTIC": "position" },
  { "TYPE": "vec3", "NAME": "normal", "SEMANTIC": "normal", "REQUIRED": false },
  { "TYPE": "vec2", "NAME": "uv", "SEMANTIC": "texcoord" },
  { "TYPE": "uint", "NAME": "draw_id", "SEMANTIC": "instance_draw_id" }
]
```

| Field | Description |
|---|---|
| `NAME` | GLSL variable name. |
| `TYPE` | GLSL input type: `float`, vectors, matrices, integer types, etc. |
| `LOCATION` | Optional explicit location. Auto-assigned if omitted; matrices consume multiple locations. |
| `SEMANTIC` | Attribute semantic to match in upstream geometry. Defaults to `NAME`. Use `custom` for exact-name matching. |
| `REQUIRED` | Default `true`. `false` allows a neutral fallback if upstream geometry lacks the attribute. |
| `DEFAULT` | Explicit fallback value used when `REQUIRED: false`. |

Standard semantic names include `position`, `normal`, `texcoord`, `color`, and `tangent`. Scene and CSF pipelines can also provide custom semantics such as `translation`, `instance_draw_id`, material indices, or particle data.

## Varyings

`VERTEX_OUTPUTS` and `FRAGMENT_INPUTS` must match in order and type.

```json
"VERTEX_OUTPUTS": [
  { "TYPE": "vec3", "NAME": "v_normal", "INTERPOLATION": "smooth" },
  { "TYPE": "uint", "NAME": "v_draw", "INTERPOLATION": "flat" }
],
"FRAGMENT_INPUTS": [
  { "TYPE": "vec3", "NAME": "v_normal", "INTERPOLATION": "smooth" },
  { "TYPE": "uint", "NAME": "v_draw", "INTERPOLATION": "flat" }
]
```

`INTERPOLATION` can be `smooth`, `flat`, `noperspective`, `centroid`, or `sample`.

## Fragment outputs and render targets

Without `FRAGMENT_OUTPUTS`, the shader gets one `vec4 isf_FragColor` output.

```json
"FRAGMENT_OUTPUTS": [
  { "TYPE": "vec4", "NAME": "color" },
  { "TYPE": "vec4", "NAME": "normalRoughness" }
],
"OUTPUTS": [
  { "NAME": "color", "TYPE": "color", "FORMAT": "rgba16f", "SAMPLES": 4 },
  { "NAME": "normalRoughness", "TYPE": "color", "FORMAT": "rgba16f" },
  { "NAME": "depth", "TYPE": "depth", "FORMAT": "d32f" }
]
```

Output fields:

| Field | Description |
|---|---|
| `NAME` | Output name. |
| `TYPE` | `color` or `depth`. |
| `FORMAT` | Texture format such as `rgba8`, `rgba16f`, `rgba32f`, `r32f`, `d32f`. |
| `WIDTH`, `HEIGHT` | Fixed size or expression. |
| `LAYERS` | Texture array layer count. |
| `DEPTH` | 3D texture depth. |
| `CUBEMAP` | Allocate as cubemap. |
| `GENERATE_MIPS` | Generate mipmaps after rendering. |
| `SAMPLES` | MSAA sample count. |
| `ALPHA`, `COMPOSITE` | Per-output alpha / compositing policy. |

3D texture outputs cannot currently be written directly by raw raster; use [[Compute Shaders]] with `EXECUTION_MODEL: 3D_IMAGE` for true volumetric writes.

Color attachments sharing one framebuffer must have matching dimensions. The renderer uses the first explicit output size for the target; do not use different explicit sizes as a way to request independent MRT resolutions. Integer formats additionally depend on the Qt version and backend; see [[Graphics pipeline]].

## Controls and resource inputs

`INPUTS` supports normal ISF controls and richer graphics resources.

### UI controls

```json
"INPUTS": [
  { "NAME": "roughness", "TYPE": "float", "DEFAULT": 0.5, "MIN": 0.0, "MAX": 1.0 },
  { "NAME": "baseColor", "TYPE": "color", "DEFAULT": [1, 1, 1, 1] }
]
```

### Texture inputs

```json
{ "NAME": "albedo", "TYPE": "image", "FILTER": "linear", "WRAP": "repeat" }
{ "NAME": "env", "TYPE": "cubemap", "MIPMAP_MODE": "linear" }
```

Raw raster fragment shaders can use the same `IMG_*` helpers as ISF:

```glsl
vec4 c = IMG_NORM_PIXEL(albedo, v_uv);
vec4 t = IMG_TEXEL(albedo, ivec2(10, 20));
vec4 e = IMG_CUBE(env, reflectDir);
```

### Storage and uniform buffers

```json
{
  "NAME": "per_draws",
  "TYPE": "storage",
  "ACCESS": "read_only",
  "VISIBILITY": "vertex",
  "LAYOUT": [ { "NAME": "data", "TYPE": "PerDraw[]" } ]
}
```

```json
{
  "NAME": "cameraData",
  "TYPE": "uniform",
  "VISIBILITY": "vertex+fragment",
  "LAYOUT": [ { "NAME": "viewProjection", "TYPE": "mat4" } ]
}
```

`storage` uses SSBOs. `uniform` uses std140 UBOs. `VISIBILITY` controls which shader stages can access the binding.

## Built-in uniforms and macros

| Name | Type | Description |
|---|---|---|
| `TIME`, `TIMEDELTA`, `PROGRESS`, `FRAMEINDEX`, `PASSINDEX`, `RENDERSIZE`, `DATE`, `SAMPLERATE` | ISF-style uniforms | Same as ISF. |
| `clipSpaceCorrMatrix` | `mat4` | Platform clip-space correction. Multiply clip-space output by it. |
| `MODEL_MATRIX` | `mat4` | Upstream geometry model transform. Identity on flattened scene path. |
| `VIEW_MATRIX` | `mat4` | Active camera view matrix. |
| `PROJECTION_MATRIX` | `mat4` | Active camera projection matrix. |
| `VIEWPROJECTION_MATRIX` | `mat4` | Projection × view for active camera / view index. |
| `CAMERA_POSITION` | `vec3` | Active camera world position. |
| `VIEW_INDEX` | `int` | Multiview view index. `0` when not multiview. |
| `NUM_VIEWS` | `int` | Multiview count when multiview is enabled. |
| `MSAA_SAMPLES` | `int` | Active MSAA sample count. |

When a raw raster shader uses the built-in camera and does not declare its own `camera` binding, *score* injects a camera uniform block. The process gets a `Camera` geometry inlet when camera data can be connected.

## Geometry path vs scene path

### Geometry path

Use `MODEL_MATRIX` when a mesh, primitive, point cloud, or CSF geometry is connected directly to the Render Pipeline:

```glsl
gl_Position = clipSpaceCorrMatrix * VIEWPROJECTION_MATRIX * MODEL_MATRIX * vec4(position.xyz, 1.0);
```

If no camera is connected, the injected camera block uses identity placeholders so simple geometry shaders still draw.

### Scene path

Flattened scene renderers receive per-draw data in auxiliary buffers. In that path `MODEL_MATRIX` is intentionally identity; read the per-draw model matrix instead.

```json
"VERTEX_INPUTS": [
  { "TYPE": "vec3", "NAME": "position" },
  { "TYPE": "uint", "NAME": "draw_id", "SEMANTIC": "instance_draw_id" }
],
"INPUTS": [
  { "NAME": "per_draws", "TYPE": "storage", "ACCESS": "read_only", "VISIBILITY": "vertex",
    "LAYOUT": [ { "NAME": "data", "TYPE": "PerDraw[]" } ] }
],
"TYPES": [
  { "NAME": "PerDraw", "LAYOUT": [
    { "NAME": "model", "TYPE": "mat4" },
    { "NAME": "normal", "TYPE": "mat4" },
    { "NAME": "material_index", "TYPE": "uint" },
    { "NAME": "tag_hash", "TYPE": "uint" },
    { "NAME": "transform_slot", "TYPE": "uint" },
    { "NAME": "skeleton_offset", "TYPE": "uint" }
  ] }
]
```

```glsl
mat4 model = per_draws.data[draw_id].model;
gl_Position = clipSpaceCorrMatrix * VIEWPROJECTION_MATRIX * model * vec4(position, 1.0);
```

## Auxiliary scene data

Top-level `AUXILIARY` declares buffers and textures that are resolved from upstream geometry / scene data without creating score ports.

```json
"AUXILIARY": [
  { "NAME": "scene_counts", "TYPE": "uniform",
    "LAYOUT": [ { "NAME": "drawCount", "TYPE": "uint" } ] },
  { "NAME": "base_color", "TYPE": "texture", "FILTER": "linear" },
  { "NAME": "shadow_atlas", "TYPE": "image", "DEPTH": true, "COMPARE": "less" },
  { "NAME": "history", "TYPE": "storage_image", "FORMAT": "rgba16f", "ACCESS": "read_write",
    "WIDTH": 1024, "HEIGHT": 1024 }
]
```

Auxiliary buffer entries default to SSBOs. Use `TYPE: "uniform"` for UBOs. Auxiliary texture types include `image`, `texture`, `cubemap`, `image_cube`, `storage_image`, `storage_cube`, `storage_image_array`, and `storage_3d`.

## Pipeline state

`PIPELINE_STATE` controls the raster pipeline.

```json
"PIPELINE_STATE": {
  "DEPTH_TEST": true,
  "DEPTH_WRITE": true,
  "DEPTH_COMPARE": "less_equal",
  "CULL_MODE": "back",
  "FRONT_FACE": "ccw",
  "POLYGON_MODE": "fill",
  "TOPOLOGY": "triangles",
  "BLEND": {
    "ENABLE": true,
    "SRC_COLOR": "src_alpha",
    "DST_COLOR": "one_minus_src_alpha",
    "OP_COLOR": "add",
    "SRC_ALPHA": "one",
    "DST_ALPHA": "one_minus_src_alpha",
    "OP_ALPHA": "add"
  }
}
```

Common fields:

| Field | Description |
|---|---|
| `DEPTH_TEST`, `DEPTH_WRITE`, `DEPTH_COMPARE` | Depth state. |
| `DEPTH_BIAS`, `SLOPE_SCALED_DEPTH_BIAS` | Depth bias. |
| `CULL_MODE` | `none`, `front`, or `back`. |
| `FRONT_FACE` | `ccw` or `cw`. |
| `POLYGON_MODE` | `fill` or `line`. |
| `LINE_WIDTH` | Line width where supported. |
| `TOPOLOGY` | `triangles`, `triangle_strip`, `triangle_fan`, `lines`, `line_strip`, `points`. |
| `VERTEX_COUNT`, `INSTANCE_COUNT` | Procedural draw counts. |
| `BLEND` | One blend state for all outputs, or boolean shortcut. |
| `BLEND_PER_ATTACHMENT` | Per-output blend states. |
| `STENCIL_TEST` and stencil masks / ops | Stencil state. |
| `SHADING_RATE` | Variable-rate shading `[w, h]` where supported. |

If `VERTEX_COUNT` is set and `VERTEX_INPUTS` is empty, the pipeline performs a procedural draw driven by `gl_VertexIndex` / `gl_InstanceIndex`. If `VERTEX_INPUTS` is non-empty, the draw count is clamped to upstream geometry to avoid out-of-bounds reads.

## Alpha, compositing, and transparency

Older development notes mention a `TRANSPARENCY` header block. The current parser instead exposes `QUEUE` and `LAYER`; `TRANSPARENCY` is not a supported current field. Use the private-target and resolve workflow below rather than relying on an ignored header key.

Declare what your color outputs contain:

```json
{
  "ALPHA": "premultiplied",
  "COMPOSITE": "over",
  "QUEUE": "transparent"
}
```

- `ALPHA`: `straight` or `premultiplied`.
- `COMPOSITE`: `over`, `add`, `multiply`, `screen`, or `replace`.
- `QUEUE`: `opaque` or `transparent`. Transparent inputs sharing a consumer are drawn after opaque ones.

When you declare explicit `PIPELINE_STATE.BLEND`, the blend state wins over `COMPOSITE`.

## Layer shaders

`LAYER` lets a raw raster shader draw into private targets, then resolve into the consumer with a fullscreen resolve pass. This is useful for transparent effects, order-independent transparency approximations, depth-aware layers, and intermediate MRT composition.

```json
"LAYER": {
  "TARGETS": [
    { "NAME": "accum", "FORMAT": "rgba16f", "CLEAR": [0, 0, 0, 0], "COMPOSITE": "add" },
    { "NAME": "reveal", "FORMAT": "r16f", "CLEAR": [1, 0, 0, 0], "COMPOSITE": "multiply" }
  ],
  "DEPTH_TEST": true,
  "RESOLVE": { "OUTPUT": "isf_FragColor", "COMPOSITE": "over" }
}
```

In the fragment source, guard resolve-only code with `#if defined(ISF_RESOLVE_PASS)`. `LAYER_TEXEL(accum)` reads the accumulation target at the current resolve pixel. Keep the geometry-pass writes in the other branch. [[Shader cookbook]] explains the complete weighted-transparency corpus example, including revealage blend factors.

`RESOLVE.DEPTH_WRITE: true` enables resolve depth writing; `RESOLVE.DEPTH_INPUT` instead names a depth input available to the resolve shader. These two options are mutually exclusive. An explicit resolve block requires an `ISF_RESOLVE_PASS` section in the source.

Layer shaders use `SINGLE` execution and cannot also declare `OUTPUTS` or multiview. The parser accepts at most eight private targets, with matching fragment output names and locations; the backend may support fewer attachments or formats. `LAYER.TARGETS.BLEND` and `COMPOSITE` are alternative declarations, not settings to combine on one target.

## Execution models

Raw raster normally draws once per frame. `EXECUTION_MODEL` repeats the raster pass for specific targets.

```json
"EXECUTION_MODEL": { "TYPE": "PER_CUBE_FACE", "TARGET": "env" }
```

| Type | Description |
|---|---|
| `SINGLE` | Default: one draw. |
| `PER_MIP` | Draw once per mip level of `TARGET`; `PASSINDEX` is the mip. |
| `PER_CUBE_FACE` | Draw six cubemap faces in GL cube-map order. `TARGET` must be a cubemap output. |
| `PER_LAYER` | Draw once per texture-array layer. |
| `MANUAL` | Draw `COUNT` times; `COUNT` is an expression. |

`MULTIVIEW` can render several layers / views in a single draw when the backend supports it. It is commonly used with `CUBEMAP: true` and `MULTIVIEW: 6` for camera-array or IBL passes.

## Primitive data

`PRIMITIVE_DATA: true` exposes generated fragment data:

```json
"PRIMITIVE_DATA": true
```

The fragment shader receives:

```glsl
PRIMITIVE_ID   // primitive index
BARYCENTRIC    // triangle barycentric coordinate
```

The runtime expands indexed and strip meshes as needed so primitive IDs and barycentrics are stable.

## Clip, cull, and depth layout

Advanced depth / culling fields:

```json
{
  "CLIP_DISTANCES": 2,
  "CULL_DISTANCES": 1,
  "DEPTH_LAYOUT": "greater"
}
```

- `CLIP_DISTANCES`: declares `gl_ClipDistance[N]` for user clip planes.
- `CULL_DISTANCES`: declares `gl_CullDistance[N]` for per-primitive culling.
- `DEPTH_LAYOUT`: conservative-depth qualifier for `gl_FragDepth`: `any`, `greater`, `less`, or `unchanged`.

## Examples

### Textured mesh

```glsl
/*{
  "ISFVSN": "2.0",
  "MODE": "RAW_RASTER_PIPELINE",
  "VERTEX_INPUTS": [
    { "TYPE": "vec4", "NAME": "position" },
    { "TYPE": "vec2", "NAME": "texcoord" }
  ],
  "VERTEX_OUTPUTS": [ { "TYPE": "vec2", "NAME": "v_uv" } ],
  "FRAGMENT_INPUTS": [ { "TYPE": "vec2", "NAME": "v_uv" } ],
  "FRAGMENT_OUTPUTS": [ { "TYPE": "vec4", "NAME": "isf_FragColor" } ],
  "INPUTS": [ { "NAME": "tex", "TYPE": "image" } ]
}*/

void main() {
    isf_FragColor = IMG_NORM_PIXEL(tex, v_uv);
}
```

```glsl
void main() {
    isf_vertShaderInit();
    gl_Position = clipSpaceCorrMatrix * VIEWPROJECTION_MATRIX * MODEL_MATRIX * position;
    v_uv = texcoord;
    isf_vertShaderFinish();
}
```

### Procedural points

```json
{
  "MODE": "RAW_RASTER_PIPELINE",
  "VERTEX_INPUTS": [],
  "VERTEX_OUTPUTS": [ { "TYPE": "vec4", "NAME": "v_color" } ],
  "FRAGMENT_INPUTS": [ { "TYPE": "vec4", "NAME": "v_color" } ],
  "PIPELINE_STATE": { "TOPOLOGY": "points", "VERTEX_COUNT": 65536 }
}
```

In the vertex shader, use `gl_VertexIndex` to compute point positions.

### Cubemap output

```json
{
  "MODE": "RAW_RASTER_PIPELINE",
  "OUTPUTS": [
    { "NAME": "env", "TYPE": "color", "FORMAT": "rgba16f", "CUBEMAP": true, "GENERATE_MIPS": true, "WIDTH": 512, "HEIGHT": 512 }
  ],
  "MULTIVIEW": 6
}
```

Use `VIEW_INDEX` to select per-face camera data, or connect a Camera Array to the `Camera` inlet.

## Related Processes

- [[ISF Shaders]]: Fullscreen fragment shaders.
- [[Compute Shaders]]: Generate images, buffers, geometry, and indirect commands.
- [[Model Display]]: Built-in renderer for geometry.
- [[Vertex Shader Art]]: Procedural vertex-based visuals.
- [[Object Loader]]: Load mesh assets for rendering.
- [[Shader cookbook]]: Source-based recipes for scenes, cubemap faces, layers, primitive data and transparency.
