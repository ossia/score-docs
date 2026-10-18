---
layout: default
title: "GPU particle forces"
description: "Shape collective particle motion by balancing vortex, gravity and drag on the GPU."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/nbody.html
score: /examples/3d/nbody.score
---

# GPU particle forces

![Blue sphere particles behind the RandomScatter, VortexForce, BasicForces and NBodyGravity process chain.]({{ site.baseurl }}/assets/scores/thumbnails/examples-3d-nbody.png)

A cloud of particles swirls and gathers under competing forces. You set the forces, not the path of each point.

RandomScatter initializes 1,024 particles. Vortex, basic and gravitational forces contribute to their motion, then Integrate updates the simulation over time. The resulting points are converted to sphere splats for native rendering, not Qt Quick 3D.

## Try it

Start playback and lower Integrate's `timeScale` to inspect the motion. Raise vortex strength to make the cloud swirl, then raise `gravitationalConstant` to pull it into clumps. Increase drag to damp the motion.

RandomScatter has `once` enabled: changing a force during playback is not the same as initializing a different cloud. This is a visual simulation, not a reference scientific integrator. It requires compute-shader support but no external particle data or model.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
