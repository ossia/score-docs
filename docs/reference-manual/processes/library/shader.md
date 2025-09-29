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

The shader process allow you to add and [[Live coding|live-code]] your own shader to an image or video.
A shader is a visual effect or generator program, which is processed with the graphics card for maximum performance.

Shaders are written with the [Interactive Shader Format (ISF)](https://isf.video), using GLSL.
A lot of nice shaders are already provided as part of the [[library|user library]], courtesy of Vidvox.

They can be drag'n'dropped from the library, or from the explorer ; controls and inputs will be created automatically.

ISF filters apply to the whole texture used as their input, which is then rendered to a texture used as output (or directly to the viewport).

# Editing shaders

We recommend using the official ISF editor to edit shaders for production work ; but it is possible to edit the shader code [[Live coding|live]] during execution of the score, by pressing {% include shortcut.html content="Ctrl+Enter" %} when in the code editor ; the shader will be updated automatically.

The shader editor allows to edit both the fragment and the vertex shader.

It is really important to leverage the ISF built-in functions to access textures: since score's graphics pipeline can leverage OpenGL, Vulkan, Metal and Direct3D, which all have different coordinates system, using the low-level primitives such as gl_FragCoord will yield Y direction inversions when using your shaders on different operating systems or grahpics backend.

## Related Processes

- [[Vertex Shader Art|VSA Shader]]: Similar to ISF shaders but for vertex instead of fragment shaders.
- [[Compute Shader]]: Similar to ISF shaders but for compute instead of fragment shaders.
- [[Model Display]]: To apply the shader onto a 3D surface.
- [[Pixel Utilities|Lightness Computer]]: To convert texture data into pixel arrays, for instance for [[LED design]].
## Try it!

Try it by downloading this [simple example]({{ site.scores }}/reference/processes/shell-command.score)!
Note that the example requires gzdoom to work.
