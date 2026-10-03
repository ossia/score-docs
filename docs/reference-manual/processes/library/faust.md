---
layout: default

title: Faust
description: "Using Faust in ossia score"

parent: Processes
grand_parent: Reference

permalink: /processes/faust.html
---

# Faust

![Faust]({{ site.img }}/reference/processes/faust.png "Faust")

[Faust](https://faust.grame.fr) is a domain-specific programming language, tailored for writing digital signal processing code, for instance audio effects and synthesizers, super easily.

It is mainly developed at [Grame](https://grame.fr), with an international community of contributors.

Faust DSP files can be drag'n'dropped directly inside a score. This will compile the DSP and embed it as a signal processor in the score.
Additionally, any `.dsp` file found recursively in the library folder will be detected and added under the `Faust` section in the [[Library|process library]].

Faust code can be edited directly from within the user interface, by clicking on the small "window" icon on the node header. One must press "Compile" when the code is ready to update it to the audio engine.

## Ports and controls

The DSP determines the number of audio channels. Faust sliders, numeric entries, buttons and checkboxes become score controls, so the process interface changes with the compiled program. A synthesizer using the conventional `freq`, `gain` and `gate` controls is detected as MIDI-driven; a normal effect processes its audio input instead.

## Imports and portable projects

When a `.dsp` file is loaded, score embeds its source text in the document and remembers the original file's directory as an additional import search path. For example, an `import("my-library.lib");` can resolve a library beside that DSP file. Editing the embedded code is not the same as editing the original file on disk.

Current development builds save this **import directory relative to the score library or project where possible**, and resolve it again when loading. This lets a project or library move without unnecessarily retaining the old machine's absolute path. Imports still need the referenced files: embedding the DSP does not embed every imported `.lib`.

Keep local Faust libraries with the project, or install them as a score package on every machine that opens it. The project media tools report the import folder as an external dependency, but do not automatically collect or rewrite the whole Faust library tree. When using **Save as**, verify imports still resolve if the destination no longer contains the same files.

`FAUST_LIB_PATH` can override the bundled Faust library location; see [command-line and environment options]({{ site.baseurl }}/reference/commandline.html). Compilation requires a build with Faust support and a usable library search path, not just the presence of the `.dsp` file.

# Important links

* [Faust website & docs](https://faust.grame.fr)
* [User library](https://github.com/ossia/score-user-library/tree/master/Presets/Faust)

# Video tutorial

<div class="videoWrapper">
    <iframe src="https://www.youtube.com/embed/yvTjJMrFxR0" frameborder="0" allow="autoplay; encrypted-media; picture-in-picture" allowfullscreen></iframe>
</div>


# Faust packages

It is possible to provide new Faust libraries as score packages.

This is done for instance with Alain Bonardi's [abclib](https://github.com/alainbonardi/abclib) which is packaged [here](https://github.com/jcelerier/abclib) : most importantly, the `library` folder in such a package will be added to the Faust library path so that new functions can be provided.