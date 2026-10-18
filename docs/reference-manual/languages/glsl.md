---
layout: default
title: GLSL runtime reference
parent: Languages
grand_parent: Reference
permalink: /reference/languages/glsl.html
---

# GLSL runtime reference

GLSL is the language used for score's GPU shader bodies. **Author Vulkan-compatible GLSL, not a legacy OpenGL program.** score combines your body with declarations generated from a JSON header and compiles shaders for its Qt RHI graphics backend. Running on OpenGL does not make OpenGL-only source portable to Vulkan, Metal or Direct3D.

## Choose the shader contract

| Reference | Execution and interface |
|---|---|
| [ISF]({{ site.baseurl }}/reference/languages/isf.html) | Fullscreen fragment shader; header controls, image/audio inputs, passes and outputs. Includes an explicit standard-versus-score extension boundary. |
| [CSF]({{ site.baseurl }}/reference/languages/csf.html) | score compute format: dispatches, storage images, structured buffers and geometry. |
| [Raw raster]({{ site.baseurl }}/reference/languages/raw-raster.html) | score vertex/fragment pipeline: attributes, varyings, camera data, raster state and attachments. |
| [Vertex Shader Art]({{ site.baseurl }}/reference/languages/vertex-shader-art.html) | Procedural vertex shader with a supplied fragment stage and VSA compatibility variables. |
| [Geometry filter]({{ site.baseurl }}/reference/languages/geometry-filter.html) | `process_vertex` callback with mutable attributes, composed into a renderer's vertex shader. |

These are not interchangeable GLSL profiles. Their headers describe what score must allocate and bind. Process setup belongs to [[ISF Shaders]], [[Compute Shaders]], [[Render Pipeline]] and [[Vertex Shader Art]]; [[Graphics pipeline]] explains the graph, and [[Shader cookbook]] gives worked recipes.

## Core language

