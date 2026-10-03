---
layout: default
title: "Regex"
description: "Match, extract, replace and split text using RE2"
parent: Processes
grand_parent: Reference
permalink: /processes/regex.html
---

# Regex

Regex processes each **Input** event as text. Numbers and lists are converted to text; an impulse processes the previous input again.

## Pattern and modes

Enter an RE2 expression in **Pattern**. **Search** finds the first match anywhere, **Match** requires the whole input to match, and **SearchAll** finds all matches. **Replace** substitutes **Replacement**; **Global** chooses all matches rather than just the first. **Split** returns the pieces between matches.

**Ignore case** changes letter matching. **Multiline** makes `^` and `$` refer to each line. **Numbers** converts numeric capture groups to numeric values.

For example, `(?P<temperature>\d+)` creates a named **temperature** capture outlet. Connect it to a numerical mapping with Numbers enabled. Up to 64 capture outlets are exposed. Named groups retain their outlet identities when the pattern is reordered, helping preserve cables.

## Outputs

| Output | Meaning |
|---|---|
| Match | Matched text; list of matches in SearchAll; replacement text in Replace; pieces in Split |
| Groups | Capture list in Search/Match, or one capture list per match in SearchAll |
| Named / numbered capture outlets | Captured values in Search/Match; one event per match in SearchAll |
| Matched | Boolean result for each processed input |
| Unmatched | Original input when no match is found |
| Error | Invalid-pattern or replacement explanation; empty string when valid again |

Replacement accepts `\0` for the whole match and `\1`–`\9` for groups; `$1` and `%1` also work. Replace and Split do not emit capture-group outputs. A missing optional group does not emit on its individual outlet.

RE2 does not support pattern backreferences or look-around. Use [Switch]({{ site.baseurl }}/processes/switch.html) for exact value routing rather than text patterns.
