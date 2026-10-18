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

For the language explanation, C++ versus JavaScript semantics, and the complete attributed formula collection, see [Bytebeat expressions]({{ site.baseurl }}/reference/languages/bytebeat.html).

# Usage
Bytebeat code can be edited when pressing the small "window" button on the process.

Each line of code can be treated independently.

This process compiles native C++ expressions, not JavaScript. It requires the [C++ JIT runtime]({{ site.baseurl }}/reference/languages/cpp.html#language-and-runtime-requirements); SDK header availability controls access to mathematical functions. Code is unsandboxed: save your document, use trusted formulas and start playback at a low audio level.

# Examples

- A simple yet efficient tune:
```cpp
(((t<<1)^((t<<1)+(t>>7)&t>>12))|t>>(4-(1^7&(t>>19)))|t>>7)
```

More examples and their original source attribution are in the [historical formula collection]({{ site.baseurl }}/reference/languages/bytebeat.html#historical-formula-collection). Some require adaptation before use in score.


