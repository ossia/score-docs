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
| `POINT_COUNT` | Number of vertices to generate. |
| `PRIMITIVE_MODE` | `POINTS`, `LINES`, `LINE_STRIP`, or compatible VSA primitive mode. |
| `LINE_SIZE` | Line / point sizing policy used by imported VSA shaders. |
| `BACKGROUND_COLOR` | Clear color. |
| `INPUTS` | ISF-style controls, textures, and audio inputs. |

The process also supports the standard ISF metadata fields such as `DESCRIPTION`, `CREDIT`, `CATEGORIES`, and `ISFVSN`.

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
