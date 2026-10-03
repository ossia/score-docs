---
layout: default
title: "String / byte conversion"
description: "Convert raw strings to integer byte lists and back"
parent: Processes
grand_parent: Reference
permalink: /processes/string-bytes.html
---

# String / byte conversion

**String to Bytes** and **Bytes to String** are two registered processes for binary data carried in score strings.

String to Bytes accepts a string on **String** and emits a list of integers from 0 to 255 on **Bytes**, one per raw byte. Bytes to String performs the inverse conversion. These are byte conversions, not Unicode-codepoint conversions: UTF-8 characters can occupy several bytes, and embedded NUL bytes are preserved. Neither process validates UTF-8.

**Max bytes** limits the accepted size, with a hard ceiling of 1,048,576 bytes. Bytes to String rejects noninteger elements and integers outside 0–255 rather than clipping them. Use the **Error** outlet to diagnose invalid input. Changing the size limit does not replay the last input.

For structured JSON, CBOR or typed binary records, use [Serialize and Deserialize]({{ site.baseurl }}/processes/value-serialization.html).
