---
layout: default

title: "Plug-ins"
description: "Writing ossia score plug-ins in C++"

parent: Development
has_children: true

permalink: /development/plug-ins.html
---

# Prerequisites

This guide assumes that a development environment with all required dependencies has been set-up.
Check [the "hacking on score" guide]({{ site.baseurl }}/development/build/hacking.html) for more information on
how to do that.

# Choosing the plug-in API to use

*ossia score* provides two plug-in APIs:

## Avendish API
A simple API that can be used to implement quick audio / midi / control effects and generators in a single file.

This is the API to use if you want to provide for instance a new audio or video processor to use as an ossia object.

The documentation of the Avendish API is available [here](https://celtera.github.io/avendish): note in particular 
that the plug-ins written with Avendish are independent from ossia score and can also be exported to other systems, such as VST, etc.
ossia score is however the implementation that provides most of the features :-)

Read the [[Plug-ins with Avendish|score avendish plug-in documentation]] to get started.

## Score API
A more advanced API that allows to customize pretty much every aspect of the software, but requires more work.

The major part of the software *is* built with that API: every process in *score* comes from plug-ins.
These plug-ins are located [in the score git repository](https://github.com/ossia/score/tree/master/src/plugins).

The [addon tutorial](https://github.com/ossia/score-addon-tutorial) is an example of usage of the score API to
showcase its capabilities.
It is [documented here](https://github.com/ossia/score-addon-tutorial/tree/master/ReadMe).

To develop new plug-ins that way, we provide a [set of Github templates](https://github.com/ossia-templates).
Simply create a repository from the template, and follow the steps in the README.

## (deprecated) Fx API
A simple API that can be used to implement quick audio / midi / control effects and generators in a single file.
Replaced by the Avendish API which is strictly superior in all points.

Processes implemented with that API are available [at the following address](https://github.com/ossia/score/tree/master/src/plugins/score-plugin-fx/Fx).

To create a new plug-in, simply duplicate one of the files, change the metadata (name, UUID, etc. to differentiate it from other score plug-ins),
and add it to the list in [this file](https://github.com/ossia/score/blob/master/src/plugins/score-plugin-fx/score_plugin_fx.cpp).

When building score again, the plug-in should appear in the process list.
