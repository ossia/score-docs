---
layout: default

title: Object filter
description: "Filter complex objects with the jq syntax"

parent: Processes
grand_parent: Reference

permalink: /processes/object-filter.html
---
# Object filter

![Object filter]({{ site.img }}/reference/processes/object-filter.png "Object filter")

Object filter selects and reshapes structured values using **Jk**, a subset of the jq query language. Use it to extract a tracked coordinate, route an object by its state, or turn a list of records into the values needed by another process.

The canonical syntax and compatibility reference is [jq and Jk]({{ site.baseurl }}/reference/languages/jq-jk.html).

## Using the process

1. Install the Jk add-on through [[Add-ons]] if Object filter is not available in the process library.
2. Connect a map, array or other score value to **Input**.
3. Enter a query in **Filter**. Start with `.` to pass through the input, then select a field such as `.position[0]`.
4. Connect the output to the process or device parameter that should receive the result.

Each query result produces a separate output event. For example, `.[]` emits the elements of an input array individually, while `[.[] | .name]` collects names into one array. `select(.state == "confirmed")` passes through matching objects and emits nothing for other states.

Strings containing JSON are not automatically decoded. Use [[Value serialization]] upstream when the source sends serialized text instead of a map or array. An invalid filter disables output; a runtime error stops the remaining results for that message without retracting values already emitted. See the [runtime limits]({{ site.baseurl }}/reference/languages/jq-jk.html#errors-and-compatibility-limits) before using large queries during playback.

## Supported syntax and example programs

The syntax tables, corrected slice examples, built-in functions and compatibility limits now live in the [jq and Jk language reference]({{ site.baseurl }}/reference/languages/jq-jk.html).

- [Navigation and slices]({{ site.baseurl }}/reference/languages/jq-jk.html#navigation-and-slices): fields, indices, ranges and nested objects.
- [Construction and selection]({{ site.baseurl }}/reference/languages/jq-jk.html#construction-arithmetic-and-selection): arrays, objects, arithmetic and conditional filtering.
- [Supported built-ins]({{ site.baseurl }}/reference/languages/jq-jk.html#supported-built-ins): functions available in Jk, rather than the full jq language.

For a working score, see [Math expressions and structured objects]({{ site.baseurl }}/examples/data/maths-and-objects.html).