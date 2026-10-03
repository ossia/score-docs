---
layout: default
title: 3D text
description: "Generate native text meshes and text textures"
parent: Processes
grand_parent: Reference
permalink: /processes/3d-text.html
---

# 3D text

## Text to Mesh

Triangulate font outlines into a native scene emitted through **Scene Out**. Set **Text**, **Font family**, **Font size**, **Bold** and **Italic**. **Height** controls the world-space height of a capital H, independently of the font's pixel size; **Center X** centers the text horizontally. **Position**, **Rotation** and **Scale** place the result.

The geometry lies in the XY plane with its front facing +Z. It is **flat**, not extruded text. Font availability on the machine affects the outlines; ensure the intended font is installed when moving a score between computers.

```text
Text to Mesh → Material Override → Scene Preprocessor → Render Pipeline
```

Use Material Override to color or texture the text and [[Scene Preprocessor]] to prepare it for a scene-aware renderer. The output is a scene, not a ready-to-display texture.

## Text to Texture

Rasterize **Text** to an RGBA **Output** texture. Choose **Font family**, **Font size**, **Bold** and **Italic**, then set **Canvas width/height**. **Text R/G/B/A** and **BG R/G/B/A** control foreground and background colors; a zero background alpha leaves the background transparent.

**H align** is `0` left, `1` center or `2` right. **V align** is `0` top, `1` center or `2` bottom. The text is drawn within the canvas, so size the canvas to avoid clipping long labels.

Use the output as a shader input, overlay or material texture. Unlike Text to Mesh it remains a pixel image when enlarged, and it does not need Scene Preprocessor merely to display the texture.

See [[Instancing and materials]] for attaching the texture to a mesh and [[3D scene pipeline]] for scene-versus-geometry workflows.
