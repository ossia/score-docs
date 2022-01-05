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