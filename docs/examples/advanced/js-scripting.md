---
layout: default

title: JavaScript scripting
description: "An example showing generative scripting with JavaScript"

parent: Advanced
grand_parent: Examples

permalink: /examples/advanced/js-scripting.html
---

# JavaScript Scripting

This example demonstrates using JavaScript for generative and procedural content in ossia score.

## Overview

ossia score includes a JavaScript scripting environment for creating custom processes, generative algorithms, and complex behaviors.

## JavaScript in ossia score

JavaScript processes can:
- Receive input values from cables
- Output processed values
- Create visual/audio content
- Control other processes

## Script structure

A basic ossia JavaScript process:

```javascript
// Called every frame
function tick(time, input) {
    // Process input
    var result = Math.sin(input * Math.PI * 2);
    return result;
}
```

## Available APIs

Scripts have access to:
- Math functions
- Random number generation
- ossia score objects
- Graphics commands (for visual scripts)

## Script console

ossia score includes an interactive console where you can:
- Test JavaScript code
- Create objects programmatically
- Automate editing tasks
- Generate content

## Generative applications

Scripting is useful for:
- Algorithmic composition
- Procedural graphics
- Complex mappings
- Custom behaviors
- Prototyping ideas

## Genuary collection

This example comes from the Genuary 2022 challenge series, where daily prompts inspire creative coding projects.

## Try it

Open this example to see JavaScript scripting in action. Try modifying the code to change the behavior!

[Download this example]({{ site.scores }}/examples/advanced/scripting.score)

## Learn more

- [[Javascript]] - JavaScript process reference
- [[Scripting]] - In-depth scripting guide for editor automation
- [[Scripting API]] - Complete JavaScript/QML API reference
- [[Console]] - Interactive script console
