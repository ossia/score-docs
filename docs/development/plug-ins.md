---
layout: default

title: Plug-ins
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

Avendish also covers dynamic ports, file/folder controls, GPU processing and custom control layouts. Some newer interfaces, notably scene ports, are specific to score's binding: consult the [score integration guide]({{ site.baseurl }}/development/plugins/plugins-with-avendish.html#ports-scheduling-and-layouts) and upstream binding-support notes before targeting another host.

## Score API
A more advanced API that allows to customize pretty much every aspect of the software, but requires more work.

The major part of the software *is* built with that API: every process in *score* comes from plug-ins.
These plug-ins are located [in the score git repository](https://github.com/ossia/score/tree/master/src/plugins).

The [addon tutorial](https://github.com/ossia/score-addon-tutorial) is an example of usage of the score API to
showcase its capabilities.
It is [documented here](https://github.com/ossia/score-addon-tutorial/tree/master/ReadMe).

To develop new plug-ins that way, we provide a [set of Github templates](https://github.com/ossia-templates).
Simply create a repository from the template, and follow the steps in the README.

# Loading and distributing add-ons

An add-on can be compiled with score, built separately against a matching exported score SDK, or compiled from source at run time by a JIT-enabled desktop build. These are different workflows, not interchangeable binary formats.

- Match the application build, operating system, architecture and compiler ABI when distributing a binary. The score header SDK (`SCORE_SDK`) and compiler/dependency SDK (`OSSIA_SDK`) serve different purposes.
- Install complete packages, including their manifests, in the configured **Packages** directory. Restart after replacing a binary; Windows requires closing the application before overwriting a loaded DLL.
- Current development builds support the LLVM/MinGW Windows run-time add-on compiler as well as desktop Linux/macOS paths. This does not imply MSVC ABI compatibility or availability in every package.
- Run-time compilation executes native code in the application: only load source and binaries you trust.

See [building and compiling Avendish add-ons]({{ site.baseurl }}/development/plugins/plugins-with-avendish.html) for SDK setup and the `--compile-node` / `--compile-addon` developer commands. Writing a full application extension still requires the score API; an Avendish processor does not replace that API.