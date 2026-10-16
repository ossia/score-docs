---
layout: default
title: "Animated Sphere Geometry Filter"
description: "Separate the rotation of a checkerboard sphere from the deformation of its surface."
parent: Processes
grand_parent: Reference
nav_exclude: true
permalink: /reference/process-examples/geometry-filter.html
score: "/reference/processes/geometry-filter.score"
---

# Animated Sphere Geometry Filter

![Sphere and Geometry filter connected to Model Display, with separate LFO controls and a Checkerboard texture branch.]({{ site.baseurl }}/assets/scores/thumbnails/reference-processes-geometry-filter.png)

A checkerboard sphere turns while its surface swells and distorts. Two independent controls let you separate movement of the whole object from movement within its shape—a useful distinction when designing an animated form rather than merely moving an image around.

**Geometry filter** displaces the sphere's vertices with a time-varying sine function. One slow LFO changes the strength of that displacement; another rotates the sphere. The checkerboard makes surface changes easier to follow, and **Model Display** renders the result before a glow effect softens it.

## Try it

Start playback and open the Window output. Disconnect the filter's intensity cable and set intensity to zero: the sphere should keep rotating, but lose its deformation. Restore the cable, then change the deformation LFO's rate without changing the rotation rate to see the two rhythms drift apart. Increasing the sphere's subdivisions gives the filter more vertices to displace, at a higher rendering cost.

The shape and texture are generated in the score; no mesh or image download is required.

See [[Model display]] for rendering the resulting geometry.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

