---
layout: default
title: Project files
description: "Collect, relink, archive and clean up a score project's media"
parent: Reference
permalink: /reference/project-files.html
---

# Project files

The current development build provides **File → Project files** for managing files referenced by the open document. Save each project in its own folder before collecting or cleaning media. These commands inspect dependencies reported by processes and devices; they are not a search through arbitrary script text or a replacement for a backup.

## Paths and moving a project

The project folder is the folder containing the saved document. References can be absolute, project-relative (`<PROJECT>:Audio/kick.wav`), or user-library-relative (`<LIBRARY>:...`). See [Media management]({{ site.baseurl }}/in-depth/media.html) for resolution rules.

When **Save As** changes folders and the document has project-relative references, score asks whether to copy its media to the new folder. **Yes** collects into the new folder; **No** leaves files in place and changes these references to absolute paths. No therefore preserves playback on this machine, not portability. Scripted saves without a window use the latter behavior.

## Consolidate project

Choose **Consolidate project...**, inspect the report, then press **Consolidate**. The dialog previews files, destinations and problems before writing.

- **Method → Copy the files** makes independent copies. Originals are not moved or deleted; existing destinations are not overwritten. Identical content can be reused and conflicting names receive distinct destinations.
- **Symbolic links** depend on the original location. **Hard links** require a compatible filesystem and share file contents. Prefer copies for handoff; do not treat links as an independent backup.
- **Also collect files from the user library** is off by default. Enable it if the receiving computer will not have the same library content.
- **Sort into Audio/, Video/, Images/...** groups files by kind and is on by default. Other categories include MIDI, models, shaders, scripts and data.
- **Keep the name of the source folder** retains an extra directory level, useful for similarly named samples from different collections.

Supported kit references can declare companion samples. These are collected with their relative layout instead of copying only the kit description. This depends on the process exposing those dependencies: it does not discover every file a script or external plug-in might open.

The reference changes form an undoable document command, and score saves after consolidation. Disk copies remain if the reference changes are undone. Missing files and unsupported dependencies are reported; failed copies keep their old references. Plug-ins and folder dependencies may still need installing or transferring separately. Remote streams are not local media to collect.

## Locate missing files

**Locate missing files...** also opens automatically after loading a document with missing dependencies. The document remains open while you repair it.

1. Choose **Search a folder...** to search that directory and its descendants for matching filenames. The search can be cancelled.
2. Inspect **Used by**, **Missing file** and **Found at**. Multiple candidates can have the same name: check the location rather than assuming the first match is correct.
3. Select a row and use **Locate...** to choose its replacement explicitly.
4. Press **Relink** to apply the candidates, then save the document.

Searching alone changes nothing. Network URLs are not reported as missing local files. A relink can only update a reference that the owning process or device exposes for rewriting.

## Remove unused files

**Remove unused files...** finds files in the project folder that the current document no longer references. By default it searches only the media folders created by consolidation, not every render, note or collaborator's file alongside the score.

Review the list and untick anything to keep. The default **Move them to the Unused folder** preserves their relative layout under `Unused/`; restoring them requires moving them back with a file manager. **Delete them** is permanent and prompts for confirmation: score's Undo does not restore deleted files.

The whole-project-folder option broadens the search and needs extra care. The operation refuses files outside the project folder and score documents. Nevertheless, “unused” means unused by dependencies score knows about in **this** document. Read warnings about missing references and other documents sharing the folder; resolve missing media and back up shared projects before cleanup.

## Shorten media files to what is played

**Shorten media files to what is played...** is different from removing unused files: it shortens media that is still in use. The current audio trimmer writes a new 32-bit floating-point WAV at the source sample rate, beside the original under a new name, and adjusts references and offsets together.

- **Keep extra** retains handles on either side of the used region (two seconds initially).
- All known readers of a file contribute to the retained span. Unbounded readers, references that cannot be rewritten, companion samples and files within a referenced folder can prevent trimming.
- Only files inside the project folder qualify. Consolidate external media first.
- Files that are almost entirely used, have unknown duration or would not save enough space are left alone. Decoding compressed audio to WAV can increase its size; this is not a general audio/video compression command.
- **Delete the untrimmed files afterwards** is off by default. Leave it off to retain recovery and Undo's source files. Unreferenced originals do not travel in the project archive and can be cleaned up later.

Inspect the per-file reasons and estimated saving before pressing **Trim**. References are undoable and the document is saved afterwards; deletion of original media is not reversible through Undo.

## Archive project

**Archive project...** consolidates with the default copy settings, saves the document, then writes a ZIP containing the document and its known referenced files within the project folder, including declared companion samples. It is not a ZIP of every file in the folder: unrelated material and unused originals are omitted.

Library collection is **off** in the archive command's default consolidation. For a portable handoff, first consolidate manually with **Also collect files from the user library**, repair missing files and review external dependencies. The archive completion message warns about missing files and dependencies such as plug-ins or folders that must be installed separately.

In the browser, archiving produces a download and can include an unsaved document. It can only include media available to the browser's filesystem; it does not gain access to the desktop's files. See [Using score in the browser]({{ site.baseurl }}/quick-start/using-score-in-the-browser.html).
