---
layout: default
title: RE2 regular expressions
description: "Pattern syntax, capture groups and replacement expressions for text processing."
parent: Languages
grand_parent: Reference
nav_order: 15
permalink: /reference/languages/regex.html
---

# RE2 regular expressions

The [[Regex]] process uses RE2 patterns to recognize parts of text. A pattern is not JavaScript, ExprTK or a shell command. The [upstream RE2 syntax reference](https://github.com/google/re2/wiki/Syntax) lists the complete supported syntax and explicitly marks unsupported PCRE, Perl and Vim features.

## Pattern vocabulary

| Pattern | Meaning |
|---|---|
| `abc` | The literal sequence `abc`. |
| `.` | Any character except newline, unless the relevant flag is enabled. |
| `[0-9]`, `\d` | An ASCII digit. |
| `[^,]` | Any character other than a comma. |
| `x*`, `x+`, `x?` | Zero or more, one or more, or an optional occurrence. |
| `x{2,4}` | Between two and four occurrences. |
| `^`, `$` | Start and end of the input, or a line in multiline mode. |
| `(pattern)` | A numbered capture group. |
| `(?P<name>pattern)` | A named capture group. |
| `(?:pattern)` | Group without capturing. |
| `\.` | A literal dot rather than the wildcard. |

Alternatives use `|`, for example `red|green`. Parentheses group alternatives: `^(red|green)$` matches one of those complete words. RE2's `\d`, `\s` and `\w` shorthand classes are ASCII-based; use its documented Unicode classes when matching other scripts.

## Captures in score

Enter `(?P<temperature>\d+)` directly in the process's **Pattern** field to capture an unsigned integer under the name `temperature`. **Numbers** converts numeric captures into numeric values. The process exposes up to 64 capture outlets and preserves named outlet identities when groups are reordered.

**Search** looks for a match within the input; **Match** requires the whole input. **SearchAll** produces all matches. The process's **Ignore case** and **Multiline** controls affect matching without changing the pattern text. See the [process outputs]({{ site.baseurl }}/processes/regex.html#outputs) for how each mode emits groups and match results.

## Replacement syntax

In score's **Replacement** field, `\0` means the whole match and `\1` through `\9` refer to captured groups. The score process also accepts `$1` and `%1` notation. These are replacement references, not backreferences inside a pattern. **Global** chooses whether Replace changes every match or just the first one.

For example, use pattern `(\d+),(\d+)` and replacement `\2,\1` to exchange two comma-separated unsigned integers. Enter the backslashes as shown in the text fields. If generating these strings from JavaScript or another language, also apply that language's string-literal escaping rules.

## Limits and errors

RE2 does not support pattern backreferences or look-around. An expression copied from a PCRE or JavaScript regex tester may therefore be rejected even if it works there. Invalid patterns and replacement errors appear at the process's **Error** outlet. Use [[Switch]] rather than a regex when the task is simply routing exact values.
