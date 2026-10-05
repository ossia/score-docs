---
layout: default

title: Advanced
description: "Advanced examples demonstrating specialized features of ossia score"

parent: Examples
has_children: true

permalink: /examples/advanced
---

# Advanced Examples

Use this category as a route into specialized workflows. The [multi-media patching example]({{ site.baseurl }}/examples/basics/all-media.html), filed under Basics, introduces connections between audio, MIDI, textures and geometry.

For programmable processing, see [JavaScript / QML]({{ site.baseurl }}/processes/javascript.html), [C++ JIT]({{ site.baseurl }}/processes/cpp_jit.html), [Expressions]({{ site.baseurl }}/processes/exprtk.html), and [Compute Shaders]({{ site.baseurl }}/processes/compute-shaders.html). [Classifier]({{ site.baseurl }}/processes/classifier.html) and [Regressor]({{ site.baseurl }}/processes/regressor.html) describe machine-learning workflows and their requirements.

## Example patches

- [CPU data bending]({{ site.baseurl }}/examples/advanced/cpu-data-bending.html): compare Bendage effects on camera input.
- [GPU data bending]({{ site.baseurl }}/examples/advanced/gpu-data-bending.html): compare sorting, feedback and optical-flow shaders.
- [Livecoding processes]({{ site.baseurl }}/examples/advanced/livecoding.html): edit JavaScript, GLSL and a custom interface during playback.
- [Switch audio and video pipelines]({{ site.baseurl }}/examples/advanced/pipeline-switching.html): use address-driven scenario conditions to select effects.
- [Data visualization and sonification]({{ site.baseurl }}/examples/advanced/data-visualization.html): route imported data through statistics, native GPU rendering and audio.
- [Files, strings and serialization]({{ site.baseurl }}/examples/advanced/files-and-strings.html): read bundled files, transform text, and inspect serialization round trips.

For smaller control graphs, see [Data processing]({{ site.baseurl }}/examples/data). For camera models and their downstream mappings, see [AI and tracking]({{ site.baseurl }}/examples/ai).
