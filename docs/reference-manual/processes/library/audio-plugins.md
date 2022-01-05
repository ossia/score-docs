---
layout: default

title: Audio plugins
description: "Using external audio plug-ins in ossia score"

parent: Processes
grand_parent: Reference

permalink: /processes/audio-plugins.html
---

# Audio plug-in support

![Audio plugins]({{ site.img }}/reference/processes/vst.png "VST example")

Plug-ins can simply be dropped from the [process library]({{ site.baseurl }}/panels/library.html "Library panel")), under the Audio section, into the main view.

If the plug-in has a custom UI, it is possible to make it show up with the small "window" icon on the plug-in header.

For plug-ins with many controls, controls won't show up by default in the *score* user interface. When changed from the plug-in UI, if any, will show up in score and be automatable. The little "x" allows to remove an unwanted parameter.

# Common formats: VST, VST3, LV2, JSFX

Common plug-in formats are supported: 

- VST 2.4 on all platforms.
- VST 3 on all platforms.
- LV2 on Linux. It is yet not shipped in the official releases, score needs to be built for source for LV2 support (or be used as a distribution package)
- JSFX on all platforms.

Plug-ins are started automatically on startup. If for some reason this must be disabled, because the scanning process causes issues, one can set the `SCORE_DISABLE_AUDIOPLUGINS=1` environment variable.
Already scanned plug-ins will still be available for VST and VST3.

It is possible to save and reload presets ; however the built-in VST presets are not supported yet.

VST2 plug-ins can be rescanned from the preferences.

# Controlling VST parameters

To be able to automate and connect VST parameters to other parts of the session, it is necessary to make them visible in the nodes.
For plug-ins with less than a dozen parameters, they will always be shown by default. For plug-ins with more parameters, this is 
however opt-in.

![VST inspector UI]({{ site.img }}/reference/processes/vst-icon.png "VST control UI icon")

The first button allows to show / hide the audio plug-in UI. The second, when enabled, means that the plug-in's parameters
will be checked for changes: whenever a value changes, it will appear in the score UI and be open to automation, etc.

Here is the complete procedure:

![Controlling VST parameters]({{ site.img }}/reference/processes/vst-params.gif "VST parameters")

This is currently only implemented for VST2, other plug-in APIs have all their parameters shown until the feature is implemented there too.

# Advanced plug-in and extensions formats

It is also possible to use less common systems for audio processing:
* [Faust DSPs]({{ site.baseurl }}/processes/faust.html "Faust")
* [Pure Data patches]({{ site.baseurl }}/processes/puredata.html "Pure Data")
* [Javascript]({{ site.baseurl }}/processes/javascript.html "Javascript")
* [Math expressions]({{ site.baseurl }}/processes/exprtk.html "ExprTK")
* [Custom C++ plug-ins]({{ site.baseurl }}/processes/cpp_jit.html "C++ JIT")

Some of these plug-in systems, like Faust are source-based: that is, *score* will compile the source code of the plug-in directly, which can take a few seconds when dropping the plug-in in the session.

Preset support for these plug-ins is a work-in-progress.