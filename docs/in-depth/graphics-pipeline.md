---
layout: default

title: Graphics pipeline
description: "Understanding the ossia score graphics pipeline"

parent: In depth

permalink: /in-depth/video.html
---

# Graphics pipeline

*score* uses [Qt RHI](https://www.qt.io/blog/graphics-in-qt-6.0-qrhi-qt-quick-qt-quick-3d) as graphics abstraction for the video pipeline. It is able to use OpenGL ES 2.0, Vulkan, Metal, and Direct 3D 11 in a very efficient way.

*score* shaders are written with the [Interactive Shader Format](https://isf.video) specification.

Video processes are combined into a dynamic render graph which is processed in a separate thread. Each process writes to a render target.