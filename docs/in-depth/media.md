---
layout: default

title: Media management
description: "How media files are handled by ossia score"

parent: In depth

permalink: /in-depth/media.html
---

# Media management

## Paths to media

If the path to a media is relative, it will looked for in the project folder first.
The project folder is the folder which contains the saved `.score` file.

Special information in paths can also influence where the file is searched:

    <PROJECT>:/foo/bar

will look in the project directory.

    <LIBRARY>:/foo/bar

will look in the user library.
