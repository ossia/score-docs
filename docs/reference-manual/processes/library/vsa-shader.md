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

## Authoring a visual

Use the [Vertex Shader Art reference]({{ site.baseurl }}/reference/languages/vertex-shader-art.html) for header fields, vertex outputs, time and resolution variables, and a complete [rotating spiral]({{ site.baseurl }}/reference/languages/vertex-shader-art.html#example). Begin with the three-vertex recipe in [[Shader cookbook]] to see how positions and colors form the image. Connect the resulting texture to a video output. Point and line sizes depend on the GPU/backend.

## Related Processes

- [[ISF Shaders]]: Fullscreen fragment shaders.
- [[Compute Shaders]]: Compute shaders for images, buffers, and geometry.
- [[Render Pipeline]]: Raw vertex / fragment raster pipeline.
- [[Model Display]]: Built-in 3D geometry renderer.
- [[Pixel Utilities|Lightness Computer]]: Convert rendered textures to LED pixel arrays.

## Try it

For a more elaborate moving point cloud, download the [example score]({{ site.scores }}{{ page.score }}). Its shader calculates the points' positions and colors and sends the resulting image directly to a window. Reduce the vertex count from the saved 99,999 to see how a sparser set of points changes the image. This download uses a point-cloud-and-spheres shader, not the simpler spiral printed above.

{% include try-on-web.html %}
