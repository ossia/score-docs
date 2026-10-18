---
layout: default
title: ISF language reference
parent: Languages
grand_parent: Reference
permalink: /reference/languages/isf.html
---

# ISF language reference

This is the canonical shader contract for the [[ISF Shaders]] process. For GLSL syntax, generated declarations and portability, see [GLSL runtime reference]({{ site.baseurl }}/reference/languages/glsl.html). For worked tasks, see [[Shader cookbook]].

## Standard ISF and score extensions

[Interactive Shader Format](https://isf.video) combines GLSL with a JSON description. The upstream [JSON reference](https://docs.isf.video/ref_json.html) and [GLSL reference](https://docs.isf.video/ref_glsl.html) define the portable ISF interface; the tables below describe score's runtime, including extensions.

The standard input vocabulary is `event`, `bool`, `long`, `float`, `point2D`, `color`, `image`, `audio`, and `audioFFT`. Standard multipass declarations include `TARGET`, `PERSISTENT`, `FLOAT`, `WIDTH`, and `HEIGHT`. Standard shader variables include `TIME`, `TIMEDELTA`, `DATE`, `FRAMEINDEX`, `PASSINDEX`, `RENDERSIZE`, and `isf_FragNormCoord`; the pixel/normalized image sampling helpers are part of ISF.

Do not assume another ISF host supports score's `point3D`, `audioHist`, cubemaps, volume inputs, depth companions, explicit sampler-state fields, `OUTPUTS`, `ALPHA`, `COMPOSITE`, or the additional pass fields `LAYER`, `Z`, `FORMAT`, and `PIPELINE_STATE`. Likewise, `PROGRESS`, `SAMPLERATE`, `isf_FragCoord`, `clipSpaceCorrMatrix`, `MSAA_SAMPLES`, `IMG_TEXEL`, `TEX_DIMENSIONS`, `IMG_CUBE`, and `ISF_STRAIGHT_NORM_PIXEL` are score runtime conveniences rather than a portable ISF baseline. `MODE` selects score shader families; [CSF]({{ site.baseurl }}/reference/languages/csf.html), [raw raster]({{ site.baseurl }}/reference/languages/raw-raster.html), and [VSA integration]({{ site.baseurl }}/reference/languages/vertex-shader-art.html) are not standard ISF rendering modes.

Header names become generated shader declarations. Use valid, distinct GLSL identifiers and do not redeclare generated uniforms, samplers or outputs in the body. Compatibility acceptance of `gl_FragColor` is score preprocessing, not Vulkan GLSL syntax.

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
