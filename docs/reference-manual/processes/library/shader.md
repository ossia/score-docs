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

The shader process allows you to add and [[Live coding|live-code]] your own shader to an image or video.
A shader is a visual effect or generator program, which is processed with the graphics card for maximum performance.

Shaders are written with the [Interactive Shader Format (ISF)](https://isf.video), using GLSL.
A lot of nice shaders are already provided as part of the [[library|user library]], courtesy of Vidvox.

They can be drag'n'dropped from the library, or from the explorer ; controls and inputs will be created automatically.

ISF filters apply to the whole texture used as their input, which is then rendered to a texture used as output (or directly to the viewport).

# Editing shaders

We recommend using the official ISF editor to edit shaders for production work ; but it is possible to edit the shader code [[Live coding|live]] during execution of the score, by pressing {% include shortcut.html content="Ctrl+Enter" %} when in the code editor ; the shader will be updated automatically.

The shader editor allows to edit both the fragment and the vertex shader.

It is really important to leverage the ISF built-in functions to access textures: since score's graphics pipeline can leverage OpenGL, Vulkan, Metal and Direct3D, which all have different coordinate systems, using the low-level primitives such as `gl_FragCoord` will yield Y direction inversions when using your shaders on different operating systems or graphics backends.

# JSON header

Every ISF shader starts with a JSON block enclosed in `/*{ ... }*/`. This header declares inputs, passes, and metadata.

## Required fields

- `"ISFVSN"`: ISF version string (use `"2"`).

## Optional fields

- `"DESCRIPTION"`: Human-readable description.
- `"CREDIT"`: Author credit.
- `"CATEGORIES"`: Array of category strings (e.g. `["Color", "Filter"]`).
- `"INPUTS"`: Array of input declarations (see below).
- `"PASSES"`: Array of pass declarations for multi-pass rendering (see below).
- `"OUTPUTS"`: Array of output declarations for MRT (Multiple Render Targets) rendering (see below).

# Input types

Inputs are declared in the `"INPUTS"` array. Each input has a `"NAME"` and a `"TYPE"`, plus type-specific fields.

## float

A floating-point slider.

```json
{ "NAME": "brightness", "TYPE": "float", "DEFAULT": 1.0, "MIN": 0.0, "MAX": 2.0 }
```

In the shader: `uniform float brightness;` (accessed directly as `brightness`).

## bool

A toggle.

```json
{ "NAME": "invert", "TYPE": "bool", "DEFAULT": true }
```

## event

A trigger button (true for one frame when pressed).

```json
{ "NAME": "reset", "TYPE": "event" }
```

## long

An integer dropdown with labels.

```json
{
  "NAME": "mode", "TYPE": "long",
  "VALUES": [0, 1, 2],
  "LABELS": ["Normal", "Add", "Multiply"],
  "DEFAULT": 0
}
```

## point2D

A 2D point control.

```json
{ "NAME": "center", "TYPE": "point2D", "DEFAULT": [0.5, 0.5], "MIN": [0, 0], "MAX": [1, 1] }
```

In the shader: `uniform vec2 center;`.

## point3D

A 3D point control.

```json
{ "NAME": "position", "TYPE": "point3D", "DEFAULT": [0, 0, 0] }
```

In the shader: `uniform vec3 position;`.

## color

An RGBA color picker.

```json
{ "NAME": "tint", "TYPE": "color", "DEFAULT": [1, 0, 0, 1] }
```

In the shader: `uniform vec4 tint;`.

## image

A texture input. Creates an input port that accepts video or texture connections.

```json
{ "NAME": "inputImage", "TYPE": "image" }
```

Access in shader using ISF macros (see below).

3D textures are supported with `"DIMENSIONS": 3`:

```json
{ "NAME": "volume", "TYPE": "image", "DIMENSIONS": 3 }
```

3D texture inputs use `texture(volume, vec3(u, v, w))` directly in the shader instead of ISF macros.

## cubemap

A cubemap texture input.

```json
{ "NAME": "environment", "TYPE": "cubemap" }
```

In the shader: `uniform samplerCube environment;`, accessed with `texture(environment, vec3(...))`.

## audio

An audio waveform texture.

```json
{ "NAME": "audio", "TYPE": "audio", "MAX": 256 }
```

## audioFFT

An FFT frequency spectrum texture.

```json
{ "NAME": "spectrum", "TYPE": "audioFFT", "MAX": 256 }
```

## audioHist

An audio histogram texture.

```json
{ "NAME": "audioHistory", "TYPE": "audioHist", "MAX": 256 }
```

# Built-in texture macros

ISF provides cross-platform texture sampling macros. **Always use these instead of raw `texture()` calls** to ensure correct behavior across all graphics backends (OpenGL, Vulkan, Metal, Direct3D).

| Macro | Description |
|---|---|
| `IMG_PIXEL(tex, coord)` | Sample texture at pixel coordinate `ivec2` |
| `IMG_NORM_PIXEL(tex, coord)` | Sample texture at normalized coordinate `vec2` in `[0,1]` |
| `IMG_THIS_PIXEL(tex)` | Sample texture at the current fragment's pixel coordinate |
| `IMG_THIS_NORM_PIXEL(tex)` | Sample texture at the current fragment's normalized coordinate |
| `IMG_SIZE(tex)` | Returns `ivec2` size of texture in pixels |
| `TEX_DIMENSIONS(tex)` | Same as `IMG_SIZE` |

# Built-in uniforms

All ISF shaders have access to the following uniforms:

| Uniform | Type | Description |
|---|---|---|
| `TIME` | `float` | Playback time in seconds |
| `TIMEDELTA` | `float` | Time since last frame in seconds |
| `PROGRESS` | `float` | Timeline progress from 0 to 1 |
| `FRAMEINDEX` | `int` | Frame counter |
| `PASSINDEX` | `int` | Current rendering pass index |
| `RENDERSIZE` | `vec2` | Output size in pixels |
| `DATE` | `vec4` | Current date: `(year, month, day, seconds)` |
| `SAMPLERATE` | `float` | Audio sample rate in Hz |
| `isf_FragNormCoord` | `vec2` | Current fragment's normalized coordinate `[0,1]` |
| `isf_FragCoord` | `vec2` | Platform-corrected fragment coordinate in pixels |
| `clipSpaceCorrMatrix` | `mat4` | Clip space correction matrix (for vertex shaders) |

# Built-in outputs

## Single output (default)

By default, the shader writes to `gl_FragColor` (ISF 1) or `isf_FragColor` (ISF 2):

```glsl
void main() {
    gl_FragColor = vec4(1.0, 0.0, 0.0, 1.0);
}
```

## Multiple Render Targets (MRT)

Declare multiple outputs in the `"OUTPUTS"` array to render to several textures simultaneously:

```json
"OUTPUTS": [
  { "NAME": "color", "TYPE": "color" },
  { "NAME": "normals", "TYPE": "color" },
  { "NAME": "sceneDepth", "TYPE": "depth" }
]
```

Each color output becomes a `layout(location = N) out vec4 name;`. A depth output writes to `gl_FragDepth`.
The first color output is also aliased as `isf_FragColor` for backward compatibility.

# Multi-pass rendering

ISF supports multi-pass rendering where each pass renders to an intermediate texture that can be sampled by subsequent passes.

```json
"PASSES": [
  { "TARGET": "bufferA", "PERSISTENT": true, "FLOAT": true },
  {}
]
```

| Pass field | Description |
|---|---|
| `"TARGET"` | Name of the intermediate texture this pass renders to |
| `"PERSISTENT"` | `true` to preserve the texture content across frames (for feedback effects) |
| `"FLOAT"` | `true` to use 32-bit float texture format |
| `"NEAREST"` | `true` to use nearest-neighbor filtering (default is linear) |
| `"WIDTH"` | Width expression (default: viewport width) |
| `"HEIGHT"` | Height expression (default: viewport height) |

### Pass size expressions

The `"WIDTH"` and `"HEIGHT"` fields accept math expressions:

- Integer literals: `"512"`
- `$WIDTH`, `$HEIGHT`: Current viewport dimensions
- `$inputName`: Value of a scalar input (`float` or `long`)
- Arithmetic: `"$WIDTH / 2"`, `"$WIDTH * $scaleFactor"`

The expression evaluator supports standard arithmetic operators and common math functions (`min`, `max`, `sqrt`, `ceil`, `floor`, `pow`, `sin`, `cos`, etc.).

The last pass (with no `TARGET`) renders to the final output. Use `PASSINDEX` to branch logic per pass, and sample previous pass targets as textures using `IMG_PIXEL()` or `IMG_NORM_PIXEL()`.

# Examples

## Simple color filter

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
    gl_FragColor = color;
}
```

## Generator (no input)

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
    gl_FragColor = mix(vec4(0), color, circle);
}
```

## Feedback effect (persistent buffer)

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
        gl_FragColor = max(curr, prev * decay);
    } else {
        gl_FragColor = IMG_THIS_NORM_PIXEL(feedback);
    }
}
```

## MRT deferred rendering

```glsl
/*{
  "DESCRIPTION": "Simple deferred output",
  "ISFVSN": "2",
  "INPUTS": [
    { "NAME": "inputImage", "TYPE": "image" }
  ],
  "OUTPUTS": [
    { "NAME": "color", "TYPE": "color" },
    { "NAME": "luminance", "TYPE": "color" }
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

- [[Vertex Shader Art|VSA Shader]]: Similar to ISF shaders but for vertex instead of fragment shaders.
- [[Compute Shader]]: Similar to ISF shaders but for compute instead of fragment shaders.
- [[Render Pipeline]]: Raw vertex/fragment pipeline for custom geometry rendering.
- [[Model Display]]: To apply the shader onto a 3D surface.
- [[Pixel Utilities|Lightness Computer]]: To convert texture data into pixel arrays, for instance for [[LED design]].
