---
layout: default

title: Presets
description: "How to save and load presets of processes"

parent: In depth

permalink: /presets.html
---

# Presets

## Process presets

Process presets save reusable settings for a process or effect. They are available
in the middle section of the [Process library]({{ site.baseurl }}/panels/library.html)
when the corresponding process is selected.

1. Configure a process in the score.
2. Drag its preset/folder handle into the preset list to save a preset.
3. The preset is written as a `.scp` file beneath
   `<library-root>/packages/user/presets/<process>/`; effects such as individual
   audio plug-ins can have an additional effect-name subfolder.
4. Drag the saved preset into a score to create a configured process. Double-clicking
   a preset uses the library's effect-chain creation workflow: it adds and connects
   the process to the selection where possible.

You can also drag the preset handle into a chosen system-library folder to save at
a specific location. Keep personal presets outside downloaded package folders so
package updates do not overwrite them. A preset does not install the process or
third-party plug-in it depends on.

Supported file-based library entries use nested folder
categories. Preset `.scp` metadata can also contain an optional `Description` string,
shown as a tooltip in the preset list. Older presets without it remain usable.

## Scenario presets

1. Select a part of the score.
2. Drag it with  {% include shortcut.html content="Alt" %} pressed into the user library, in some folder.
3. The selected part is now saved on the disk, in a `.scenario` file.
4. Drag the `.scenario` file from the library back into the score to reuse it.