---
layout: default

title: Math expressions
description: "Math expression syntax and processes in ossia score"

parent: Processes
grand_parent: Reference

permalink: /processes/exprtk.html
score: /reference/processes/arraygen-array.score
---

# ExprTK support

Several processes allow to write simple math expressions. Such processes include:

- Micromap: for very simple math expressions, e.g. `x * 100`.
- Expression Audio Generator: generates multi-channel audio.
- Expression Audio Filter: filters multi-channel audio.
- Expression Value Generator: generates values suitable for the device explorer on every tick.
- Expression Value Filter: filters values suitable for the device explorer.
- Arraygen: generates an array of values.
- Arraymap: applies the function to each value of the input array.

![ExprTK]({{ site.img }}/reference/processes/exprtk.png)

These expressions are evaluated within *score* using the [ExprTK library](https://www.partow.net/programming/exprtk/index.html "ExprTK website").

Write expressions on multiple lines in the process's built-in editor. For the canonical syntax, variable scopes, functions and complete examples, see the [ExprTK language reference]({{ site.baseurl }}/reference/languages/exprtk.html).

Choose a value process for device-explorer values, an audio process for per-frame audio, Arraygen for a generated list, or Arraymap to transform an incoming list. Their available inputs and persistent variables differ; use the [variable scope tables]({{ site.baseurl }}/reference/languages/exprtk.html#available-variables) rather than assuming every binding is available everywhere.

## Audio handling

Audio expressions process frames, with channels stored in arrays, and write to `out`. See [audio handling and equivalent loop/vector examples]({{ site.baseurl }}/reference/languages/exprtk.html#audio-handling).

## Using arrays in ExprTK

Value processes distinguish scalar inputs (`x`, `px`, `po`) from array inputs (`xv`, `pxv`, `pov`). See [array syntax, polar-coordinate conversion and Object filter unwrapping]({{ site.baseurl }}/reference/languages/exprtk.html#using-arrays-in-exprtk). Arraygen below is an alternative for generating arrays.

## Using Arraygen {#arraygen}

![Arraygen]({{ site.img }}/reference/processes/exprtk/arraygen.png)

Arraygen will generate an array with as many elements as chosen.
The expression will be used to generate each element. 
`i` represents the current element index, starting from zero and `n` is useable as the total count of elements.

Arraygen can also return arrays: 

![Arraygen used for arrays]({{ site.img }}/reference/processes/exprtk/arraygen-array.png)

[Download the example score here]({{ site.scores }}{{ page.score }}).

{% include try-on-web.html %}

Compare three related rhythms in [Arraygen Signal Study]({{ site.baseurl }}/reference/process-examples/arraygen.html). One expression uses each list element's index to generate a different oscillation rate, and Signal display plots the results. Change the expression's time multiplier to speed up or slow down all three together while preserving their rate relationships.

## Using Arraymap {#arraymap}

![Arraymap]({{ site.img }}/reference/processes/exprtk/arraymap.png)

Arraymap applies the expression to every element used as input. 
The same variables are useable than for Arraygen, the only difference is that triggering 
is bound to the presence of an input value instead of the timeline.

## Available variables

The complete [variable reference]({{ site.baseurl }}/reference/languages/exprtk.html#available-variables) lists time, controls, persistent memory, scalar and array inputs, audio outputs, sampling rate and array indices by process.

## Available functions

See [ExprTK and score-provided functions]({{ site.baseurl }}/reference/languages/exprtk.html#available-functions), including `random` and `noise` with parameter descriptions and examples.

## Examples

The [canonical expression examples]({{ site.baseurl }}/reference/languages/exprtk.html#examples) preserve the Logistic, Noisify, Sine, Square, Wobbly and distortion expressions, together with links to all expression preset folders in the user library.

Go directly to a relocated section:

- <a id="everywhere"></a>[Variables available everywhere]({{ site.baseurl }}/reference/languages/exprtk.html#everywhere)
- <a id="value-filter-value-generator-audio-filter-audio-generator"></a>[Variables for Value filter, Value generator, Audio filter, Audio generator]({{ site.baseurl }}/reference/languages/exprtk.html#value-filter-value-generator-audio-filter-audio-generator)
- <a id="value-filter-micromap-arraymap"></a>[Variables for Value filter, Micromap, Arraymap]({{ site.baseurl }}/reference/languages/exprtk.html#value-filter-micromap-arraymap)
- <a id="value-filter-micromap"></a>[Variables for Value filter, Micromap]({{ site.baseurl }}/reference/languages/exprtk.html#value-filter-micromap)
- <a id="value-generator"></a>[Value generator variables]({{ site.baseurl }}/reference/languages/exprtk.html#value-generator)
- <a id="audio-filter"></a>[Audio filter variables]({{ site.baseurl }}/reference/languages/exprtk.html#audio-filter)
- <a id="audio-generator"></a>[Audio generator variables]({{ site.baseurl }}/reference/languages/exprtk.html#audio-generator)
- <a id="arraymap-arraygen"></a>[Variables for Arraymap, Arraygen]({{ site.baseurl }}/reference/languages/exprtk.html#arraymap-arraygen)
- <a id="exprtk-provided-functionshttpwwwpartownetprogrammingexprtk"></a>[ExprTK-provided functions]({{ site.baseurl }}/reference/languages/exprtk.html#exprtk-provided-functions)
- <a id="score-provided-functions"></a>[score-provided functions]({{ site.baseurl }}/reference/languages/exprtk.html#score-provided-functions)
- <a id="value-generator-1"></a>[Value generator examples]({{ site.baseurl }}/reference/languages/exprtk.html#value-generator-1)
- <a id="logistic-function"></a>[Logistic function]({{ site.baseurl }}/reference/languages/exprtk.html#logistic-function)
- <a id="value-mapper"></a>[Value mapper examples]({{ site.baseurl }}/reference/languages/exprtk.html#value-mapper)
- <a id="add-noise"></a>[Add noise]({{ site.baseurl }}/reference/languages/exprtk.html#add-noise)
- <a id="audio-generator-1"></a>[Audio generator examples]({{ site.baseurl }}/reference/languages/exprtk.html#audio-generator-1)
- <a id="sine-wave"></a>[Sine wave]({{ site.baseurl }}/reference/languages/exprtk.html#sine-wave)
- <a id="square-wave"></a>[Square wave]({{ site.baseurl }}/reference/languages/exprtk.html#square-wave)
- <a id="wobbly-synth"></a>[Wobbly synth]({{ site.baseurl }}/reference/languages/exprtk.html#wobbly-synth)
- <a id="audio-filter-1"></a>[Audio filter examples]({{ site.baseurl }}/reference/languages/exprtk.html#audio-filter-1)
- <a id="crude-distortion"></a>[Crude distortion]({{ site.baseurl }}/reference/languages/exprtk.html#crude-distortion)
