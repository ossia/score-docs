---
layout: default

title: ISF Shaders
description: "Using ISF shaders in the ossia score graphics pipeline"

parent: Processes
grand_parent: Reference

permalink: /processes/shaders.html
---

# ISF Shaders

![Shader]({{ site.img }}/reference/processes/shader.png "Shader Example")

The ISF Shader process runs [Interactive Shader Format](https://isf.video) fragment shaders on the GPU. Use it for video filters, generators, feedback effects, post-processing, texture conversion, and Shadertoy-style visuals.

ISF shaders can be drag-and-dropped from the process library, user library, or file explorer. *score* reads the JSON header, creates controls and texture ports automatically, and recompiles the shader while the score is running.

## When to use ISF

Use ISF when the shader renders a fullscreen image pass. Use a different process when the work is not a fullscreen fragment pass:

| Goal | Better process |
|---|---|
| Run arbitrary compute, write storage images, generate geometry | [[Compute Shaders]] |
| Draw custom 3D geometry with a vertex shader | [[Render Pipeline]] |
| Display existing geometry quickly | [[Model Display]] |
| Write Vertex Shader Art-style point / line visuals | [[Vertex Shader Art]] |

## Files and live editing

An ISF shader is usually a `.fs` or `.frag` file with a JSON header followed by GLSL. A custom vertex shader can be paired with the fragment shader; the editor can live-code both stages.

Press {% include shortcut.html content="Ctrl+Enter" %} in the shader editor to recompile during playback. For production authoring, the official ISF editor remains useful, but *score* supports the runtime-specific features documented here.

Shader sources can use `#include`; include paths are resolved before parsing.

## JSON header

Every shader starts with a JSON block enclosed in `/*{ ... }*/`.

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

### Common fields

| Field | Description |
|---|---|
| `ISFVSN` | ISF version. Use `"2"`. |
| `DESCRIPTION` | Description shown in browsers and inspectors. |
| `CREDIT` | Author credit. |
| `CATEGORIES` | Library categories. |
| `INPUTS` | UI controls, texture inputs, audio textures, buffers, and uniforms. |
| `PASSES` | Multipass render plan. |
| `OUTPUTS` | Explicit output textures: multiple color outputs, depth, layers, cubemaps, formats, MSAA. |
| `ALPHA` | Output alpha convention: `"straight"` or `"premultiplied"`. |
| `COMPOSITE` | Default composition mode: `"over"`, `"add"`, `"multiply"`, `"screen"`, `"replace"`. |
| `EXTENSIONS` | GLSL extensions to require. |

If `MODE` is omitted, the file is treated as an ISF shader. `MODE` is reserved for other shader families such as CSF and raw raster.

## Scalar input types

Scalar inputs create UI controls and uniforms with the same name.

| ISF type | GLSL type | Typical fields |
|---|---|---|
| `float` | `float` | `DEFAULT`, `MIN`, `MAX` |
| `bool` | `bool` | `DEFAULT` |
| `event` | `bool` for one frame | none |
| `long` | `int` | `VALUES`, `LABELS`, `DEFAULT` |
| `point2D` | `vec2` | `DEFAULT`, `MIN`, `MAX` |
| `point3D` | `vec3` | `DEFAULT`, `MIN`, `MAX` |
| `color` | `vec4` | `DEFAULT`, `MIN`, `MAX` |

An `event` input fires for one rendered frame on `true` or an ossia impulse. Connect a trigger/message cable to it when an effect needs a reset or one-shot action; unlike a `bool`, it is not a latched switch.

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

For inputs that carry a depth companion, set `DEPTH: true`. This exposes a depth sampler next to the color sampler where the upstream producer provides one.

### Sampler state

Texture inputs can declare sampler state directly on the input object:

```json
{
  "NAME": "tex",
  "TYPE": "image",
  "FILTER": "nearest",
  "WRAP": "clamp_to_edge",
  "MIPMAP_MODE": "linear",
  "ANISOTROPY": 8.0
}
```

Supported fields include `WRAP`, `WRAP_S`, `WRAP_T`, `WRAP_R`, `FILTER`, `MIN_FILTER`, `MAG_FILTER`, `MIPMAP_MODE`, `BORDER_COLOR`, `COMPARE`, `ANISOTROPY`, `LOD_BIAS`, `MIN_LOD`, and `MAX_LOD`.

Audio inputs only use `FILTER` and `WRAP`.

## Audio textures

ISF audio inputs create GPU textures from audio data:

```json
{ "NAME": "wave", "TYPE": "audio", "MAX": 512, "FILTER": "nearest" }
{ "NAME": "fft", "TYPE": "audioFFT", "MAX": 512 }
{ "NAME": "hist", "TYPE": "audioHist", "MAX": 512 }
```

Use `FILTER: "nearest"` when FFT bin accuracy matters.

## Texture macros

Use the helpers instead of raw `gl_FragCoord` coordinate math. They keep orientation correct across OpenGL, Vulkan, Metal, and Direct3D.

| Macro | Description |
|---|---|
| `IMG_PIXEL(tex, coord)` | Sample at pixel coordinate. |
| `IMG_NORM_PIXEL(tex, coord)` | Sample at normalized `[0, 1]` coordinate. |
| `IMG_THIS_PIXEL(tex)` | Sample at this fragment's pixel coordinate. |
| `IMG_THIS_NORM_PIXEL(tex)` | Sample at this fragment's normalized coordinate. |
| `IMG_TEXEL(tex, coord)` | Texel fetch at integer coordinate. |
| `IMG_SIZE(tex)` / `TEX_DIMENSIONS(tex)` | Texture size in pixels. |
| `IMG_CUBE(tex, dir)` | Cubemap sample. |

Straight-alpha helpers are available when a source must be unpremultiplied before math:

```glsl
vec4 c = ISF_STRAIGHT_NORM_PIXEL(inputImage, isf_FragNormCoord);
```

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
| `MSAA_SAMPLES` | `int` | Active sample count when MSAA is enabled. |

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

Color outputs become `layout(location = N) out vec4 name;`. A depth output is written through `gl_FragDepth`.

### Output fields

| Field | Description |
|---|---|
| `NAME` | Output name. |
| `TYPE` | `"color"` or `"depth"`. Defaults to `"color"`. |
| `FORMAT` | Texture format such as `rgba8`, `rgba16f`, `rgba32f`, `r32f`, `d32f`. |
| `WIDTH`, `HEIGHT` | Fixed size or expression. |
| `LAYERS` | Texture array layer count. |
| `DEPTH` | 3D texture depth. |
| `CUBEMAP` | Allocate as cubemap. |
| `GENERATE_MIPS` | Generate mipmaps after rendering. |
| `SAMPLES` | MSAA sample count. |
| `ALPHA` | Per-output alpha convention. |
| `COMPOSITE` | Per-output compositing mode. |

All color outputs in one pass share the render target size. Cubemap outputs are square.

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
| `FLOAT` | Use floating-point storage. |
| `FILTER` | `"NEAREST"` for nearest sampling. |
| `WIDTH`, `HEIGHT` | Fixed size or expression. |
| `LAYER` | Render into a texture-array layer. |
| `Z` | Render into a 3D texture slice. |
| `FORMAT` | Per-pass intermediate format. |
| `PIPELINE_STATE` | Per-pass raster state override. |

ISF v1 `PERSISTENT_BUFFERS` are converted to persistent passes internally. The legacy field accepts an array of target names or an object mapping names to `WIDTH`, `HEIGHT` and `FLOAT` settings. Each name must match a pass's `TARGET`; an unmatched name is ignored with a diagnostic. Prefer `PERSISTENT: true` on the pass in new shaders.

The last pass normally renders to the process output. Use `PASSINDEX` to branch between pass code paths.

## Size expressions

`WIDTH`, `HEIGHT`, and related size fields accept numbers or expressions:

```json
{ "TARGET": "half", "WIDTH": "$WIDTH / 2", "HEIGHT": "$HEIGHT / 2" }
```

Available variables include `$WIDTH`, `$HEIGHT`, `$inputName` for scalar controls, and `$WIDTH_inputImage` / `$HEIGHT_inputImage` for input texture sizes. Expressions support standard arithmetic and common functions such as `min`, `max`, `sqrt`, `ceil`, `floor`, `pow`, `sin`, and `cos`.

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
    float circle = smoothstep(radius, radius - 0.01, d + sin(TIME * 3.0) * 0.05);
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

## Related Processes

- [[Compute Shaders]]: Compute shaders for images, buffers, volumes, and geometry.
- [[Render Pipeline]]: Raw vertex / fragment pipeline for custom 3D rendering.
- [[Vertex Shader Art]]: Vertex Shader Art-compatible generative shaders.
- [[Model Display]]: Built-in renderer for geometry.
- [[Pixel Utilities|Lightness Computer]]: Convert textures to pixel arrays for LED workflows.
