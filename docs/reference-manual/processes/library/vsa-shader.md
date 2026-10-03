---
layout: default

title: Vertex Shader Art
description: "Using Vertex Shader Art in the ossia score graphics pipeline"

parent: Processes
grand_parent: Reference

permalink: /processes/vertex-shader-art.html
score: /reference/processes/vertex-shader-art.score
---

# Vertex Shader Art

![Vertex Shader Art]({{ site.img }}/reference/processes/vsa.gif "VSA shader")

The Vertex Shader Art process runs shaders based on the [Vertex Shader Art](https://www.vertexshaderart.com) convention. A VSA shader generates vertices procedurally in the vertex stage; the fragment stage only displays the color produced by the vertex shader.

Use VSA for lightweight point clouds, line art, particle-like procedural visuals, and imported Vertex Shader Art examples. Use [[Render Pipeline]] instead when you need custom fragment shading, geometry inputs, buffers, depth / blend state, or scene rendering.

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

For a small starting point, the corpus's `vsa-triangle.vs` uses `POINT_COUNT: 3`, `PRIMITIVE_MODE: "TRIANGLES"` and branches on `vertexId` to emit three positions and a constant `v_color`. See [[Shader cookbook]] for the recipe and source link. Point and line sizes remain GPU/backend-dependent.

## Example

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

## Related Processes

- [[ISF Shaders]]: Fullscreen fragment shaders.
- [[Compute Shaders]]: Compute shaders for images, buffers, and geometry.
- [[Render Pipeline]]: Raw vertex / fragment raster pipeline.
- [[Model Display]]: Built-in 3D geometry renderer.
- [[Pixel Utilities|Lightness Computer]]: Convert rendered textures to LED pixel arrays.

## Try it

Download this [example score]({{ site.scores }}{{ page.score }}).
