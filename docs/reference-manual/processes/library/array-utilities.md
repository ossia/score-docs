---
layout: default

title: Array utilities
description: "Array utilities"

parent: Processes
grand_parent: Reference

permalink: /processes/array-utilities.html
score: /reference/processes/array-combiner.score
---

# Array Value Combiner {#sum}

![Array Combiner]({{ site.img }}/reference/processes/array-combiner.png "Array Combiner") 

[Try it !]({{ site.scores }}{{ page.score }})

This process combines multiple input arrays in one output array through various modes: 

  - Sum does an element-wise sum, that is given [1,2] and [10,20] as input the output would be [11, 22].
  - Append puts each array behind each other, that is given [1,2] and [10,20] as input the output would be [1, 2, 10, 20].
  - Product does an element-wise product, that is given [1,2] and [10,20] as input the output would be [10, 40].
  - Intersperse sequences elements in a column-major fashion, that is given [1,2,3] and [10,20,30] as input the output would be [1, 10, 2, 20, 3, 30].

**Input count** creates the array inputs and **Mode** selects the operation. Additional element-wise modes are **Min**, **Max**, **Mean**, **Subtract**, **AbsDifference**, **Divide**, **Median**, and **Clamp**. Clamp bounds the first input by the second (lower) and third (upper). Missing elements count as zero, except Mean and Median use only inputs containing that element.

**CosineSimilarity**, **DotProduct**, **EuclideanDistance**, and **ManhattanDistance** compare the first array against each other array over their common length, producing one result per comparison. Connect this result to Array Best Match to select the closest candidate. **Greater**, **Less**, **GreaterEqual**, and **LessEqual** perform chained element-wise comparisons and return 1 where the relation holds, otherwise 0.

For scalar-to-array routing, see the [Combine and Spread Signals walkthrough]({{ site.baseurl }}/reference/process-examples/combine-spread.html).

# Array tool {#tool}  

![Array Tool]({{ site.img }}/reference/processes/array-tool.png "Array Tool") 

[Try it !]({{ site.scores }}{{ page.score }})

Array tool transforms a numeric array: learn or set its **Min/Max**, scale with **Gain** and **Brightness**, choose range and shape behaviour, invert or take absolute values, and rearrange with padding, Reverse, Rotate, Repeat and Stride. **Normalize** rescales the result.

**Insert Value**, **From** and **Every** insert a constant at regular output positions, useful for adding an alpha or white channel to pixel data. Every must be greater than 1 to enable insertion. For example, From 3 and Every 4 insert a fourth component after each RGB triple. This differs from **Stride**, which expands existing values using zeros or repeated values. **Erase**, its own From, and Every remove regular groups.

The [Array Tool LED Reshaping walkthrough]({{ site.baseurl }}/reference/process-examples/array-tool.html) includes a downloadable patch for inspecting these transformations.

# Array Best Match {#best-match}

Accepts a numeric array on **Input** and outputs the zero-based **Index** and **Value** of its best finite element. **Mode: Highest** selects a similarity or score; **Lowest** selects a distance. **Probabilities** gives a softmax distribution; **Softmax scale** controls sharpness. Non-finite elements are skipped. New input or a settings change recomputes the result; it does not continuously repeat an unchanged result.

# Array Recombiner {#recombine}

Groups a flat list, or the components of a vec2/vec3/vec4, into sublists. **Grouping** sets group size; a final incomplete group is retained. For `[1,2,3,4,5,6]`, Grouping 2 gives `[[1,2],[3,4],[5,6]]`. With **Transpose**, the same input gives `[[1,3,5],[2,4,6]]`, useful for separating interleaved channels.

# Enumerator

Retains a **List** and emits one **Value** at a time. An impulse on **Trigger** steps to the next value (the first step is index 0); a number selects an index. **Index** reports changes to the selected index. Lists and fixed-size vectors are accepted.

**Mode** is Manual, EveryTick or Timed. Timed uses the **Interval** time chooser. **Bounds** chooses Clip, Wrap or Fold when the index passes an end of the list. This is a list walker, not a counter of incoming messages; see Counter in [Mapping utilities]({{ site.baseurl }}/processes/mapping-utilities.html#counter).

# Storage and synchronization

- [Buffer queue]({{ site.baseurl }}/processes/buffer-queue.html) collects arrivals and can emit a whole buffer or pop one value.
- [Tables]({{ site.baseurl }}/processes/table.html) provide indexed editable storage.
- [Rendezvous]({{ site.baseurl }}/processes/rendezvous.html) waits for one fresh value from every inlet.
- [LED View]({{ site.baseurl }}/processes/led-view.html) visualizes long numerical or pixel arrays.