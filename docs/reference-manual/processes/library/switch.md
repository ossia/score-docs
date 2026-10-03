---
layout: default
title: "Switch"
description: "Route control events to editable literal cases"
parent: Processes
grand_parent: Reference
permalink: /processes/switch.html
---

# Switch

Switch routes each **Input** event to the first matching row of **Cases**. Each row creates an outlet; events matching none go to **Unmatched**. Reordering rows preserves their cable identities but changes first-match precedence.

Cases accept numbers, `true`, `false`, `null` (an impulse), or strings with optional quotes. Use quotes to distinguish the string `"123"` from the number `123`, or `"true"` from a boolean. Numeric values compare numerically; strings and booleans do not coerce to numbers. Blank rows and unsupported literals do not match.

Use this to route named cues, state identifiers or sensor modes. For selection by an index instead, see Mux inlets and Demux outlets in [Mapping utilities]({{ site.baseurl }}/processes/mapping-utilities.html).
