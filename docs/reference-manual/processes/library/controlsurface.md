---
layout: default
title: Control surface

parent: Processes
grand_parent: Reference manual

permalink: /docs/reference-manual/processes/controlsurface.html
---

- Drop addresses on it
- It's now possible to control them from the score directly through the UI
  when this specific process is running.


## Remote control API

The control surface process provides remote control features, through the system discussed in [Remote Control](remote-control.html).
When such a process starts executing, the following message is sent:

{% highlight js %}
{
    "Message": "ControlSurfaceAdded",
    "Path": "/path/to/the/surface",
    "Controls": [ ... list of control objects... ]
}
{% endhighlight %}


When the process ends, the following message is sent:
{% highlight js %}
{
    "Message": "ControlSurfaceRemoved",
    "Path": "/path/to/the/surface"
}
{% endhighlight %}

### Controls

A control object defines a given control and has the following format.

{% highlight js %}
{
    "Custom": "The name of the control",
    "Domain": { ... domain object ... },
    "Value": { ... value object ... },
    "id": 1234, // the identifier of the individual control
    "uuid": "af2b4fc3-aecb-4c15-a5aa-1c573a239925" // the identifier of the control kind
}
{% endhighlight %}


The remote can send the following message to change a parameter in score:
{% highlight js %}
{
    "Message": "ControlSurface",
    "Path": "/path/to/the/surface",
    "id": 1234,   // the id of the individual control that changed
    "Value": { ... the value object ... }
}
{% endhighlight %}

### Value object
The `Value` object has the following format:

{% highlight js %}
{
    "TYPE": VALUE
}
{% endhighlight %}

Where `TYPE` can be any of `Int`, `Float`, `Bool`, `String`, `Char`, `Vec2f`, `Vec3f`, `Vec4f`, `Tuple`, `Impulse`.

For instance, valid values are:

{% highlight js %}
{ "Float": 1.23456 }
{ "Int": 127 }
{ "String": "hello world" }
{ "Vec2f": [0.5, 1.54] }
{ "Bool": true }
{ "Impulse": 1 }
{ "Tuple": [ { "Float": 1.234}, { "String": "hello" } ] }
{% endhighlight %}

### Domain object
The `Domain` object has the following format:

{% highlight js %}
{
    "TYPE": {
        "Min": THE_MIN,
        "Max": THE_MAX
    }
}
{% endhighlight %}

where `TYPE` is the same than above. The most common cases are of course Int and Float as it does not really make sense for bools, etc.

Example to have a slider that goes from -10 to 100:

{% highlight js %}
{
    "Float": {
        "Min": -10
        "Max": 100
    }
}
{% endhighlight %}


It is also possible to define a domain through a set of acceptable values instead of a range:
{% highlight js %}
{
    "TYPE": {
        "Values": [ ... array of acceptable values ...]
    }
}
{% endhighlight %}