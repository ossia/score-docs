---
layout: default
title: Geometry filter shaders
description: "The ISF-derived vertex transformation callback used by Geometry filter."
parent: Languages
grand_parent: Reference
nav_order: 25
permalink: /reference/languages/geometry-filter.html
---

# Geometry filter shaders

Geometry filter is another score-specific, ISF-derived shader format. It attaches a vertex transformation to incoming geometry for a downstream renderer. Unlike [CSF]({{ site.baseurl }}/reference/languages/csf.html), it does not ask you to dispatch a compute kernel; unlike [raw raster]({{ site.baseurl }}/reference/languages/raw-raster.html), it does not require a complete vertex/fragment pipeline.

Use it to deform a mesh or change vertex attributes before display. Connect a geometry source to **Geometry In**, then **Geometry Out** to a compatible renderer such as [[Model display]]. The [Animated Sphere Geometry Filter]({{ site.baseurl }}/reference/process-examples/geometry-filter.html) is a working example.

## Header and source file

Use a `.glsl` file with a JSON comment header. `MODE` selects the geometry-filter format, and `INPUTS` defines controls using the ISF input vocabulary. For example:

```glsl
/*{
  "ISFVSN": "2",
  "MODE": "GEOMETRY_FILTER",
  "DESCRIPTION": "Time-varying vertex displacement",
  "INPUTS": [
    { "NAME": "intensity", "TYPE": "float", "DEFAULT": 0.01, "MIN": 0.0, "MAX": 0.1 }
  ]
}*/

void process_vertex(inout vec3 position,
                    inout vec3 normal,
                    inout vec2 uv,
                    inout vec3 tangent,
                    inout vec4 color)
{
    position += this_filter.intensity * 10.0 * sin(TIME * position);
}
```

The body follows the deformation in the supplied sphere example. This is a callback, not a standalone `main()`: the renderer supplies the enclosing vertex shader. Keep the header and body together when saving a file or adding it to the user library.

## Callback contract

| Argument | Type | Purpose |
|---|---|---|
| `position` | `inout vec3` | Vertex position to transform. |
| `normal` | `inout vec3` | Surface normal used for shading. |
| `uv` | `inout vec2` | Texture coordinates. |
| `tangent` | `inout vec3` | Tangent attribute. |
| `color` | `inout vec4` | Vertex color. |

Arguments are mutable: leaving one unchanged preserves the value supplied to the callback. Displacing a position does not automatically give the corresponding deformed normal; update the normal as part of the transformation when the intended lighting requires it. The source mesh and renderer still determine which attributes are available and how they are used.

Access header controls through `this_filter`, as in `this_filter.intensity`. `TIME` is available for animation. Do not copy ISF fragment output code into this callback: it changes vertex attributes, not a pixel color attachment. Do not add the raw-raster `main()` prologue or epilogue around it; that enclosing shader belongs to the renderer.

For GLSL types and portable arithmetic, see the [GLSL runtime reference]({{ site.baseurl }}/reference/languages/glsl.html). For explicit geometry buffers, generated topology or compute feedback, use the [CSF geometry reference]({{ site.baseurl }}/reference/languages/csf.html#geometry-resources).

## Implementation reference

The current [Geometry filter process](https://github.com/ossia/score/blob/master/src/plugins/score-plugin-gfx/Gfx/GeometryFilter/Process.cpp) defines the callback and validates it inside a generated vertex shader. Its [library handler](https://github.com/ossia/score/blob/master/src/plugins/score-plugin-gfx/Gfx/GeometryFilter/Library.cpp) identifies `.glsl` files with the `GEOMETRY_FILTER` mode. These host conventions are specific to score, not part of standard ISF.
