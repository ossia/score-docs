---
layout: default
title: "Value serialization"
description: "Encode and decode structured values as text or binary"
parent: Processes
grand_parent: Reference
permalink: /processes/value-serialization.html
---

# Value serialization

**Serialize** converts **Value** to a raw string on **Bytes**. **Deserialize** converts **Bytes** back to **Value**. Both provide **Success** and **Error** outlets; Error is empty on success, and a failure clears the result rather than leaving the previous result valid.

## Formats

- **JSON**: strict UTF-8 JSON. Impulses become `null`, lists and vectors become arrays. Serialize’s **Pretty print** indents JSON without reducing precision.
- **CBOR**: the JSON-compatible subset, with UTF-8 text map keys. Tags, byte strings and undefined values are not supported.
- **Text**: **Plain** writes raw strings, delimited flat lists/vectors, and JSON for nested containers. Set **Delimiter** and **Line ending** to agree at both ends. Deserialize’s **Interpretation** can be Auto, String, Integer, Float, Boolean or List. Use List when a one-field list must remain a list. String preserves text and line endings.
- **Binary**: **FreeFlow** serializes untagged scalar bytes and flattens lists/vectors; decoding uses the chosen **Scalar type** and returns a list. **Layout** specifies explicitly typed fields. **Byte order** selects little or big endian unless overridden by the layout.

A binary Layout uses a subset of Python’s `struct` notation: for example `<B H I f 4s 2x` means little-endian packed fields, a four-byte string, and two padding bytes. `Ns` requires an exact-size raw string; it does not pad or truncate it. Sender and receiver must agree on the layout.

## Limits and round trips

Values must fit score’s int32 and finite float32 representation. The converters enforce limits of 8 MiB, 65,536 nodes and 64 nested containers. Vectors decode as lists, not their original vector type. Text **Pretty** is a human-readable display with rounded floats, not a lossless archive; use JSON for structured interchange instead. Binary FreeFlow is not self-describing and does not encode maps or impulses.

Use [String / byte conversion]({{ site.baseurl }}/processes/string-bytes.html) when the next process expects a list of byte integers rather than a raw string.
