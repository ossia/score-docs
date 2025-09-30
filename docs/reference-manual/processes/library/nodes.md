---
layout: default

title: Nodes
description: "Get a set of weights from graphical interpolation"

parent: Processes
grand_parent: Reference

permalink: /processes/nodes.html
---

# Nodes

![Nodes Process]({{ site.img }}/reference/processes/nodes_voronoi.png "Nodes process")

This process is a graphical interface which allows to create and interpolate across a set of nodes.

## Usage

The Nodes process has two modes: circular and voronoi.

![Nodes Process]({{ site.img }}/reference/processes/nodes.png "Nodes process")

An input cursors moves in a 2D space. Its distance to each node will be its contribution to the weight in the output.

## See also

- [[Interpolator]] can be used to transform the weights of the Ndoes process into an actual interpolation.
- [[AI Prompt Composer]] can be used to interpolate between multiple prompts targeting image generation models.

## Try it!

Try it by downloading this [simple example!]({{ site.scores }}/reference/processes/nodes.score)