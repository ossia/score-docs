---
layout: default
title: "GPU particle forces"
description: "Combine vortex, basic and gravitational forces before integrating a particle buffer."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/nbody.html
score: /examples/3d/nbody.score
---

# GPU particle forces

RandomScatter initializes 1024 particles. VortexForce, BasicForces and NBodyGravity form a compute-shader chain leading into Integrate. PointsToSprites converts the resulting particle geometry for the SphereSplat native Render Pipeline, which writes to `Window:/`. A Vec3f process controls the camera.

## Try it

Start playback and compare the motion after changing vortex strength, gravitationalConstant or drag. Lower Integrate's `timeScale` to inspect slower motion. The initial scatter has `once` enabled; changing a force is different from changing the initial distribution.

This is a GPU simulation example, not a reference scientific integrator. It needs compute-shader support but no external particle data or model. The force and rendering chain is native, not Qt Quick 3D.

[Download this example]({{ site.scores }}{{ page.score }})
