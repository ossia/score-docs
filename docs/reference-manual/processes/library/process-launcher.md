---
layout: default

title: Process Launcher
description: "Execute system processes and external applications from score"

parent: Processes
grand_parent: Reference

permalink: /processes/process-launcher.html
---
# Process Launcher

![Process Launcher]({{ site.img }}/reference/processes/process-launcher.gif "Process Launcher Process")

The Process Launcher allows you to launch and manage external system processes directly from your ossia score timeline. This powerful utility lets you integrate external scripts, commands, or applications into your interactive performances.

## Overview

The Process Launcher process executes external commands or scripts for the lifetime of the process object. When the process starts in the timeline, the external command is launched. When the process stops or is removed, the external command is terminated.

Process Launcher enables:
- **External application execution** with command-line arguments
- **System process integration** for complex workflows  
- **Script execution** (Python, shell scripts, etc.)
- **Process lifetime management** tied to score timeline
- **Cross-platform compatibility** (Windows, macOS, Linux)

Perfect for:
- Integrating external tools and utilities
- Running analysis scripts and data processing
- Launching companion applications
- System administration tasks
- Custom automation workflows
- Educational and research applications

## Inputs

| Port | Type | Description |
|------|------|-------------|
| Command | String | Executable command and arguments |

## Technical Implementation

The Process Launcher uses Qt's QProcess internally, ensuring proper cross-platform process management. The external process is launched in a separate thread and managed through Qt's event loop system.

## Related Processes

- [[Shell Command]] - Bash shell script
- [JavaScript]({{ site.baseurl }}/processes/javascript.html) - Scripting within score
- [[HTTP Device]] - Web service integration

## Try it!

Try it by downloading this [simple example!]({{ site.scores }}/reference/processes/process-launcher.score).
Note that the example requires the xeyes binary. On windows you can replace with explorer.exe and on Mac, something in your /Applications. 
