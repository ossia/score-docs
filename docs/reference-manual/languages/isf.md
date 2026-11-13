---
layout: default
title: ISF language reference
parent: Languages
grand_parent: Reference
nav_order: 21
permalink: /reference/languages/isf.html
---

# ISF language reference

This is the canonical shader contract for the [[ISF Shaders]] process. For GLSL syntax, generated declarations and portability, see [GLSL runtime reference]({{ site.baseurl }}/reference/languages/glsl.html). For worked tasks, see [[Shader cookbook]].

## Standard ISF and score extensions

[Interactive Shader Format](https://isf.video) combines GLSL with a JSON description. The upstream [JSON reference](https://docs.isf.video/ref_json.html) and [GLSL reference](https://docs.isf.video/ref_functions.html) define the portable ISF interface; the tables below describe score's runtime, including extensions.

The standard input vocabulary is `event`, `bool`, `long`, `float`, `point2D`, `color`, `image`, `audio`, and `audioFFT`. Standard multipass declarations include `TARGET`, `PERSISTENT`, `FLOAT`, `WIDTH`, and `HEIGHT`. Standard shader variables include `TIME`, `TIMEDELTA`, `DATE`, `FRAMEINDEX`, `PASSINDEX`, `RENDERSIZE`, and `isf_FragNormCoord`; the pixel/normalized image sampling helpers are part of ISF.

Do not assume another ISF host supports score's `point3D`, `audioHistogram`, cubemaps, volume inputs, depth companions, explicit sampler-state fields, `OUTPUTS`, `ALPHA`, `COMPOSITE`, or the additional pass fields `LAYER`, `FORMAT`, and `PIPELINE_STATE`. Likewise, `PROGRESS`, `SAMPLERATE`, `isf_FragCoord`, `clipSpaceCorrMatrix`, `MSAA_SAMPLES`, `IMG_TEXEL`, `TEX_DIMENSIONS`, and `IMG_CUBE` are score runtime conveniences rather than a portable ISF baseline. `MODE` selects score shader families; [CSF]({{ site.baseurl }}/reference/languages/csf.html), [raw raster]({{ site.baseurl }}/reference/languages/raw-raster.html), and [VSA integration]({{ site.baseurl }}/reference/languages/vertex-shader-art.html) are not standard ISF rendering modes.

Header names become generated shader declarations. Use valid, distinct GLSL identifiers and do not redeclare generated uniforms, samplers or outputs in the body. Compatibility acceptance of `gl_FragColor` is score preprocessing, not Vulkan GLSL syntax.

## JSON header

The header is a JSON object in a block comment, `/*{ ... }*/`.

```glsl
/*{
  "ISFVSN": "2",
  "DESCRIPTION": "Brightness filter",
  "CATEGORIES": ["Color", "Filter"],
  "INPUTS": [
    { "NAME": "inputImage", "TYPE": "image" },
    { "NAME": "brightness", "TYPE": "float", "DEFAULT": 1.0, "MIN": 0.0, "MAX": 2.0 }
  ]
}*/
```

### Header syntax

These rules apply to every shader family: ISF, [CSF]({{ site.baseurl }}/reference/languages/csf.html), [raw raster]({{ site.baseurl }}/reference/languages/raw-raster.html), [Vertex Shader Art]({{ site.baseurl }}/reference/languages/vertex-shader-art.html) and geometry filters.

- **Position.** The header is the first block comment whose content is a JSON object, so a licence or comment block may come before it. Of the comments that start with `{`, the first one that parses is the header; when none parses, the error of the first one is reported.
- **Comments and trailing commas.** `//` line comments and trailing commas before `}` or `]` are accepted in the header. Error lines and columns point into the source as written.
- **Case.** Keys are case-independent at every level (`"inputs"`, `"Name"`, `"pipeline_state"`...), as are `TYPE` values and keyword values such as `ACCESS`, `BUFFER_USAGE`, `VISIBILITY`, `FORMAT` and `MODE`.
- **Family.** The library and the file explorer read a file's family (its `MODE`) from the header only: a mode named in a comment or a string of the shader body does not change it.
- **Unknown types.** An `INPUTS` or `RESOURCES` entry whose `TYPE` the parser does not know, or whose `TYPE` is not a string, is an error naming the entry and listing the known types.
- **Messages.** An error about an entry is prefixed with the entry, e.g. `INPUTS[2] "gain": ...`; a blend error names the block it is in (`BLEND`, `BLEND_PER_ATTACHMENT[1]`...). Warnings are shown in the shader's editor and printed on the console.

### Input names

Each input name becomes a GLSL identifier in the generated code. A header is refused, with the name of the input, when an input name:

- is a GLSL keyword, reserved word or type name (`layout`, `buffer`, `filter`, `input`, `output`, `half`, `vec4`, `sampler2D`...);
- starts with `gl_`, `isf_`, `ISF_` or `IMG_`, or contains two consecutive underscores;
- is a built-in name of the generated code: `TIME`, `TIMEDELTA`, `PROGRESS`, `SAMPLERATE`, `PASSINDEX`, `FRAMEINDEX`, `RENDERSIZE`, `DATE`, `MSAA_SAMPLES`, `NUM_VIEWS`, `VIEW_INDEX`, `LAYER_INDEX`, the camera matrices, `PRIMITIVE_ID`, `BARYCENTRIC`, `TEX_DIMENSIONS*`, `LAYER_TEXEL` or `main`;
- is used by another input, or by a control the engine adds to that shader family.

Names are never renamed: rename the input in the header and in the code.

### Common fields

| Field | Description |
|---|---|
| `ISFVSN` | ISF version. Use `"2"`. |
| `DESCRIPTION` | Description shown in browsers and inspectors. |
| `CREDIT` | Author credit. |
| `CATEGORIES` | Library categories. |
| `INPUTS` | UI controls, texture inputs, audio textures, buffers, and uniforms. |
| `PASSES` | Multipass render plan. |
| `OUTPUTS` | Explicit output textures: multiple color outputs, depth, layers, formats, MSAA. |
| `PIPELINE_STATE` | Raster state of every pass; a pass's own `PIPELINE_STATE` overrides it field by field. See [Depth](#depth). |
| `ALPHA` | Output alpha convention: `"straight"` or `"premultiplied"`. |
| `COMPOSITE` | Default composition mode: `"over"`, `"add"`, `"multiply"`, `"screen"`, `"replace"`. |
| `EXTENSIONS` | Array of GLSL extension names to require, such as `"GL_KHR_shader_subgroup_basic"`. An entry that is not an extension name is an error; a duplicate, or an extension the generated stage already requires, is required once. |

If `MODE` is omitted, the file is treated as an ISF shader. `MODE` is reserved for other shader families such as CSF and raw raster.

## Scalar input types

Scalar inputs create UI controls and uniforms with the same name.

| ISF type | GLSL type | Typical fields |
|---|---|---|
| `float` | `float` | `DEFAULT`, `MIN`, `MAX` |
| `bool` | `bool` | `DEFAULT` (`true` / `false`, or a number: non-zero is `true`) |
| `event` | `bool` for one frame | none |
| `long` | `int` | `VALUES`, `LABELS`, `DEFAULT`, or `MIN`, `MAX`, `DEFAULT` |
| `point2D` | `vec2` | `DEFAULT`, `MIN`, `MAX` |
| `point3D` | `vec3` | `DEFAULT`, `MIN`, `MAX` |
| `color` | `vec4` | `DEFAULT`, `MIN`, `MAX` |

An `event` input fires for one rendered frame on `true` or an ossia impulse. Connect a trigger/message cable to it when an effect needs a reset or one-shot action; unlike a `bool`, it is not a latched switch.

A `long` with `VALUES` is a combo box over those values, named by `LABELS` when there are as many labels as values. A `long` without `VALUES` is an integer spin box over the bounds it gives (`MIN`, `MAX`, either or both; the integer range on a side it does not give), starting at `DEFAULT`.

The rendered output starts from the values the controls show, including before the first values arrive from the execution engine, for example in previews.

Example:

```json
"INPUTS": [
  { "NAME": "gain", "TYPE": "float", "DEFAULT": 1.0, "MIN": 0.0, "MAX": 4.0 },
  { "NAME": "mode", "TYPE": "long", "VALUES": [0, 1], "LABELS": ["Normal", "Invert"], "DEFAULT": 0 },
  { "NAME": "tint", "TYPE": "color", "DEFAULT": [1, 0.8, 0.4, 1] }
]
```

## Texture inputs

### 2D image

```json
{ "NAME": "inputImage", "TYPE": "image" }
```

Use the ISF sampling macros:

```glsl
vec4 c = IMG_THIS_NORM_PIXEL(inputImage);
```

The `IMG_*` macros read an image the same way up on every backend, `v = 0` at the bottom. A raw `texture()` or `texelFetch()` on an image input reads the texture in the backend's own row order, which differs between Vulkan and the other backends: read image inputs through the [texture macros](#texture-macros).

An `image` input that declares `ACCESS` or `FORMAT` is a storage image, read with `IMG_LOAD(name, pixel)` or `imageLoad(name, ivec2 pixel)`. Sampling it (`IMG_NORM_PIXEL`, `texture()`, `texelFetch()`...) is refused with a message naming the input; to sample the image instead, remove `ACCESS` and `FORMAT` from its entry.

### 3D image / volume

```json
{ "NAME": "volume", "TYPE": "image", "DIMENSIONS": 3 }
```

3D inputs are GLSL `sampler3D` values. Sample them with `texture(volume, vec3(u, v, w))`.

### Cubemap

```json
{ "NAME": "environment", "TYPE": "cubemap" }
```

Cubemaps are GLSL `samplerCube` values. Sample with `texture(environment, dir)` or `IMG_CUBE(environment, dir)`.

### Sampleable depth

An `image` or `cubemap` input marked `"IS_DEPTH": true` also binds the depth of what its producer renders, as a `<name>_depth` sampler next to the color sampler:

```json
{ "NAME": "scene", "TYPE": "image", "IS_DEPTH": true }
```

```glsl
float d  = IMG_THIS_DEPTH(scene);              // depth at this fragment
float d2 = IMG_DEPTH_NORM_PIXEL(scene, uv);    // at a normalized coordinate
float d3 = IMG_DEPTH_PIXEL(scene, pixel);      // at a pixel of the depth texture
float dc = IMG_CUBE_DEPTH(environment, dir);   // depth of a cubemap input
```

`DEPTH` is not a depth flag: on a texture it is the depth of a volume. A volume (`DIMENSIONS: 3`) has no depth attachment, so `IS_DEPTH` on one is refused. The producer must declare that it writes depth, see [Depth](#depth).

### Sampler state

Texture inputs can declare sampler state directly on the input object:

```json
{
  "NAME": "tex",
  "TYPE": "image",
  "FILTER": "nearest",
  "WRAP": "clamp_to_edge",
  "MIPMAP_MODE": "linear"
}
```

The sampler fields are `WRAP`, `WRAP_S`, `WRAP_T`, `WRAP_R`, `FILTER`, `MIN_FILTER`, `MAG_FILTER`, `MIPMAP_MODE` and `COMPARE`. `ANISOTROPY`, `BORDER_COLOR`, `LOD_BIAS`, `MIN_LOD`, `MAX_LOD` and the `mirror_once` wrap mode are accepted but have no effect, as the renderer has no such sampler setting; each one set produces a warning naming the input and the key.

Each sampler field — filter, address mode, mipmaps — is resolved on its own:

1. the value set on the texture inlet in the inspector, when the user set one;
2. otherwise the value the shader's JSON declares;
3. otherwise the default: linear filtering, clamp to edge, no mipmaps.

`COMPARE` always comes from the shader: the inlet of a comparison sampler shows its Filter, Address mode and Mipmaps rows disabled. The first entry of each row leaves the field unset and is named after what it resolves to, for example **Shader: Nearest** or **Default: Linear**; see [[ISF Shaders]].

A mipmap mode other than none, from the inlet or from `MIPMAP_MODE`, also gives the input a mip chain, generated from what the upstream process renders. A `cubemap` input whose mipmap mode is left unset follows the texture bound to it: linear mipmapping when that texture has mip levels, none otherwise.

Audio inputs only use `FILTER` and `WRAP`.

### Pointer inputs

A shader can read the mouse and the touch history of a [[Window device]] through ordinary inputs. When the score has a window device, these inputs are bound to its addresses by default; the address shows on the inlet, where it can be changed or replaced by a cable:

| Input | Bound to |
|---|---|
| `point2D` named `iMouse` | `cursor/absolute`: window pixels. |
| `point2D` whose name contains `mouse` (any case) | `cursor/gl`: `[0, 1]`, y up. In a [Vertex Shader Art]({{ site.baseurl }}/reference/languages/vertex-shader-art.html#mouse-and-touch) shader, `mouse` is bound to `cursor/clip` instead. |
| 2D `image` named `touch` | `touch/history`, read through a 32 × 240 RGBA32F target, nearest filtering, clamp to edge. |

The touch history is the [vertexshaderart.com](https://www.vertexshaderart.com) `touch` texture, described in the [VSA reference]({{ site.baseurl }}/reference/languages/vertex-shader-art.html#mouse-and-touch). It stores time in alpha: an ISF reads it with `IMG_NORM_PIXEL_PREMULTIPLIED` / `IMG_PIXEL_PREMULTIPLIED`, since `IMG_NORM_PIXEL` divides by alpha (see [Texture macros](#texture-macros)).

```json
"INPUTS": [
  { "NAME": "mouse", "TYPE": "point2D" },
  { "NAME": "touch", "TYPE": "image" }
]
```

```glsl
// Pointer 0 (mouse or first finger) this frame: x, y in clip space, pressure, time.
vec4 newest = IMG_NORM_PIXEL_PREMULTIPLIED(touch, vec2(0.5 / 32.0, 0.5 / 240.0));
```

## Audio textures

ISF audio inputs create GPU textures from audio data:

```json
{ "NAME": "wave", "TYPE": "audio", "MAX": 512, "FILTER": "nearest" }
{ "NAME": "fft", "TYPE": "audioFFT", "MAX": 512 }
{ "NAME": "hist", "TYPE": "audioHistogram", "MAX": 512 }
```

`MAX` caps the texture width: a waveform is resampled linearly to `MAX` samples per channel, and an FFT or histogram row averages its bins into `MAX` columns. A row narrower than `MAX` keeps its own width.

Use `FILTER: "nearest"` when FFT bin accuracy matters.

## Texture macros

Use the helpers instead of raw `gl_FragCoord` coordinate math. They keep orientation correct across OpenGL, Vulkan, Metal, and Direct3D.

| Macro | Description |
|---|---|
| `IMG_PIXEL(tex, coord)` | Sample at a pixel coordinate of `tex` itself: `coord / IMG_SIZE(tex)`. |
| `IMG_NORM_PIXEL(tex, coord)` | Sample at normalized `[0, 1]` coordinate. |
| `IMG_THIS_PIXEL(tex)` | `IMG_PIXEL(tex, isf_FragCoord.xy)`: pixel-aligned, so an input of another size than the output is not stretched. |
| `IMG_THIS_NORM_PIXEL(tex)` | Sample at this fragment's normalized coordinate: the input is stretched over the output. |
| `IMG_NORM_PIXEL_LOD(tex, coord, lod)` | `IMG_NORM_PIXEL` at an explicit mip level. |
| `IMG_TEXEL(tex, coord)` | Texel fetch at integer coordinate. |
| `IMG_SIZE(tex)` / `TEX_DIMENSIONS(tex)` | Texture size in pixels. |
| `IMG_CUBE(tex, dir)` | Cubemap sample. |
| `IMG_THIS_DEPTH`, `IMG_DEPTH_PIXEL`, `IMG_DEPTH_NORM_PIXEL`, `IMG_CUBE_DEPTH` | Depth of an `IS_DEPTH` input, see [Sampleable depth](#sampleable-depth). |

Textures coming from other nodes' render targets are premultiplied. On a 2D `image` input, `IMG_PIXEL`, `IMG_NORM_PIXEL`, `IMG_THIS_PIXEL`, `IMG_THIS_NORM_PIXEL` and `IMG_TEXEL` return straight color: they divide by alpha, and return `vec4(0)` where alpha is 0. Append `_PREMULTIPLIED` (`IMG_NORM_PIXEL_PREMULTIPLIED`, `IMG_PIXEL_PREMULTIPLIED`, `IMG_THIS_PIXEL_PREMULTIPLIED`, `IMG_THIS_NORM_PIXEL_PREMULTIPLIED`, `IMG_TEXEL_PREMULTIPLIED`) to read the stored values as they are, for example when alpha holds data rather than coverage.

## Built-in uniforms

| Uniform | Type | Description |
|---|---|---|
| `TIME` | `float` | Playback time in seconds. |
| `TIMEDELTA` | `float` | Time since previous frame. |
| `PROGRESS` | `float` | Timeline progress from 0 to 1. |
| `FRAMEINDEX` | `int` | Frame counter. |
| `PASSINDEX` | `int` | Current pass index. |
| `RENDERSIZE` | `vec2` | Current render target size. |
| `DATE` | `vec4` | `(year, month, day, seconds)`. |
| `SAMPLERATE` | `float` | Audio sample rate. |
| `isf_FragNormCoord` | `vec2` | Current normalized fragment coordinate. |
| `isf_FragCoord` | `vec4` | Platform-corrected fragment coordinate. |
| `clipSpaceCorrMatrix` | `mat4` | Clip-space correction matrix for custom vertex shaders. |
| `MSAA_SAMPLES` | `int` | Sample count of the render target the pass draws into. |

`DATE` and `SAMPLERATE` (the audio engine's sample rate) are set in every shader family, single-pass ISF included.

## Outputs

Without an `OUTPUTS` array, an ISF shader writes one color output named `isf_FragColor`.

```glsl
void main() {
    isf_FragColor = vec4(1.0, 0.0, 0.0, 1.0);
}
```

`gl_FragColor` is accepted for compatibility and rewritten to `isf_FragColor`.

### Multiple render targets

```json
"OUTPUTS": [
  { "NAME": "color", "TYPE": "color" },
  { "NAME": "luma", "TYPE": "color", "FORMAT": "r16f" },
  { "NAME": "depth", "TYPE": "depth", "FORMAT": "d32f" }
]
```

Color outputs become `layout(location = N) out vec4 name;`. A depth output is written through `gl_FragDepth`, and only with the depth state of [Depth](#depth) declared.

### Output fields

| Field | Description |
|---|---|
| `NAME` | Output name. |
| `TYPE` | `"color"` or `"depth"`. Defaults to `"color"`. |
| `FORMAT` | Texture format such as `rgba8`, `rgba16f`, `rgba32f`, `r32f`, `d32f`. |
| `WIDTH`, `HEIGHT` | Fixed size or expression, see [Size expressions](#size-expressions). |
| `LAYERS` | Texture array layer count. |
| `SAMPLES` | MSAA sample count. |
| `ALPHA` | Per-output alpha convention. |
| `COMPOSITE` | Per-output compositing mode. |

All color outputs in one pass share the render target size. A classic ISF draws 2D (or layered) outputs: an output with `DEPTH` greater than 1, `CUBEMAP` or `GENERATE_MIPS` is refused. Use a [raw raster]({{ site.baseurl }}/reference/languages/raw-raster.html#fragment-outputs-and-render-targets) shader for cubemap and mipmapped outputs, and a [CSF]({{ site.baseurl }}/reference/languages/csf.html#3d-image) for volumes.

## Multipass rendering

`PASSES` defines intermediate passes and feedback buffers.

```json
"PASSES": [
  { "TARGET": "feedback", "PERSISTENT": true, "FLOAT": true },
  {}
]
```

| Pass field | Description |
|---|---|
| `TARGET` | Intermediate output to render. Missing target means final output. |
| `PERSISTENT` | Preserve the target across frames. |
| `FLOAT` | Use floating-point storage (`rgba32f`). |
| `FILTER` | `"nearest"` (any case) for nearest sampling. |
| `WIDTH`, `HEIGHT` | Fixed size or expression. |
| `LAYER` | Render into a texture-array layer. |
| `FORMAT` | Per-pass format: `rgba8`, `rgba16f`, `rgba32f`, `r8`, `r16f` or `r32f`; it takes precedence over `FLOAT`. Another value falls back to `rgba8` with a warning. |
| `PIPELINE_STATE` | Per-pass raster state, overriding the top-level `PIPELINE_STATE` field by field. |

A pass targeting a 3D output or declaring `Z` is refused: write volumes with a [CSF]({{ site.baseurl }}/reference/languages/csf.html#3d-image). A classic ISF always draws its fullscreen quad: `VERTEX_COUNT` and `INSTANCE_COUNT` in a `PIPELINE_STATE`, top-level or per pass, are refused. Use a [raw raster]({{ site.baseurl }}/reference/languages/raw-raster.html#draw-counts) or [Vertex Shader Art]({{ site.baseurl }}/reference/languages/vertex-shader-art.html) shader to choose the draw counts.

ISF v1 `PERSISTENT_BUFFERS` are converted to persistent passes internally. The legacy field accepts an array of target names or an object mapping names to `WIDTH`, `HEIGHT` and `FLOAT` settings. Each name must match a pass's `TARGET`; an unmatched name is ignored with a diagnostic. Prefer `PERSISTENT: true` on the pass in new shaders.

Use `PASSINDEX` to branch between pass code paths.

### The last pass

The last pass draws straight into the destination, the render target of the node it is connected to, unless one of these gives it a target of its own:

- it is `PERSISTENT`;
- its `WIDTH` / `HEIGHT` resolve to another size than the destination's;
- its `FORMAT` is single-channel (`r8`, `r16f`, `r32f`) and differs from the destination's.

Such a target is then copied into the destination. `FLOAT`, a four-channel `FORMAT` and `FILTER` do not create a target: at the destination's size, one draw gives the same pixels either way. The same rules apply to a single-pass shader. A shader with `OUTPUTS` sizes its outputs itself.

## Depth

A shader that writes `gl_FragDepth`, or that declares a `depth` output, declares its depth state in the `PIPELINE_STATE` of its last pass (top-level, or that pass's own):

```json
"PIPELINE_STATE": { "DEPTH_TEST": true, "DEPTH_WRITE": true, "DEPTH_COMPARE": "always" }
```

Without `DEPTH_TEST` and `DEPTH_WRITE`, the depth test of the fullscreen quad stays off and Vulkan and OpenGL write no depth; score prints a warning once for such a shader. A shader that writes no depth gets no depth target, attachment or extra pass.

The declared depth reaches the node the shader is connected to, which reads it through an `IS_DEPTH` input (see [Sampleable depth](#sampleable-depth)):

- a last pass drawn straight into the destination writes the destination's depth;
- a last pass with a target of its own (see [The last pass](#the-last-pass)) has its depth copied into the destination along with its color;
- each color output of a shader with `OUTPUTS` carries the shader's `depth` output into its destination.

The copy depth-tests with the pass's `DEPTH_COMPARE`, as a pass drawn there would: several producers connected to one port depth-test against each other through that port's render target, in whichever order they are drawn. A `DEPTH_COMPARE` of `always` replaces the depth. When the destination has no depth attachment, the depth stays behind and a warning says so. The depth of the passes before the last one, and of a layered depth output, is not passed on.

score's 3D rendering uses reverse-Z: the nearer fragment has the greater depth. `DEPTH_COMPARE` values are matched ignoring case, `_`, `-` and spaces (`less_equal`, `lessOrEqual`, `lequal`...); an unknown one is read as `greater`, with a warning.

## Size expressions

`WIDTH`, `HEIGHT`, and related size fields accept numbers or expressions:

```json
{ "TARGET": "half", "WIDTH": "$WIDTH / 2", "HEIGHT": "$HEIGHT / 2" }
```

Available variables include `$WIDTH`, `$HEIGHT` (the render size), `$inputName` for scalar controls, and `$WIDTH_inputImage` / `$HEIGHT_inputImage` for input texture sizes. Pass sizes and `OUTPUTS` sizes are evaluated the same way; a target is rebuilt when a control or input size its expression reads changes. Expressions support standard arithmetic and common functions such as `min`, `max`, `sqrt`, `ceil`, `floor`, `pow`, `sin`, and `cos`.

These are score's expression functions, the same as in the Math processes. Three of them take their arguments in another order than GLSL:

| Expression | GLSL equivalent |
|---|---|
| `lerp(t, a, b)` | `mix(a, b, t)` |
| `step(value, edge)` | `step(edge, value)` |
| `smoothstep(value, start, stop)` | `smoothstep(start, stop, value)` |

The texture inlet inspector also provides an explicit size checkbox with width and height controls. Uncheck it for **Auto** sizing; this is distinct from allocating a fixed-size target in the shader header. The **Show shader previews** toolbar action controls library and inspector previews. See [[Graphics pipeline]] for sizing and backend limits, and [[Shader cookbook]] for feedback, MRT and sampler recipes.

## Alpha and compositing

Declare the alpha convention your shader writes:

```json
{
  "ALPHA": "straight",
  "COMPOSITE": "over"
}
```

- `ALPHA`: `"straight"` or `"premultiplied"`.
- `COMPOSITE`: `"over"`, `"add"`, `"multiply"`, `"screen"`, or `"replace"`.

This is especially important when mixing shader outputs with text, videos, transparent 3D renders, or layered raw raster passes.

## Examples

### Simple color filter

```glsl
/*{
  "DESCRIPTION": "Simple brightness/contrast adjustment",
  "ISFVSN": "2",
  "INPUTS": [
    { "NAME": "inputImage", "TYPE": "image" },
    { "NAME": "brightness", "TYPE": "float", "DEFAULT": 1.0, "MIN": 0.0, "MAX": 3.0 },
    { "NAME": "contrast", "TYPE": "float", "DEFAULT": 1.0, "MIN": 0.0, "MAX": 3.0 }
  ]
}*/

void main() {
    vec4 color = IMG_THIS_NORM_PIXEL(inputImage);
    color.rgb = (color.rgb - 0.5) * contrast + 0.5;
    color.rgb *= brightness;
    isf_FragColor = color;
}
```

### Generator

```glsl
/*{
  "DESCRIPTION": "Animated circle generator",
  "ISFVSN": "2",
  "INPUTS": [
    { "NAME": "radius", "TYPE": "float", "DEFAULT": 0.3, "MIN": 0.01, "MAX": 1.0 },
    { "NAME": "color", "TYPE": "color", "DEFAULT": [1, 0.5, 0, 1] }
  ]
}*/

void main() {
    vec2 uv = isf_FragNormCoord - 0.5;
    float d = length(uv);
    float circle = 1.0 - smoothstep(radius - 0.01, radius, d + sin(TIME * 3.0) * 0.05);
    isf_FragColor = mix(vec4(0), color, circle);
}
```

### Feedback trail

```glsl
/*{
  "DESCRIPTION": "Feedback trail effect",
  "ISFVSN": "2",
  "INPUTS": [
    { "NAME": "inputImage", "TYPE": "image" },
    { "NAME": "decay", "TYPE": "float", "DEFAULT": 0.95, "MIN": 0.0, "MAX": 1.0 }
  ],
  "PASSES": [
    { "TARGET": "feedback", "PERSISTENT": true },
    {}
  ]
}*/

void main() {
    if (PASSINDEX == 0) {
        vec4 prev = IMG_THIS_NORM_PIXEL(feedback);
        vec4 curr = IMG_THIS_NORM_PIXEL(inputImage);
        isf_FragColor = max(curr, prev * decay);
    } else {
        isf_FragColor = IMG_THIS_NORM_PIXEL(feedback);
    }
}
```

### MRT output

```glsl
/*{
  "DESCRIPTION": "Color and luminance outputs",
  "ISFVSN": "2",
  "INPUTS": [
    { "NAME": "inputImage", "TYPE": "image" }
  ],
  "OUTPUTS": [
    { "NAME": "color", "TYPE": "color" },
    { "NAME": "luminance", "TYPE": "color", "FORMAT": "r16f" }
  ]
}*/

void main() {
    vec4 c = IMG_THIS_NORM_PIXEL(inputImage);
    color = c;
    float lum = dot(c.rgb, vec3(0.2126, 0.7152, 0.0722));
    luminance = vec4(vec3(lum), 1.0);
}
```
