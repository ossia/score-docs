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

![Shell command]({{ site.img }}/reference/processes/shell-command.gif "Shell command")

Shell command launches **Script** once when its process starts executing. It can also be placed in a state to run a command as a cue. The external command is detached: ending the interval does not manage its lifetime. Use [[Process Launcher]] when process lifetime and communication need explicit control.

## Interpreter and inputs

**Interpreter** selects System, Bash, Zsh, Fish, Sh, Python, PowerShell, Cmd or Custom. Write Script in the language of the selected interpreter; a shell pipeline is not automatically Python code.

- **System** uses the operating system's command interpreter.
- The named interpreters invoke their corresponding executable. Python uses `python3`; PowerShell uses `powershell` on Windows and `pwsh` elsewhere.
- **Custom command** supplies the executable and arguments for Custom. `%s` is replaced with the complete Script text. If absent, the script is appended as a final argument. Quote the custom command's arguments as required by its interpreter.

The chosen executable must be installed and discoverable on the machine running score. Selecting Cmd on a non-Windows machine does not install Windows command support. This process is not available in the WebAssembly build and has no output ports for stdout or exit status.

Only execute scripts from trusted scores: they run with your user account's filesystem and system permissions.

## Related processes

- [[Process Launcher]]: communicate with and manage an external process.
- [JavaScript]({{ site.baseurl }}/processes/javascript.html): script within score rather than launching an external interpreter.

## Existing example

The [Shell command example]({{ site.scores }}{{ page.score }}) launches an external application and requires gzdoom to be installed.
