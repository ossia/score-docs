---
layout: default
title: Shader cookbook
description: "Small source-based recipes for ISF, CSF, raw raster and Vertex Shader Art"
parent: In depth
permalink: /in-depth/shader-cookbook.html
---

# Shader cookbook

These recipes use the [score graphics corpus](https://github.com/ossia/score/tree/master/tests/gfx/corpus) to explain shader features. See [[Graphics pipeline]] for coordinate, size and backend conventions.

Copy a fixture into your user library before modifying it. For raw raster, copy both files with the same stem (`.fs` and `.vs`). Connect image outputs to a video output to inspect them, or to [[Sink]] when only execution is needed. A CSF geometry output must go through a renderer before a texture output can display it.

## ISF: a fading feedback trail

Start with [isf-persistent-feedback.fs](https://github.com/ossia/score/blob/master/tests/gfx/corpus/isf-persistent-feedback.fs). Its two-pass header is:

```json
"PASSES": [
  { "TARGET": "trail", "PERSISTENT": true, "FLOAT": true },
  {}
]
```

In pass 0, sample `IMG_NORM_PIXEL(trail, isf_FragNormCoord)`, multiply it by the `decay` control, and add the moving dot. In pass 1, copy `trail` to `gl_FragColor`. Reading the persistent target while writing it accesses history; the later pass sees the newly written result. Reduce `decay` to shorten the trail. Keep initialization and alpha in mind when replacing the dot with your own signal.

For an older file, [isf-v1-persistent-buffers-accumulate.fs](https://github.com/ossia/score/blob/master/tests/gfx/corpus/isf-v1-persistent-buffers-accumulate.fs) demonstrates top-level `PERSISTENT_BUFFERS`. Current score upgrades this declaration to persistent passes; its names still have to match pass targets.

## ISF: two outputs and explicit alpha

[alpha-isf-mrt.fs](https://github.com/ossia/score/blob/master/tests/gfx/corpus/alpha-isf-mrt.fs) is a minimal multiple-render-target shader:

```glsl
/*{
  "ISFVSN": "2.0",
  "ALPHA": "straight",
  "OUTPUTS": [{"NAME": "out0"}, {"NAME": "out1"}]
}*/
void main() {
  out0 = vec4(1.0, 0.0, 0.0, 0.5);
  out1 = vec4(1.0, 0.0, 0.0, 0.5);
}
```

This version makes the corpus's straight-alpha intent explicit. Cable the two output ports separately; change `out1` to green to identify them. For premultiplied output, declare `ALPHA: "premultiplied"` and multiply RGB by alpha yourself (`vec4(0.5, 0, 0, 0.5)` for the red above). Do not multiply twice. `COMPOSITE: "over"` selects normal overlay composition; `replace` is useful when you want to inspect the output without overlaying a background. MRT requires enough supported color attachments and compatible formats and dimensions.

## ISF: see what a sampler does

Use [isf-sampler-filter-stripes.fs](https://github.com/ossia/score/blob/master/tests/gfx/corpus/isf-sampler-filter-stripes.fs) as a producer. Set the receiving texture inlet to 2 × 2 pixels, then sample at `vec2(0.4, 0.5)` in a consumer. The fixture places black on the left and red on the right: nearest sampling selects black, whereas linear sampling interpolates across the boundary.

Declare the consumer image with `"FILTER": "nearest"` or `"FILTER": "linear"`. Use `IMG_NORM_PIXEL(inputImage, vec2(0.4, 0.5))` rather than sampling at a texel center, where both filters can look identical. Wrapping is independent: `WRAP: "repeat"` repeats out-of-range UVs, while `clamp_to_edge` extends edge texels. Integer textures are not a portable substitute for this normalized-color experiment.

## CSF: paint an image safely

[guide-csf-image.cs](https://github.com/ossia/score/blob/master/tests/gfx/corpus/guide-csf-image.cs) declares a 64 × 64 writable image and an 8 × 8 workgroup with `EXECUTION_MODEL: {"TYPE": "2D_IMAGE"}`. The essential body is:

```glsl
ivec2 p = ivec2(gl_GlobalInvocationID.xy);
ivec2 size = imageSize(outputImage);
if (p.x >= size.x || p.y >= size.y) return;
float u = float(p.x) / float(size.x - 1);
IMG_STORE(outputImage, p, vec4(u, 0.25, 1.0 - u, 1.0));
```

Keep the bounds guard when changing dimensions: dispatches round up to whole workgroups. The denominator here assumes width greater than one. Image-store coordinates are top-down; `IMG_STORE` handles backend orientation. For several writable images, name the desired dispatch `TARGET` explicitly. Connect the output texture to a display. Compute support and the requested storage format must exist on the selected backend.

## CSF: generate and forward geometry

Pair [guide-csf-geometry.cs](https://github.com/ossia/score/blob/master/tests/gfx/corpus/guide-csf-geometry.cs) with [guide-rawraster-geo.fs](https://github.com/ossia/score/blob/master/tests/gfx/corpus/guide-rawraster-geo.fs) and its matching vertex file. The compute resource declares `VERTEX_COUNT: "3"`, `position` and `color` attributes, then dispatches `PER_VERTEX` against `geo`. Each invocation writes one corner and its color. Keep the guard against the attribute array length even though there are only three vertices.

Add `TOPOLOGY: "triangles"` to state the intended primitive explicitly, and select **Geometry** in the receiving Render Pipeline's **Mode** control. When adapting the resource to points or lines, change both its topology and the shader's interpretation of the vertex sequence. An explicit raster `PIPELINE_STATE.TOPOLOGY` wins over Mode.

[syn-copy-from.cs](https://github.com/ossia/score/blob/master/tests/gfx/corpus/syn-copy-from.cs) splits input and output resources: `geoOut` takes its count from `$VERTEX_COUNT_geoIn`; the shader copies positions but forwards color without shader writes:

```json
{ "NAME": "out_color", "SEMANTIC": "color", "TYPE": "vec4", "ACCESS": "none",
  "COPY_FROM": { "GEOMETRY": "geoIn", "ATTRIBUTE": "in_color" } }
```

`ATTRIBUTE` names the source declaration, not its semantic. Cable upstream geometry to `geoIn`, then cable `geoOut` to the renderer. Use this pattern to deform positions while retaining colors. Do not write a forwarded attribute through `ISF_WRITE`.

## CSF: indirect work with a bounded fallback

[syn-indirect-nocount.cs](https://github.com/ossia/score/blob/master/tests/gfx/corpus/syn-indirect-nocount.cs) is a compact three-stage example of indirect dispatch and drawing:

1. A one-workgroup `MANUAL` pass writes a `dispatch_args` storage buffer and zeroes all eight indirect draw slots.
2. An `INDIRECT` pass targeting that buffer fills the live command slots. Its `WORKGROUPS: [8, 1, 1]` also supplies a bounded fallback; `if (gl_WorkGroupID.x >= args.xyz[0]) return;` protects unused work.
3. A `PER_VERTEX` pass fills the geometry. Draw commands determine which strips are visible.

The geometry's `INDIRECT: {"COUNT": 8}` is capacity, not the number of valid commands this frame. Zero inactive commands on every update; stale commands can draw old geometry. The fixture intentionally omits `DRAW_COUNT`, illustrating why capacity-based fallbacks need this discipline. Native indirect execution is backend-dependent; do not infer native GPU-count support from a successful fallback render.

## CSF: turn audio into pixels

[csf-audio-before-image.cs](https://github.com/ossia/score/blob/master/tests/gfx/corpus/csf-audio-before-image.cs) declares an `audio` resource called `wave` followed by a writable `outputImage`. Connect an audio signal to the generated audio inlet. Inside its guarded image dispatch:

```glsl
float v = textureLod(wave, vec2(0.5, 0.5), 0.0).r;
IMG_STORE(outputImage, p, vec4(v, 0.0, 1.0, 1.0));
```

This samples one waveform location, not loudness or an FFT magnitude. For a waveform display, vary the horizontal coordinate across pixels; for spectrum data, declare `audioFFT` instead. The explicit LOD is appropriate in compute, where fragment derivatives are unavailable. Keep the audio resource in the header rather than declaring a conflicting sampler binding by hand.

## Raw raster: render a flattened scene

Use [guide-rawraster-scene.fs](https://github.com/ossia/score/blob/master/tests/gfx/corpus/guide-rawraster-scene.fs) and [its vertex shader](https://github.com/ossia/score/blob/master/tests/gfx/corpus/guide-rawraster-scene.vs). Feed flattened scene geometry with its auxiliary data to the Render Pipeline. The header requests `instance_draw_id` as a `uint draw_id` and the `per_draws` storage buffer. Its vertex transform is:

```glsl
isf_vertShaderInit();
mat4 model = per_draws.data[draw_id].model;
gl_Position = clipSpaceCorrMatrix * VIEWPROJECTION_MATRIX
            * model * vec4(position, 1.0);
isf_vertShaderFinish();
```

Copy the complete `PerDraw` layout from the fixture, including the fields after the matrices. On this path `MODEL_MATRIX` is identity: replacing `model` with it loses individual object placement. For a directly cabled mesh rather than a flattened scene, use the geometry-path recipe and `MODEL_MATRIX` instead. Keep the prologue first and epilogue last; do not add a separate backend Y flip.

## Raw raster: color cubemap faces and array layers

[rr-cube-faces-procedural.fs](https://github.com/ossia/score/blob/master/tests/gfx/corpus/rr-cube-faces-procedural.fs) needs no geometry input. Its vertex companion emits a fullscreen triangle; `PIPELINE_STATE.VERTEX_COUNT` is 3. The output declares `CUBEMAP: true`, `LAYERS: 6`, and a 32 × 32 size. `EXECUTION_MODEL: {"TYPE": "PER_CUBE_FACE", "TARGET": "faces"}` redraws it for each face, using `PASSINDEX` to choose red intensity.

Faces follow cube-map order: +X, −X, +Y, −Y, +Z, −Z. A normal window view is not proof that all faces were written: use a cubemap sampler or a face viewer. The fixture's direct window presentation selects +Z, whose red is `160 / 255`.

[rr-perlayer.fs](https://github.com/ossia/score/blob/master/tests/gfx/corpus/rr-perlayer.fs) uses the same idea with `LAYERS: 4` and `EXECUTION_MODEL: {"TYPE": "PER_LAYER", "TARGET": "layered"}`. Its fragment writes `vec4(l / 3.0, 1.0 - l / 3.0, 0.25, 1.0)` where `l = float(PASSINDEX)`. Sample an explicit array layer downstream; a 2D preview cannot show the whole array. Raw raster does not directly write true 3D texture volumes: use CSF for those.

## Raw raster: primitive IDs and barycentrics

[rr-primitive-data.fs](https://github.com/ossia/score/blob/master/tests/gfx/corpus/rr-primitive-data.fs) and its vertex companion emit two triangles. With `PRIMITIVE_DATA: true`, the fragment shader can write:

```glsl
isf_FragColor = vec4(float(PRIMITIVE_ID) * 0.5,
                    BARYCENTRIC.x, BARYCENTRIC.y, 1.0);
```

This encodes triangle identity in red and interpolation within the triangle in green and blue. Begin with this procedural six-vertex fixture before adapting the feature to shared-vertex mesh input; the supplied `rr-primitive-data-mesh.fs` counterpart covers that separate path. Primitive metadata is not a general geometry-shader stage.

## Raw raster: resolve transparent layers

[layer-oit-rg.fs](https://github.com/ossia/score/blob/master/tests/gfx/corpus/layer-oit-rg.fs) is a weighted blended transparency example, not exact depth sorting. Copy its vertex companion too. It draws two premultiplied quads into private `LAYER.TARGETS`: additive `rgba16f` accumulation and an `r16f` revealage target cleared to one. The main pass weights colors by depth nearness. A second code path resolves the targets:

```glsl
#if defined(ISF_RESOLVE_PASS)
void main() {
  vec4 a = LAYER_TEXEL(accum);
  float coverage = 1.0 - LAYER_TEXEL(reveal).r;
  isf_FragColor = vec4(a.rgb / max(a.a, 1e-5) * coverage, coverage);
}
#endif
```

Use the complete fixture for the target blend states and non-resolve branch. Compare with `layer-oit-gr.fs`, which reverses the draw order. Weighted transparency approximates overlapping surfaces; it does not reconstruct exact sorted colors. For a simpler overlay, `layer-quads-layer.fs` uses one private layer rather than accumulation/revealage.

Current headers use `QUEUE` and `LAYER`, **not the historical `TRANSPARENCY` block**. Layer targets are private, unlike public `OUTPUTS`. Current parser constraints include single-invocation execution, no `OUTPUTS`, no multiview, at most eight targets, and one-to-one matching fragment outputs. Hardware limits may be lower. See [[Render Pipeline]] for resolve depth and composition settings.

## VSA: a three-vertex starting point

[vsa-triangle.vs](https://github.com/ossia/score/blob/master/tests/gfx/corpus/vsa-triangle.vs) declares `MODE: "VERTEX_SHADER_ART"`, `POINT_COUNT: 3` and `PRIMITIVE_MODE: "TRIANGLES"`. Its body is simply:

```glsl
void main() {
  vec2 p;
  if (vertexId < 0.5) p = vec2(-1.5, -1.5);
  else if (vertexId < 1.5) p = vec2(1.5, -1.5);
  else p = vec2(0.0, 1.5);
  gl_Position = vec4(p, 0.0, 1.0);
  v_color = vec4(0.9, 0.4, 0.1, 1.0);
}
```

Start here to check winding and visibility before importing a large point animation. VSA generates vertices and supplies a fixed fragment stage; it is not a replacement for a custom raster material. The runtime adapts VSA depth conventions to the backend, so do not add raw-raster initialization/finish calls. See [[Vertex Shader Art]] for time, resolution and audio inputs.
