---
layout: default
title: "Tables"
description: "Store and retrieve indexed control values"
parent: Processes
grand_parent: Reference
permalink: /processes/table.html
---

# Tables

The process library provides **Table (1D)**, **Table (2D)** and **Table** for arbitrary control values. Indices start at zero. These processes are not spreadsheets or file recorders.

## Table (1D)

Send an index to **Read** to retrieve a cell on **Output**. **Set** takes `[index, value]` and grows the table if needed. **Insert** uses the same pair but shifts following cells. **Append**, **Prepend**, **Erase**, **Pop front** and **Pop back** edit the sequence. **Resize** changes its length; **Fill** replaces existing cells with one value.

**Dump** sends the complete list on Output. **Front**, **Back**, **Size** and **All** expose the current sequence. Hold **Clear** to empty it. Invalid reads produce an invalid value rather than an out-of-range cell.

## Table (2D)

**Read** takes `[row, column]`; **Set cell** takes `[row, column, value]`. **Read row** and **Read column** emit lists on **Row** and **Column**. Set, append, insert, erase and clear operations are available for rows and columns. **Resize** takes `[rows, columns]`; **Transpose** exchanges the axes. **Rows**, **Columns** and **Size** report dimensions and total cell count. **Dump** sends the complete nested table through Output.

## Table (N dimensions)

Set **Dimensions**, then **Resize** with one extent per dimension. Read and Clear cell take an index list; Set cell takes those indices followed by the value. **Shape**, **Size**, **Fill**, **Clear** and **Dump** provide inspection and bulk operations. The maximum supported dimensionality depends on the build (four with GCC, sixteen otherwise).

## Availability and limitations

Some compiler-constrained builds omit all table processes. Although **Lock** and **Preserve** controls are currently exposed, the implementations do not implement write locking or saved-content persistence through those controls. Do not rely on them to protect or archive data. Use [CSV recorder]({{ site.baseurl }}/processes/csv-recorder.html) for device recording or [Value serialization]({{ site.baseurl }}/processes/value-serialization.html) for structured interchange.
