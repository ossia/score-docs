---
layout: default

title: Command line API
description: "Options for the score start-up"

parent: Reference

permalink: /reference/commandline.html
---

You can launch ossia score from the command line or shell scripts with various useful options.

# Command-line reference

## List of command-line options

### Getting the list of options
```bash
$ ossia-score --help
```

### Loading a score on startup:
```bash
$ ossia-score filename

# For example:
$ ossia-score /home/oscar/my-score.score
```

### Playing a score on startup
```bash
$ ossia-score --autoplay filename

# For example:
$ ossia-score --autoplay /home/oscar/my-score.score
```

### Playing a score on startup after some delay
This is useful if for instance the score has audio plug-ins that take some time to load, such as
orchestral plug-ins with large sound banks.

```bash
$ ossia-score --autoplay filename --wait delay_in_seconds

# For example:
$ ossia-score --autoplay /home/oscar/my-score.score --wait 5
```

### Loading score without showing the GUI
```bash
$ ossia-score --no-gui
```
(note: this is not very useful without specifying a file to load).

### Loading score without showing the "do you want to restore" pop-up dialog
  This is useful if you are quitting score for instance by killing the process, as score will register that as a crash, which will cause the
  pop-up to show up next time.
```bash
$ ossia-score --no-restore
```

### Timeline rendering

`--opengl` enables OpenGL rendering of the main timeline; `--no-opengl` disables it. The current development build defaults to the non-OpenGL timeline. These switches do **not** select the video/GPU processing backend.

`--vector-gui` favors vector drawing where available (sharper when zooming, potentially slower); `--no-vector-gui` favors cached pixmaps. These are GUI rendering choices, not audio or video quality settings.

### Running a startup script

```bash
ossia-score --no-gui --wait 2 /path/to/project.score --script /path/to/setup.js
ossia-score --no-gui --script 'console.log("ready"); Qt.exit(0);'
```

`--script` can be repeated. An existing file path takes precedence over inline JavaScript; `.mjs` files are imported as ES modules and an exported `initialize()` function is called when present. Other script files are evaluated as JavaScript. Quote inline code so the shell does not interpret it.

In current development builds, scripts run after the document has loaded, or against a new empty document when no score was supplied. `--wait N` adds a non-negative, whole-second delay before startup scripts and autoplay. There is also a short startup scheduling delay; this is not a precise synchronization clock.

Supplying `--script` bypasses the start screen and normal session restoration. A missing/unreadable script exits with status 2; an evaluation or module-initialization error exits with status 3. A successful script does not automatically quit: use `Qt.exit(code)` when a batch task is finished. Autoplay and scripts are both scheduled after startup; do not rely on their relative order to finish setup before playback.

See [Scripting]({{ site.baseurl }}/in-depth/scripting.html) for the scripting environment.

### Local device ports

```bash
ossia-score --local-osc-port 16666 --local-ws-port 19999 project.score
```

These set the default local `score` device OSC and OSCQuery WebSocket ports. Defaults are **6666** and **9999** respectively. Command-line options take precedence over `SCORE_LOCAL_OSC_PORT` / `SCORE_LOCAL_WS_PORT`, then the built-in defaults. Existing document device settings can have their own ports; edit the `score` device in the Device explorer to change those. Give independent running instances non-conflicting ports.

These options are supplied by the engine plug-in, so the core `--help` output does not list them.

### Custom QML applications

`--ui /path/to/App.qml` loads a custom UI without the normal editor and disables restoration. `--ui-debug /path/to/App.qml` loads it while keeping the score editor visible for debugging. A score file can also be supplied; add `--autoplay` explicitly if it should play.

For packaging a UI, score and assets together, see [Custom applications]({{ site.baseurl }}/development/custom-apps.html).

### Developer compilation commands

With the JIT plug-in and matching SDK available, `--compile-node /path/to/Object.hpp` compiles an Avendish object and `--compile-addon /path/to/addon` compiles a supported source add-on. They register the result and exit rather than installing a binary package. See [Plug-ins with Avendish]({{ site.baseurl }}/development/plugins/plugins-with-avendish.html#compile-at-run-time) for the required source shape and platform constraints.

## Complete recommended command line to launch a score on startup

### On Linux:
```bash
$ /usr/bin/ossia-score --no-gui --no-restore --wait 5 --autoplay "/path/to/your/score.score"
```


### On macOS:
```bash
$ /Applications/Score.app/Contents/MacOS/score --no-gui --no-restore --wait 5 --autoplay "/path/to/your/score.score"
```


### On Windows:
```dosbatch
> "c:\Program Files\ossia score\score.exe" --no-gui --no-restore --wait 5 --autoplay "c:\path\to\your\score.score"
```

## List of useful environment variables

Set environment variables **before** starting score. The examples below use POSIX shell syntax; Windows users can use `set NAME=value` in `cmd.exe` or `$env:NAME="value"` in PowerShell.

| Variable | Effect |
|---|---|
| `QSG_RHI_BACKEND=opengl` | Select the initial graphics processing backend. Recognized values are `opengl`, `vulkan`, `metal`, `d3d11` and `d3d12`; the platform, Qt build and driver must support the requested backend. Metal is macOS-specific and Direct3D is Windows-specific. This is separate from timeline `--opengl`. |
| `SCORE_OPENGL_FORMAT=gles` | Request OpenGL ES for OpenGL context probing; `gl` requests desktop OpenGL core profile. This chooses the API family, not a numeric GL version, and cannot add missing driver capabilities. |
| `SCORE_LOCAL_OSC_PORT=16666` | Default local device OSC port, unless overridden on the command line. |
| `SCORE_LOCAL_WS_PORT=19999` | Default local device OSCQuery WebSocket port, unless overridden on the command line. |
| `SCORE_PRETTIFY_JSON=1` | Write indented JSON when saving JSON documents, useful for reviewing diffs. The option is checked for presence: unset it to restore compact output. It is not a command to reformat arbitrary files. |
| `SCORE_DISABLE_ALSA=1` | Disable ALSA device enumeration on Linux. |
| `SCORE_DISABLE_AUDIOPLUGINS=1` | Disable startup scanning of external audio plug-ins, including VST, VST3, LV2 and CLAP where compiled in. |
| `FAUST_LIB_PATH=/some/path` | Override the default location of the bundled Faust libraries; see [Faust]({{ site.baseurl }}/processes/faust.html). |

For example:

```bash
QSG_RHI_BACKEND=vulkan SCORE_PRETTIFY_JSON=1 ossia-score project.score
```

Current development builds consume `QSG_RHI_BACKEND` during graphics setup and remove it from the process environment after applying it, so independently embedded Qt runtimes in audio plug-ins do not inherit an incompatible backend request. Select only a backend available in the application's graphics settings.