---
layout: default

title: Files and utilities API
description: "Filesystem helpers, time conversions, dialogs and environment access"
parent: Scripting API
grand_parent: In depth
permalink: /in-depth/scripting-api/utilities.html
---

# Files and utilities API

[Back to the Scripting API]({{ site.baseurl }}/in-depth/scripting-api.html) · [Examples]({{ site.baseurl }}/in-depth/scripting-api/examples.html#files-and-utilities)

`Util` is available to console and JavaScript process engines. Availability does not make blocking file access, shell commands or GUI dialogs appropriate inside an audio callback. Perform setup outside `tick`; use native dialogs from GUI-thread code.

## Files and paths

| Function | Behavior |
|---|---|
| `fileExists(path)`, `isFile(path)`, `isDir(path)` | Test existence and kind. |
| `canReadFile(path)`, `canWriteFile(path)` | Check filesystem access. |
| `readFile(path)` | Read bytes. Convert textual results with `.toString()` where needed. |
| `writeFile(path, bytes)` | Write file content; this is not an undoable operation. |
| `makeDir(path)` | Create a directory and missing parents; return whether it exists afterwards. |
| `removeFile(path)` | Remove a file; true if it is gone, including if absent already. Does not remove directories. |
| `listFiles(path, filters)` | Absolute paths of files matching glob filters, e.g. `"*.scp;*.json"`; `""` includes all files. |
| `listDirectories(path)` | Absolute paths of immediate child directories. |
| `urlToLocalFile(url)` | Convert a local-file URL into a filesystem path. |
| `imageSize(path)` | Return image dimensions. |
| `environmentVariable(name)` | Read an environment variable. |

File helpers resolve score's `<LIBRARY>:` and `<PROJECT>:` prefixes. For document-aware conversion, `Score.locateFilePath(path)` resolves a stored path and `Score.relativizeFilePath(path)` converts an absolute path for storage. `Score.readFile(path)` returns text rather than the utility's byte array.

```js
var files = Util.listFiles("<PROJECT>:/", "*.json");
for (var i = 0; i < files.length; ++i)
  console.log(files[i]);
console.log(Util.environmentVariable("HOME"));
```

Do not confuse these prefixes with a QML component's base URL. A file-backed JavaScript process keeps its source location for relative imports and resources; see [Javascript]({{ site.baseurl }}/processes/javascript.html#files-relative-resources-and-presets).

## Asynchronous native dialogs

```js
Util.openFileDialog("Choose data", "JSON files (*.json)", "", function(path) {
  if (path !== "") console.log(Util.readFile(path).toString());
});
```

- `openFileDialog(title, filters, folder, onAccept)` selects a file.
- `saveFileDialog(title, filters, folder, defaultName, onAccept)` selects a save path; the callback must write the file.
- `openColorDialog(title, initialColor, onAccept)` selects an RGBA color and returns `#AARRGGBB` on acceptance.

Callbacks receive `""` on cancellation. Dialogs are owned by the active editor/output window, with the main window as fallback. If the owner is destroyed, the dialog is removed without calling back. Keep the script engine alive until completion; these functions do not synchronously return the chosen value.

## Time

`Util.toSeconds(value)`, `toMilliseconds(value)` and `toTime(value)` convert model time values; `isInfinite(value)` tests infinity. `timevalFromMilliseconds(ms)` constructs a time value. Raw model dates and durations use flicks (705,600,000 per second), while `Score.scrub` and `Score.playFromHere` use milliseconds.

`timestamp()` returns seconds from a monotonic clock, useful for measuring elapsed time; it is not the position of score's transport or a calendar timestamp.

## Other helpers

- `uuid()` generates a UUID string.
- `layoutTextLines(text, font, pointSize, maxWidth)` inserts line breaks using a simple text-layout algorithm.
- `imagePixelColor(image, x, y)` reads physical-pixel coordinates from a captured `QImage`; invalid coordinates or null images return transparent. A path string is not an image object.
- `shell(command, onFinish)` launches a shell command and invokes its completion callback. Only use trusted command text; it runs with the application's permissions.
- `settings(uid)` accesses an installed settings object's properties by its UID; settings are build-dependent.

The console's `Library` object provides `installedPackages()`, `refreshAvailablePackages()`, `availablePackages()` and `installPackage(uid)`. Refresh and installation are asynchronous; a refresh call does not mean the package list has already arrived. `System` exposes `isDeviceMDMEnrolled()`, `availableCudaDevice()` and `availableCudaToolkitDylibs(major, minor)` for platform-dependent capability queries, not guarantees that a process can use those capabilities.

Source: [`Utils.hpp`](https://github.com/ossia/score/blob/master/src/plugins/score-plugin-js/JS/Qml/Utils.hpp) and [`Utils.cpp`](https://github.com/ossia/score/blob/master/src/plugins/score-plugin-js/JS/Qml/Utils.cpp).
