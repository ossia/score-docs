---
layout: default

title: Value Display
description: "Real-time visualization of input data"

parent: Processes
grand_parent: Reference

permalink: /processes/value-display.html
---
# Value Display


Visualize control signals in real-time for monitoring, debugging, and performance feedback. Value Display shows you the current value being ouput from a given node, or an input OSC or network message.

Simply connect it to an output and watch the result.

The inspector allows to select how many recent values are retained.

The small light above the input port flashes on value arrival, including repeated values whose displayed text does not change. It remains lit while messages keep arriving and fades when they stop. Use it to distinguish a constant stream from a source that sent one value and then became silent.

## Related processes

*score* comes with multiple processes for monitoring input data [[Signal Display]], [[LED View]], [[Point2D View]].
