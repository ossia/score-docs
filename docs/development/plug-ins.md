---
layout: default

title: "Plug-ins"
description: "Writing ossia score plug-ins in C++"

parent: Development

permalink: /development/plug-ins.html
---

# Prerequisites

This guide assumes that a development environment with all required dependencies has been set-up.
Check [the "hacking on score" guide]({{ site.baseurl }}/development/build/hacking.html) for more information on
how to do that.

# Choosing the plug-in API to use

*ossia score* provides two plug-in APIs:

## Fx API
A simple API that can be used to implement quick audio / midi / control effects and generators in a single file.

Processes implemented with that API are available [at the following address](https://github.com/ossia/score/tree/master/src/plugins/score-plugin-fx/Fx).

To create a new plug-in, simply duplicate one of the files, change the metadata (name, UUID, etc. to differentiate it from other score plug-ins),
and add it to the list in [this file](https://github.com/ossia/score/blob/master/src/plugins/score-plugin-fx/score_plugin_fx.cpp).

When building score again, the plug-in should appear in the process list.

A video explains the whole process:

<div class="videoWrapper">
    <iframe src="https://www.youtube.com/embed/LSifHFbuky0" frameborder="0" allow="autoplay; encrypted-media; picture-in-picture" allowfullscreen></iframe>
</div>


## Score API
A more advanced API that allows to customize pretty much every aspect of the software, but requires more work.

The major part of the software *is* built with that API: every process in *score* comes from plug-ins.
These plug-ins are located [in the score git repository](https://github.com/ossia/score/tree/master/src/plugins).

The [addon tutorial](https://github.com/ossia/score-addon-tutorial) is an example of usage of the score API to
showcase its capabilities.
It is [documented here](https://github.com/ossia/score-addon-tutorial/tree/master/ReadMe).

To develop new plug-ins that way, we provide a [set of Github templates](https://github.com/ossia-templates).
Simply create a repository from the template, and follow the steps in the README.