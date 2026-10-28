---
layout: default
title: Vertex Shader Art reference
parent: Languages
grand_parent: Reference
nav_order: 24
permalink: /reference/languages/vertex-shader-art.html
---

# Vertex Shader Art reference

This is the canonical shader contract for the [[Vertex Shader Art]] process. For GLSL syntax, generated declarations and portability, see [GLSL runtime reference]({{ site.baseurl }}/reference/languages/glsl.html). For worked tasks, see [[Shader cookbook]].

This integrates the [Vertex Shader Art](https://www.vertexshaderart.com) convention into score's shader runtime. The JSON `MODE` and ISF-style input declarations are score's integration contract, not a standard ISF rendering mode. Vertices are procedural; score supplies the fragment stage that displays `v_color`. Use [raw raster]({{ site.baseurl }}/reference/languages/raw-raster.html) when you need to author both stages.

## Header

A VSA shader is an ISF-style shader with `MODE: "VERTEX_SHADER_ART"`.

```json
"MODE": "VERTEX_SHADER_ART"
```

Common VSA fields:

| Field | Description |
|---|---|
| `POINT_COUNT` | Default of the **Vertex Count** control (3 to 100000). Without a positive `POINT_COUNT` it is 3: one triangle. |
| `PRIMITIVE_MODE` | Default of the **Primitive Type** control: `POINTS`, `LINE_STRIP`, `LINE_LOOP`, `LINES`, `TRI_STRIP`, `TRI_FAN` or `TRIANGLES`, in any case. Without one, or with an unknown one (which prints a message), `TRIANGLES`. |
| `LINE_SIZE` | Line / point sizing policy used by imported VSA shaders. |
| `BACKGROUND_COLOR` | Clear color. |
| `INPUTS` | ISF-style controls, images, and audio inputs. |

The process also supports the standard ISF metadata fields such as `DESCRIPTION`, `CREDIT`, `CATEGORIES`, and `ISFVSN`; without a `DESCRIPTION`, the description is "Vertex Shader Art". The header follows the [ISF header syntax]({{ site.baseurl }}/reference/languages/isf.html#header-syntax) and [input name rules]({{ site.baseurl }}/reference/languages/isf.html#input-names); `vertexCount` and `primitiveType` are the names of the two controls above.

`LINE_LOOP` draws a closed polyline through the vertices, the last one joined to the first. `TRI_FAN` draws a fan; on backends without triangle fans (Direct3D, Metal), the same triangles are drawn as a list.

VSA has no storage buffers, uniform blocks, geometry or storage images: such entries in `INPUTS` are ignored, with a message, and create no port. `event` inputs fire for one frame, as in ISF. `DATE`, `SAMPLERATE` and the other ISF built-in uniforms are available.

## Shader variables

The shader writes the normal vertex outputs:

```glsl
gl_Position = vec4(...);   // clip-space position
gl_PointSize = ...;        // point size when drawing points
v_color = vec4(...);       // color passed to the fixed fragment stage
```

Typical VSA examples also use:

```glsl
vertexId    // current vertex index
time        // playback time
resolution  // render size
```

ISF-style controls declared in `INPUTS` are available as uniforms.

Image inputs can be read with the WebGL functions VSA art uses, `texture()`, `textureLod()` and `texelFetch()`, as well as with the ISF `IMG_*` macros. On a 2D image input, these raw reads are oriented like `IMG_NORM_PIXEL`: `v = 0` is the bottom of the image on every backend. A `v` on the edge between two rows, such as `n / 240.0`, reads the same row on every backend: the row above the edge, `floor(v * height)`. Other sampling functions (`textureGrad`, `textureOffset`, `textureProj`...) are left as written.

### Mouse and touch

Two inputs reproduce the `mouse` and `touch` of [vertexshaderart.com](https://www.vertexshaderart.com):

```json
"INPUTS": [
  { "NAME": "mouse", "TYPE": "point2D" },
  { "NAME": "touch", "TYPE": "image" }
]
```

| Input | Default binding | Content |
|---|---|---|
| `mouse` | `cursor/clip` of the first [[Window device]] | Mouse position in clip space, x and y in `[-1, 1]`, y up. |
| `touch` | `touch/history` of the first window device | The last 240 frames of the window's pointers, a 32 × 240 RGBA float texture read with nearest filtering and clamp to edge. |

In the touch history, column *c* is pointer *c*: column 0 is the mouse or the first finger, the next columns the further fingers in the order they came down. Row 0, at `v = 0`, is the newest frame; `v = 1` is 239 frames ago. Each texel is `(x, y, pressure, time)`: the position in clip space, y up, the pressure (1 while the mouse button is pressed; a released pointer keeps its position with pressure 0), and the time of the row, in seconds since the history started.

```glsl
// Pointer 0, five frames ago.
vec4 t = texture(touch, vec2(0.5 / 32.0, (5.0 + 0.5) / 240.0));
vec2 position = t.xy;
float pressure = t.z;
```

These bindings are set on the inlets, where they show and can be changed: rebind them to another address, or cable a texture into `touch`. They are made the same way in ISF and render pipeline shaders, see [ISF pointer inputs]({{ site.baseurl }}/reference/languages/isf.html#pointer-inputs). Without a window device, nothing is bound: an unconnected `touch` reads an empty texture.

VSA clip-space depth follows its original OpenGL-style convention; the runtime maps it to the backend's clip range. Do not add the raw-raster `isf_vertShaderInit()` / `isf_vertShaderFinish()` sequence or a second backend depth correction to a VSA shader.

To understand how individual vertices make an image, start with the triangle recipe in [[Shader cookbook]]. It places three vertices and gives them one color; changing a vertex position changes the silhouette without loading a mesh. Point and line sizes remain GPU/backend-dependent.

## Example

Build a rotating, colored spiral from points rather than an image texture. Each vertex's index determines its angle and distance from the center; playback time rotates the pattern. In the code below, try reducing **radius** to gather the points toward the center, then change the `0.05` angle increment to alter how tightly the spiral winds.

```glsl
/*{
  "DESCRIPTION": "Simple VSA spiral",
  "CREDIT": "ossia score",
  "ISFVSN": "2",
  "MODE": "VERTEX_SHADER_ART",
  "CATEGORIES": ["Geometry", "Animated"],
  "POINT_COUNT": 20000,
  "PRIMITIVE_MODE": "POINTS",
  "BACKGROUND_COLOR": [0, 0, 0, 1],
  "INPUTS": [
    { "NAME": "radius", "TYPE": "float", "DEFAULT": 0.8, "MIN": 0.1, "MAX": 2.0 }
  ]
}*/

void main() {
    float i = vertexId;
    float a = i * 0.05 + time;
    float r = radius * sqrt(i / 20000.0);
    vec2 p = vec2(cos(a), sin(a)) * r;

    gl_Position = vec4(p, 0.0, 1.0);
    gl_PointSize = 2.0;
    v_color = vec4(0.5 + 0.5 * cos(a + vec3(0.0, 2.0, 4.0)), 1.0);
}
```
