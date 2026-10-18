---
layout: default

title: Shell command
description: "Launch an external script with a selected interpreter"

parent: Processes
grand_parent: Reference

permalink: /processes/shell-command.html
score: /reference/processes/shell-command.score
---
# Shell command

<video src="{{ site.img }}/reference/processes/shell-command.webm" data-loop controls muted loop playsinline preload="metadata" aria-label="Shell command" title="Shell command"></video>

Shell command launches **Script** once when its process starts executing. It can also be placed in a state to run a command as a cue. The external command is detached: ending the interval does not manage its lifetime. Use [[Process Launcher]] when process lifetime and communication need explicit control.

## Interpreter and inputs

**Interpreter** selects System, Bash, Zsh, Fish, Sh, Python, PowerShell, Cmd or Custom. Write **Script** in the language of the selected interpreter; a shell pipeline is not automatically Python code.

The [external script language reference]({{ site.baseurl }}/reference/languages/external-scripts.html) links each language's manual and explains executable selection, the **Custom command** `%s` substitution and quoting. These interpreters run outside score; they do not provide its embedded JavaScript API.

The chosen executable must be installed and discoverable on the machine running score. Selecting Cmd on a non-Windows machine does not install Windows command support. This process is not available in the WebAssembly build and has no output ports for stdout or exit status.

Only execute scripts from trusted scores: they run with your user account's filesystem and system permissions.

## Related processes

- [[Process Launcher]]: communicate with and manage an external process.
- [JavaScript]({{ site.baseurl }}/processes/javascript.html): script within score rather than launching an external interpreter.

## Existing example

Launch another application at a chosen moment in a performance with the [Shell command example]({{ site.scores }}{{ page.score }}). One command runs when an interval begins; another is attached to a later state. Move the command-bearing interval's start and replay to hear or see the external action occur at a different cue time. Ending the interval does not itself close the launched application; the later state does, by running `pkill zdoom` (the pattern also matches `gzdoom`).

**Before playing:** use desktop score and inspect both scripts. The supplied interval script tries ZDoom, then GZDoom with a locally available `doom.wad`; otherwise it attempts a network game through a terminal and has a compiler fallback. Replace these commands with a trusted local application if you only want to explore cue timing. Installing GZDoom alone does not supply the game data, and this script is not a portable, dependency-free example.

{% include try-on-web.html %}

