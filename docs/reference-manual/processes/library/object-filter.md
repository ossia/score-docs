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

This object implements a subset of the [jq](https://stedolan.github.io/jq/) syntax, which is a small and very straightfoward language to filter objects in a complex hierarchy involving lists, dictionaries (maps), strings, numbers, etc.

For instance: given this object (using Javascript syntax: `[1, 4, "foo"]` is a list, `{ "a": 123, "b": 456 }` is a map):

```js
[
  1, 
  2, 
  sl.value, 
  [ 
    [ sl.value, 0.6 ], 
    "foo", 
    [ true, false, true, false ]
  ],
  "hiii",
  ["hello", 123, "foo", 456],
  { "test": 123, "another": "variant"}
]
```

The jq program: `.[6].test` will give `123`.

Given:

```js
{
    "foo": [
      { "bar": 1 },
      { "bar": 3 },
      { "bar": 4 },
      { "bar": 2 },
      { "bar": 5 },
      { "bar": 2 }
     ]
}
```

Then `[ .foo[2:5].bar ]` will give as output the list `[4, 2, 5]`.

## Supported syntax and example programs

```ruby
## The dot just copies the entire input to the output
# Example: [ 123, "foo" ] -> [ 123, "foo" ]

.

## Iterates through all the values of an array or map
# Example: [ 123, "foo" ] -> first the value 123 is output, then the value "foo"
# Example: { "a": 123, "b": 456 } -> first the value 123 is output, then the value 456

.[]

## Selects an element of an array
# Example: [ 123, 456 ] -> 123
.[0]

# Example: [ 123, 456 ] -> 456
.[1]


## Selects multiple elements of an array
# Example: [ 123, 456, 789 ] -> [123, 789]
[ .[0, 2] ]

## Selects a range of elements of an array
# Example: [ 123, 456, 789, 10 ] -> [456, 789, 10]
[ .[1:3] ]

## Put the values in an array
[ (expression) ]

# Example: [ 123, 456 ] -> [ [ 123, 456] ]
[ . ]

# Example: [ 123, 456 ] -> [ 123, 456 ]
[ .[] ]

# Example: { "a": 123, "b": 456 } -> [ 123, 456 ]
[ .[] ]

## Select a member of an object
.member_name

# Example: { "a": 123, "b": 456 } -> 456
.b

# Example: { "a": 123, "b": [ { "foo": "x", "bar": "y" } ] } -> "x"
.b[0].foo


## Sequence operations one after each other
(expression 1) | (expression 2)

# Example: 
# [ { "name": "Shashimi", "age": 6 }, { "name": "Flocky", "age": 3 } ] 
# -> ["Shashimi", "Flocky"]
[ .[] | .name ]

```