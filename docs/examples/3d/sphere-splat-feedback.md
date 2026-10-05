---
layout: default
title: "Sphere splats with texture feedback"
description: "Feed the previous rendered image back into a geometry compute shader."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/sphere-splat-feedback.html
score: /examples/3d/sphere-splat-feedback.score
---

# Sphere splats with texture feedback

SphereSplat_Generator creates a ring of particles. SphereSplat_Feedback takes this geometry and a delayed texture from the SphereSplat renderer, then sends modified geometry back to that renderer. The delayed connection is essential: the compute stage reads a previous image rather than creating an immediate cyclic dependency.

## Try it

Start playback and change `feedbackStrength` to compare the feedback contribution with `baseColor`. Vary `projectionScale` to change how the rendered image is sampled. The generator controls particle count, ring radius and sprite size; a triangle LFO animates the camera X coordinate through Micromap and Vec3f.

The renderer also sends its output to `Window:/`. Everything is generated in the score; no source image is needed. This is a native compute/Render Pipeline example, not Qt Quick 3D.

[Download this example]({{ site.scores }}{{ page.score }})
