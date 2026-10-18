---
layout: default
title: jq and Jk
description: "Jk's jq-style query language for selecting, transforming and collecting structured values."
parent: Languages
grand_parent: Reference
permalink: /reference/languages/jq-jk.html
---

# jq and Jk

[Object filter]({{ site.baseurl }}/processes/object-filter.html) uses **Jk**, a C++ implementation of a subset of the **jq** query language. Use it to select a tracked point, route messages by a field, reshape a list or construct an object from incoming data.

The [jq manual](https://jqlang.org/manual/) is the upstream language reference. The [Jk implementation and compatibility notes](https://github.com/celtera/jk) define the subset available in score. **Object filter does not launch the `jq` executable, and installing jq does not extend Jk's syntax.** The reference below describes the current Jk implementation; older add-on versions may support fewer constructs.

## Values and result streams

A filter consumes one value and produces zero, one or several results. Each result becomes a separate output event in score. This is different from returning one array:

| Filter | Input | Output events |
|---|---|---|
| `.` | `[123, "foo"]` | One event containing `[123, "foo"]`. |
| `.[]` | `[123, "foo"]` | Two events: `123`, then `"foo"`. |
| `[.[]]` | `[123, "foo"]` | One event containing `[123, "foo"]`. |
| `[.]` | `[123, "foo"]` | One event containing `[ [123, "foo"] ]`. |
| `empty` | Any value | No events. |

The dot means the current input. A pipe sends each result of the left-hand filter into the right-hand filter. Square brackets collect the enclosed filter's results into one array. A comma produces multiple results from the same input.

For example, `[.[] | .name]` turns `[{"name":"Shashimi","age":6},{"name":"Flocky","age":3}]` into one list, `["Shashimi","Flocky"]`. Without the outer brackets, `.[] | .name` emits the two names separately.

Inputs are score values: maps, arrays, strings, numbers, booleans and null-like values. A string containing JSON text is still a string; it is **not implicitly parsed**. Decode it upstream with [Value serialization]({{ site.baseurl }}/processes/value-serialization.html) when an incoming protocol supplies serialized JSON rather than an object.

## Navigation and slices

| Syntax | Meaning |
|---|---|
| `.name`, `.a.b` | Select a map field or a nested field. |
| `.["odd key"]` | Select a key that is not a simple identifier. |
| `.[0]`, `.[-1]` | Select the first or last array element. Indices start at zero. |
| `.[0, 2]` | Emit the elements at indices 0 and 2 separately; `[.[0, 2]]` collects them. |
| `.[]` | Emit every array element or map value. Map traversal uses sorted keys in Jk. |
| `.[start:end]` | Return a slice as one value. The start is inclusive and the end is **exclusive**. |
| `.[:end]`, `.[start:]` | Slice from the beginning or to the end. Negative and expression-valued bounds are supported. |
| `.a?`, `.[]?` | Suppress errors from the optional operation. This can produce no result, rather than a null placeholder. |
| `..` | Recursively emit the input and its descendants. |

A missing map field or an out-of-range array index returns `null`; applying a field lookup to a number is a type error. Use optional navigation when that mismatch is expected.

For input `[123, 456, 789, 10]`:

```text
.[1:3]        → [456, 789]
[.[1:3]]      → [ [456, 789] ]
[.[1:3][]]    → [456, 789]
```

These slice semantics correct the earlier Object filter example: a slice does not emit its elements individually, and index 3 is not included in `.[1:3]`.

For a nested input:

```json
{
  "foo": [
    {"bar": 1}, {"bar": 3}, {"bar": 4},
    {"bar": 2}, {"bar": 5}, {"bar": 2}
  ]
}
```

use `[.foo[2:5][] | .bar]` to obtain `[4, 2, 5]`. The `[]` after the slice is necessary before selecting `.bar` from each object. Similarly, `.[6].test` selects `123` from an array whose seventh element is `{"test":123}`, and `.b[0].foo` selects `"x"` from `{"b":[{"foo":"x","bar":"y"}]}`.

## Construction, arithmetic and selection

| Construct | Example | Result or purpose |
|---|---|---|
| Literals | `42`, `"hello"`, `true`, `false`, `null` | Produce the literal independently of the input. |
| Array construction | `[.x, .y]` | Collect two fields into one array. |
| Object construction | `{id, x: .position[0]}` | Retain `id` and name a value extracted from `position`. |
| Computed key | `{(.key): .value}` | Use an input field as the output key. |
| Arithmetic | `.position[0] * 4` | Scale a coordinate. Operators include `+`, `-`, `*`, `/` and `%`. |
| Comparison | `.confidence >= 0.8` | Compare with `==`, `!=`, `<`, `<=`, `>` or `>=`. |
| Selection | `select(.state == "confirmed")` | Keep the original input when the condition is true; otherwise emit nothing. |
| Alternative | `.gain // 0.5` | Substitute when the left filter produces no non-false, non-null results. |
| Conditional | `if .active then .value else 0 end` | Choose a filter. `elif` is supported; an omitted `else` returns the input unchanged. |
| Interpolation | `"x=\(.x)"` | Insert a filter result into a string. |

`+` also concatenates strings or arrays and merges objects. Other operators likewise depend on operand types; combining a number and string with `+` is a type error, not implicit string conversion. Parentheses group expressions. A `#` starts a comment outside strings.

Only `false` and `null` are false-like. Zero, an empty string, an empty array and an empty object are true-like. Logical operators are `and`, `or` and the `not` filter; do not assume JavaScript truthiness.

A practical tracking query is:

```jq
[.[] | select(.confidence > 0.8) | .id]
```

For `[{"id":1,"confidence":0.95},{"id":2,"confidence":0.42}]`, this produces `[1]`. Removing the collecting brackets turns the accepted IDs into individual events.

## Supported built-ins

The following names and arities are supported by the current Jk evaluator. Function arguments are filters; separate multiple arguments with a semicolon, not a comma.

| Group | Functions |
|---|---|
| Inspection | `length`, `type`, `keys`, `keys_unsorted`, `has(key)`, `to_entries` |
| Type selection | `values`, `nulls`, `booleans`, `numbers`, `strings`, `arrays`, `objects`, `scalars`, `iterables` |
| Arrays and aggregation | `add`, `min`, `max`, `sort`, `unique`, `reverse`, `flatten` |
| Filtered collections | `map(filter)`, `select(filter)`, `sort_by(filter)`, `min_by(filter)`, `max_by(filter)`, `group_by(filter)` |
| Conversion and strings | `tostring`, `tonumber`, `join(separator)`, `split(separator)` |
| Mathematics | `floor`, `ceil`, `round`, `fabs`, `sqrt` |
| Logic | `not`, `any`, `any(condition)`, `any(generator; condition)`, and the corresponding three `all` forms |
| Stream access | `first`, `last`, `first(filter)`, `last(filter)`, `nth(index)`, `nth(index; filter)` |
| Stream control | `empty`, `isempty(filter)`, `limit(count; filter)`, `skip(count; filter)` |
| Ranges | `range(end)`, `range(start; end)`, `range(start; end; step)` |
| Errors | `error`, `error(payload)`, `try expression`, `try expression catch handler` |

`values` removes null inputs; it does not enumerate object values. Use `.[]` for that. In Jk, `keys_unsorted` uses the same sorted order as `keys`. `first` and `last` without arguments select array elements; their filter forms consume the beginning or end of a result stream. `map(. + 1)` on `[1,2]` returns `[2,3]`; `[range(1;4)]` returns `[1,2,3]`.

## Errors and compatibility limits

`try expression catch handler` sends the original error value into the handler. Without a handler, `try expression` suppresses the error. The `//` operator handles false, null or empty results, **not errors**; use `try` or optional navigation for potentially invalid operations.

The current subset does **not** implement variables, user-defined functions, `reduce`, `foreach`, assignments or update assignments, modules, regex functions, or I/O. In particular, do not assume that an arbitrary query copied from the full jq manual or a command-line flag such as `-r` or `--arg` works in the Filter field. Use score's [Regex process]({{ site.baseurl }}/processes/regex.html) for regular-expression processing.

Object keys are sorted rather than kept in jq's insertion order. Integer comparisons retain signed 64-bit precision, but general arithmetic uses binary64 floating-point numbers. UTF-8 slices and splitting on an empty separator operate on codepoints. Error wording need not match jq exactly.

In score, an invalid program disables output until a valid filter is supplied. A runtime error stops the remaining results for that input, but **does not retract results already emitted**. Object filter has no separate error outlet. The current wrapper also ignores an empty-string input. Check the incoming type and test a simple `.` filter before troubleshooting a longer query.

Keep work bounded during playback: a large recursive traversal or generated range can be expensive. Jk's evaluation has no automatic work budget and is not guaranteed hard-real-time safe. `first(filter)` and `limit(count; filter)` avoid evaluating the unused remainder of a stream.

## References and examples

- [jq manual](https://jqlang.org/manual/): full language semantics, beyond Jk's supported subset.
- [Jk language and compatibility notes](https://github.com/celtera/jk): evaluator capabilities and limits.
- [Object filter add-on](https://github.com/ossia/score-addon-jk): score's message-to-query integration.
- [Maths and structured objects]({{ site.baseurl }}/examples/data/maths-and-objects.html): selecting and reshaping values in a working score.
- [Files, strings and data]({{ site.baseurl }}/examples/advanced/files-and-strings.html): preparing structured data and text for other processes.
