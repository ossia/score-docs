---
layout: default

title: Shell command
description: "Run a bash script from score"

parent: Processes
grand_parent: Reference

permalink: /processes/shell-command.html
---
# Shell command

![Shell command]({{ site.img }}/reference/processes/shell-command.gif "Shell command")

The Shell command allows you to launch and manage external system processes directly from your ossia score timeline. This powerful utility lets you integrate external scripts, commands, or applications into your interactive performances.

## Overview

The Shell Command starts a script when its execution start. When the process starts in the timeline, the external command is launched. 
It is possible to use the Shell Command as part of a state to run a script as part of a cue.
If you need precise control over the process's duration and lifetime, use a [[Process Launcher]] instead.


Shell Command enables:
- **External application execution** with command-line arguments
- **System process integration** for complex workflows  
- **Script execution** (Python, shell scripts, etc.)
- **Process lifetime management** tied to score timeline
- **Cross-platform compatibility** (macOS, Linux, Windows if bash is in $PATH)

Perfect for:
- Integrating external tools and utilities
- Running analysis scripts and data processing
- Launching companion applications
- System administration tasks
- Custom automation workflows
- Educational and research applications


# Script Parameter Details

The command line to execute. This can be:
- A simple command: `echo "Hello World"`
- A script with arguments: `python3 /path/to/script.py --arg1 value1`
- A complex shell command: `ls -la | grep .txt`

The command is saved as a bash script and then executed.

## Inputs

| Port | Type | Description |
|------|------|-------------|
| Script | String | Executable bash script |

## Technical Implementation

The Process Launcher uses Qt's QProcess internally, ensuring proper cross-platform process management. The external process is launched in a separate thread and managed through Qt's event loop system.

## Related Processes

- [[Process Launcher]]
- [JavaScript](/processes/javascript.html) - Scripting within score
- [HTTP](/processes/http-device.html) - Web service integration
<!-- 

- [Python](/processes/python.html) - Python scripting integration
- [File I/O](/processes/file-io.html) - File system operations 
-->


## Try it!

Try it by downloading this [simple example]({{ site.scores }}/reference/processes/shell-command.score)!
Note that the example requires gzdoom to work.