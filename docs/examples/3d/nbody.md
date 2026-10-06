---
layout: default
title: "GPU particle forces"
description: "An example exploring particle motion under different simulated forces."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/nbody.html
score: /examples/3d/nbody.score
---

# GPU particle forces

![Blue sphere particles behind the RandomScatter, VortexForce, BasicForces and NBodyGravity process chain.]({{ site.baseurl }}/assets/scores/thumbnails/examples-3d-nbody.png)

This example demonstrates combining forces in a GPU particle simulation.

## Overview

A cloud of 1024 particles moves under vortex, basic and gravitational forces. Their combined influence is integrated over time and displayed as sphere splats. Changing the balance of forces lets you explore different kinds of collective motion without animating particles individually.

## Try it

Start playback and compare the motion after changing vortex strength, gravitationalConstant or drag. Lower Integrate's `timeScale` to inspect slower motion. The initial scatter has `once` enabled; changing a force is different from changing the initial distribution.

This is a GPU simulation example, not a reference scientific integrator. It needs compute-shader support but no external particle data or model. The force and rendering chain is native, not Qt Quick 3D.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
