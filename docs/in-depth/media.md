---
layout: default

title: Media management
description: "How media files are handled by ossia score"

parent: In depth

permalink: /in-depth/media.html
---

# Media management

## Paths to media

The project folder is the folder containing the saved score document. A plain relative path is resolved against that folder; it is not a recursive search for a matching filename. An unsaved document has no project folder, so save before relying on portable relative paths.

Stored paths can explicitly name one of two roots:

| Path | Root |
|---|---|
| `<PROJECT>:Audio/kick.wav` | The saved document's folder |
| `<LIBRARY>:...` | The configured user library root |
| An absolute path | That location on the local filesystem |

The library root comes from score's library settings, not necessarily the same location on another machine. A remote stream URL is not a local file to collect or relink. Qt resource URLs used by custom application code are also distinct from these project and library path tokens.

## Collecting and repairing media

The current development build groups media operations under **File → Project files**. Use **Consolidate project...** to copy known dependencies into the project and rewrite their references, or **Locate missing files...** to repair broken references. **Archive project...** produces a ZIP of the document and known referenced project media rather than every file beside it.

When **Save As** moves a document to a different folder, score asks whether to copy project-relative media. Declining keeps media at its original location through absolute references: it does not make a portable copy.

See [Project files]({{ site.baseurl }}/reference/project-files.html) for library and kit/sample dependencies, reports, archiving, audio trimming and the safeguards and limitations of unused-file cleanup.
