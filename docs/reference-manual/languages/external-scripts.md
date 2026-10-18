---
layout: default
title: External script languages
description: "Interpreter references for Python, shell languages and commands launched outside score."
parent: Languages
grand_parent: Reference
nav_order: 28
permalink: /reference/languages/external-scripts.html
---

# External script languages

[[Shell command]] can launch code with an interpreter installed on the host computer. These are **external programs**, not additional embedded runtimes with access to `Script`, `Score.Editor` or score's audio buffers. Use [JavaScript/QML]({{ site.baseurl }}/reference/languages/javascript.html) or a native process interface when the code needs to run inside score's execution graph.

## Choose the matching manual

| Interpreter selection | Language reference | Execution requirement |
|---|---|---|
| System | The host operating system's command interpreter documentation | Syntax depends on the operating system. |
| Sh | [POSIX shell command language](https://pubs.opengroup.org/onlinepubs/9799919799/utilities/V3_chap02.html) | A `sh` executable; Bash-specific extensions are not portable POSIX shell syntax. |
| Bash | [GNU Bash manual](https://www.gnu.org/software/bash/manual/bash.html) | Bash installed and discoverable. |
| Zsh | [Zsh manual](https://zsh.sourceforge.io/Doc/Release/) | Zsh installed and discoverable. |
| Fish | [Fish language reference](https://fishshell.com/docs/current/language.html) | Fish installed; its syntax differs from POSIX shells. |
| Python | [Python language reference](https://docs.python.org/3/reference/) and [standard library](https://docs.python.org/3/library/) | The process invokes `python3`. |
| PowerShell | [PowerShell language reference](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_language_keywords) | `powershell` on Windows or `pwsh` elsewhere. |
| Cmd | [Windows command reference](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/windows-commands) | Windows command support; selecting Cmd does not install it on another platform. |
| Custom | The selected executable's own documentation | Supply the executable and arguments in **Custom command**. |

A pipe, variable expansion or quoting rule belongs to the selected interpreter. For example, shell `$name` expansion is not Python variable syntax, and PowerShell pipelines pass objects rather than simply following POSIX text-pipeline conventions.

## Passing the script

In **Custom command**, `%s` is replaced by the complete **Script** text. If `%s` is absent, score appends the script as a final argument. The executable must accept that invocation; many interpreters require an option to distinguish source text from a filename. Quote the command arguments according to the interpreter and avoid inserting untrusted input into source code.

## Lifetime, communication and safety

Shell command starts the program when the process executes, including when used as a state cue. The program is detached: ending the interval does not terminate it. There are no stdout or exit-status output ports on this process. Use [[Process Launcher]] when the score needs managed process lifetime and communication.

External scripts run with the current user's permissions. They can read and modify files, make network requests or launch further programs. Inspect scripts before playing a downloaded score. Interpreter versions, installed libraries and executable paths are deployment dependencies; they are not bundled merely because the script text is saved in a score. Shell command is unavailable in the WebAssembly build.
