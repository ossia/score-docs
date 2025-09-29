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

### Loading score in software rendering mode
ossia score uses as of v3 OpenGL for rendering the main timeline.
On some old machines or machines with bad GL drivers, this can cause issues. We then recommend using that switch to launch it.

```bash
$ ossia-score --no-opengl
```

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

* `SCORE_DISABLE_ALSA=1`: on Linux, disables the ALSA backend.
* `SCORE_DISABLE_AUDIOPLUGINS=1`: disables scanning of VST, LV2 plug-ins on startup.
* `FAUST_LIB_PATH=/some/path`: can override the default path where *score* looks for Faust libraries (by default they ship with *score*).