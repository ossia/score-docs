---
layout: default

title: Bytebeat
description: "Dope 8-bit sound generator"

parent: Processes
grand_parent: Reference

permalink: /processes/bytebeat.html
---

# What is bytebeat?

![Bytebeat]({{ site.img }}/reference/processes/bytebeat.png "Bytebeat plug-in")

Bytebeat is a minimal programming language for synthetic sounds, using various bit-level properties
of numbers.

Here are multiple guides to that language:
- https://greggman.com/downloads/examples/html5bytebeat/html5bytebeat.html
- http://nightmachines.tv/the-absolute-beginners-guide-to-coding-bytebeats.html
- https://github.com/greggman/html5bytebeat
- https://github.com/radavis/bytebeat
- http://countercomplex.blogspot.com/2011/10/algorithmic-symphonies-from-one-line-of.html

# Usage
Bytebeat code can be edited when pressing the small "window" button on the process.

Each line of code can be treated independently.

The bytebeat code is compiled with a C++ compiler, so technically it's possible to go a little bit outside the bounds of traditional beats ; in particular, if the SDK is installed, the `<cmath>` C++ header will be available.

# Examples

- A simple yet efficient beat:
```cpp
(((t<<1)^((t<<1)+(t>>7)&t>>12))|t>>(4-(1^7&(t>>19)))|t>>7)
```

- Lots of examples here:
  https://www.reddit.com/r/bytebeat/comments/20km9l/cool_equations/