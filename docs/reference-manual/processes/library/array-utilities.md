---
layout: default

title: Array utilities
description: "Array utilities"

parent: Processes
grand_parent: Reference

permalink: /processes/array-utilities.html
---

# Array combiner {#sum}  

![Array Combiner]({{ site.img }}/reference/processes/array-combiner.png "Array Combiner") 

[Try it !]({{ site.scores }}/reference/processes/array-combiner.score)

This process combines multiple input arrays in one output array through various modes: 

  - Sum does an element-wise sum, that is given [1,2] and [10,20] as input the output would be [11, 22].
  - Append puts each array behind each other, that is given [1,2] and [10,20] as input the output would be [1, 2, 10, 20].
  - Product does an element-wise product, that is given [1,2] and [10,20] as input the output would be [10, 40].
  - Intersperse sequences elements in a column-major fashion, that is given [1,2,3] and [10,20,30] as input the output would be [1, 10, 2, 20, 3, 30].

# Array tool {#tool}  

![Array Tool]({{ site.img }}/reference/processes/array-tool.png "Array Tool") 

[Try it !]({{ site.scores }}/reference/processes/array-tool.score)

An efficient multi-tool for all your array needs.