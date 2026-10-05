---
layout: default

title: Plug-ins
description: "Writing ossia score plug-ins in C++"

parent: Development
has_children: true

permalink: /development/plug-ins.html
---

# Prerequisites

Set up a [development build]({{ site.baseurl }}/development/build/hacking.html) first.

# Choosing the plug-in API to use

ossia score provides two plug-in APIs.

## Avendish API

Use [Avendish](https://celtera.github.io/avendish) for audio, MIDI, control, video and GPU processors. A processor can fit in a single C++ header and can also target other hosts, such as VST.

Read the [[Plug-ins with Avendish|score avendish plug-in documentation]] to get started.

Avendish also covers dynamic ports, file/folder controls, GPU processing and custom control layouts. Some interfaces, notably scene ports, are specific to score's binding: consult the [score integration guide]({{ site.baseurl }}/development/plugins/plugins-with-avendish.html#ports-scheduling-and-layouts) and upstream binding-support notes before targeting another host.

## Score API
The score API extends the editor, processes, protocols and other application services. Most of score itself uses this API; see the [built-in plug-ins](https://github.com/ossia/score/tree/master/src/plugins).

The [add-on tutorial](https://github.com/ossia/score-addon-tutorial) and its [documentation](https://github.com/ossia/score-addon-tutorial/tree/master/ReadMe) introduce the API. Start a project with one of the [GitHub templates](https://github.com/ossia-templates) and follow its README.

# Loading and distributing add-ons

Compile an add-on with score, build it separately against the matching score build's exported headers, or let score's JIT compiler load its source at run time.

The ossia SDK (`OSSIA_SDK`) supplies compilers and dependencies for building score. The score SDK supplies the headers used by run-time JIT add-ons; external CMake builds access those exported headers through `SCORE_SDK`.

Install the package and manifest in the configured Packages directory. Restart after rebuilding a binary; on Windows, close score before replacing a loaded DLL. Binary packages must match the application build, operating system, architecture and compiler ABI.

Official Windows builds use llvm-mingw. MSYS2 CLANG64 is the development alternative. MSVC is supported for exceptional Qt WebEngine builds, not official releases.

See [Avendish add-ons]({{ site.baseurl }}/development/plugins/plugins-with-avendish.html) for SDK setup and the `--compile-node` and `--compile-addon` commands.