The authoritative language definition is the [Khronos GLSL specification](https://registry.khronos.org/OpenGL/specs/gl/GLSLangSpec.4.60.pdf), with the [Vulkan GLSL rules](https://github.com/KhronosGroup/GLSL/blob/main/extensions/khr/GL_KHR_vulkan_glsl.txt) describing its Vulkan environment. These define language features, not a promise that every score backend exposes them.

A shader entry point is `void main()`. Helpers are ordinary typed functions. Scalar types include `float`, `int`, `uint` and `bool`; vectors include `vec2`–`vec4`, `ivec*`, `uvec*` and `bvec*`; matrices include `mat3` and `mat4`. Use constructors for conversion (`float(i)`, `vec4(rgb, 1.0)`) and swizzles for components (`position.xyz`, `color.rgb`). A matrix multiplied by a vector transforms that vector; order matters, so `projection * view * model * position` is not interchangeable with its reverse.

Arithmetic, `if`/`else`, bounded `for` loops, arrays, structs and functions work as in GLSL, not JavaScript. There are no dynamically growing arrays, strings, host objects or file I/O. `sin`, `cos`, `length`, `dot`, `normalize`, `mix`, `clamp`, `step` and `smoothstep` are built-ins. Avoid undefined numerical cases: normalize only nonzero vectors, guard divisors and indices, and pass increasing edges to `smoothstep`. For a reversed ramp, use `1.0 - smoothstep(low, high, value)`.

```glsl
// A helper that can be used in a shader body; no resource declarations needed.
vec3 adjustContrast(vec3 rgb, float amount) {
    return (rgb - vec3(0.5)) * amount + vec3(0.5);
}
```

`const` expresses an immutable value. `uniform` data is supplied by the host, not written by the shader. Vertex/fragment `in` and `out` values form stage interfaces; compute invocations instead read and write declared resources. Stage-specific built-ins are not available everywhere: derivatives such as `dFdx` and `dFdy` belong to fragment shading, not compute.

## Vulkan-compatible source and generated declarations

[Qt Shader Tools](https://doc.qt.io/qt-6/qtshadertools-qsb.html) accepts Vulkan-style GLSL, compiles to SPIR-V and can translate it to backend languages. Its standalone examples explicitly declare `#version`, locations, uniform blocks and sampler bindings. **Those standalone declarations are not a template to paste around a score shader.** score's current shader generator supplies a GLSL 460 prelude and the declarations required by the selected format.

| Author supplies | score supplies |
|---|---|
| JSON metadata, named controls/resources and their types | Uniform blocks, samplers, images and buffers corresponding to the header |
| Shader functions and `main()` | Runtime uniforms and family-specific helper macros |
| Raw-raster `VERTEX_INPUTS`, `VERTEX_OUTPUTS`, `FRAGMENT_INPUTS`, `FRAGMENT_OUTPUTS` | Stage declarations and locations (or the requested explicit locations) |
| CSF `LOCAL_SIZE` and execution model | Compute workgroup declaration and runtime dispatch |

Do not declare `uniform float gain;` after declaring `gain` as a header control, or manually bind a sampler already described by `INPUTS`. Do not duplicate the generated output or stage interface. Use the header `EXTENSIONS` field where supported to request extensions; a request cannot add a missing backend capability.

The generator uses bindings 0 and 1 for renderer/process uniform data. Graphics shaders normally use binding 2 for material controls and allocate resource bindings thereafter; compute allocation also depends on whether a control block exists. These are implementation details, **not a stable binding-number API**. Persistent resources, auxiliary data and additional images can consume bindings. Address resources by their header names and the documented macros, not by guessed descriptor numbers. [Current generator source](https://github.com/ossia/score/blob/master/src/plugins/score-plugin-gfx/3rdparty/libisf/src/isf.cpp) is useful when diagnosing generated-source errors.

Important Vulkan differences:

- Non-opaque uniforms must be in blocks; score generates these blocks from controls. Legacy loose-uniform snippets are not directly portable.
- Use modern texture functions (`texture`, `textureLod`, `texelFetch`) where direct sampling is appropriate; use score's `IMG_*` helpers for portable image orientation. `texture2D` is not Vulkan GLSL.
- Use `gl_VertexIndex` / `gl_InstanceIndex` in raw raster, not the OpenGL `gl_VertexID` / `gl_InstanceID`. VSA exposes its own `vertexId` compatibility variable.
- Fragment outputs are explicit. score accepts and rewrites `gl_FragColor` for ISF compatibility; new single-output ISF code can write `isf_FragColor`. Multiple outputs use header-declared names.
- Fixed-function OpenGL matrices, `glBegin`-style drawing and compatibility attributes are not the score shader interface. Use raw-raster attributes and camera macros.

## Coordinates and stage conventions

Texture coordinates, framebuffer origins and clip coordinates are separate concerns. Do not fix a flipped result by adding an unconditional Y flip everywhere.

- **ISF fragments:** `isf_FragNormCoord` is the current normalized coordinate. `IMG_NORM_PIXEL` takes normalized coordinates; `IMG_PIXEL` takes pixel coordinates; `IMG_TEXEL` takes integer texel coordinates. `IMG_THIS_*` samples at the current fragment. These helpers account for runtime texture orientation. See the [full macro table]({{ site.baseurl }}/reference/languages/isf.html#texture-macros).
- **Compute images:** derive integer coordinates from `gl_GlobalInvocationID`, bounds-check against the resource size, then use `IMG_LOAD`, `IMG_STORE` or `IMG_STORE_LAYER`. These implement score's image-origin convention; raw `imageLoad`/`imageStore` do not apply its fixups. The [image contract]({{ site.baseurl }}/reference/languages/csf.html#images) covers dimensionality and access.
- **Raw-raster vertices:** start `main()` with `isf_vertShaderInit()` and end with `isf_vertShaderFinish()`. Compute clip position with `clipSpaceCorrMatrix * VIEWPROJECTION_MATRIX * MODEL_MATRIX * position` for directly cabled geometry. The matrix and finish helper have complementary backend duties; do not call the helper twice or add another backend Y flip. Flattened scenes instead use [per-draw transforms]({{ site.baseurl }}/reference/languages/raw-raster.html#scene-path).
- **VSA:** write the original OpenGL-style clip-space position; score maps the depth convention. Do not add raw-raster init/finish calls or a second depth correction.

For texture lookup outside fragment shading, choose an explicit LOD where required, as in the cookbook's compute audio recipe. Implicit fragment derivatives are not available to a compute invocation. Sampler filtering, wrapping and mip generation are separate choices described in the resource header.

## Buffers, images and parallel execution

A sampled texture is read through a sampler; a storage image is accessed with image load/store operations and must have a compatible format and access mode. An SSBO carries structured data, not an image. score's `storage` layouts use `std430`; `uniform` buffers use `std140`. Preserve the complete declared layout when consuming upstream buffers: a `vec3` or an array does not imply tightly packed host bytes. See [CSF storage buffers]({{ site.baseurl }}/reference/languages/csf.html#storage-buffers) and [custom types]({{ site.baseurl }}/reference/languages/csf.html#custom-types).

Each compute invocation runs independently. Workgroup counts round up, so a valid dispatch can contain invocations outside the intended image or array range. Guard accesses even for a minimal example. A workgroup `barrier()` is not a global synchronization point between all workgroups; do not use it to coordinate an entire simulation. Do not let some invocations skip a barrier that others in the same workgroup must reach. Prefer separate passes or the documented persistent/snapshot resource model for cross-pass and previous-frame dependencies. Geometry `gather` access provides separate read/write snapshots for neighbour reads; it does not make arbitrary in-place races safe.

## Portability and debugging

A shader can parse and still fail to render because an attachment format, compute feature, sample count, blend mode or resource limit is unsupported. Integer storage formats additionally require Qt 6.10 or newer in score; older fallback to RGBA8 does not retain integer semantics. Check [[Graphics pipeline]] for runtime limits.

When adapting a shader, first establish a constant color or minimal geometry result, then add one resource at a time. Check header names, resource access, matching vertex/fragment varyings, output sizes and array bounds before changing coordinate math. Preserve the family's initialization and finalization conventions. A successful render on one backend is not proof of portability to the others. Use the small corpus-linked [[Shader cookbook]] recipes to isolate the stage you are working on.

## Authoritative references

- [Khronos GLSL 4.60 specification](https://registry.khronos.org/OpenGL/specs/gl/GLSLangSpec.4.60.pdf): types, expressions, stage interfaces, built-ins and memory rules.
- [Khronos Vulkan GLSL semantics](https://github.com/KhronosGroup/GLSL/blob/main/extensions/khr/GL_KHR_vulkan_glsl.txt): differences from OpenGL GLSL.
- [Qt Shader Tools QSB manual](https://doc.qt.io/qt-6/qtshadertools-qsb.html): Vulkan-style input, SPIR-V and target translation.
- [Qt RHI overview](https://doc.qt.io/qt-6/qrhi.html): graphics backend abstraction and capabilities.
- [ISF JSON](https://docs.isf.video/ref_json.html) and [ISF GLSL](https://docs.isf.video/ref_glsl.html): portable ISF declarations and functions, distinct from score extensions.
