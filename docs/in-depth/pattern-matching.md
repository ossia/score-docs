---
layout: default

title: Pattern matching
description: Using address patterns to match multiple addresses easily

parent: In depth

permalink: /in-depth/pattern-matching.html
---

# Pattern matching

It is possible to control a set of addresses with pattern matching.

For instance, given the following OSC device:

![An OSC device with repeated parameters]({{ site.img }}/in-depth/pattern-match.png)

It is possible to send an automation to

```
OSCdevice:/sub/*/level
```

to control all the levels with a single curve.

> The complete reference of the supported pattern matching syntax is available [here](https://ossia.io/ossia-docs/#pattern-matching).

## Examples

* `device:/foo/bar`
  * Matches `device:/foo/bar` and nothing else
 
* `device:/foo/bar*`
  * Matches `device:/foo/bar`, `device:/foo/bar.100`, `device:/foo/baron`
 
* `device:/{foo,boo}/bar`
  * Matches `device:/foo/bar`, `device:/boo/bar`

* `device:/foo.{5..23}`
  * Matches `device:/foo.5`, `device:/foo.6`, ... to `device:/foo.23`
  * Won't match `device:/foo.230`
 
* `device:/foo.{5..23..7}` 
  * Matches `device:/foo.5`, `device:/foo.12`, `foo.17`

* `device:/foo[a-z]`
  * Matches `device:/fooa`, `device:/foob`, ... `device:/fooz`

* `device:/foo[1-5]`
  * Matches `device:/foo1`, `device:/foo2`, ... `device:/foo5`

* `device://bar` 
  * Matches `device:/foo/bar`, `device:/foo/bar.123/bar`, etc.

* `device://bob/../foo`
  * Given `device:/foo/bob` and `device:/foo/bar.123/bob`, matches `device:/foo`

* `device:/foo!`
  * Matches `device:/foo`, `device:/foo.1`, `device:/foo.123`, `device:/foo.bob`
