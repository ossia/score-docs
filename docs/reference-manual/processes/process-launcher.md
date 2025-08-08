# Process Launcher

The Process Launcher allows you to launch and manage external system processes directly from your ossia score timeline. This powerful utility lets you integrate external scripts, commands, or applications into your interactive performances.

## Overview

The Process Launcher process executes external commands or scripts for the lifetime of the process object. When the process starts in the timeline, the external command is launched. When the process stops or is removed, the external command is terminated.

## Parameters

### Script
**Type**: Text input (lineedit)  
**Default**: Empty

The command line to execute. This can be:
- A simple command: `echo "Hello World"`
- A script with arguments: `python3 /path/to/script.py --arg1 value1`
- A complex shell command: `ls -la | grep .txt`

The command uses standard shell parsing, so you can include arguments and options as you would in a terminal.

## Usage Examples

### Running a Python Script
```bash
python3 /home/user/scripts/interactive_script.py --port 9001
```

### Launching a Media Player
```bash
vlc /path/to/media/file.mp4 --intf dummy --play-and-exit
```

### Starting a Web Server
```bash
python3 -m http.server 8080
```

### Running a Shell Script
```bash
bash /home/user/scripts/setup_environment.sh
```

## Execution Lifecycle

1. **Process Start**: When the timeline reaches this process, the external command is launched
2. **Process Active**: The external process runs independently while this object exists
3. **Process Stop**: When the timeline leaves this process or the process is removed, the external command is terminated

## Best Practices

### Security Considerations
- Only run trusted commands and scripts
- Be careful with commands that require elevated permissions
- Validate any user input that might be passed to the command

### Performance Tips
- Long-running processes are ideal for this utility
- For one-shot commands, consider the execution time in your timeline
- Monitor system resources when running intensive external processes

### Error Handling
- Test your commands in a terminal first
- External process failures won't crash ossia score
- Check system logs if external processes don't behave as expected

## Use Cases

### Interactive Installations
- Launch sensor reading scripts
- Start communication daemons
- Initialize hardware controllers

### Media Playback
- Trigger external media players
- Start streaming processes
- Launch video processing pipelines

### System Integration
- Execute system maintenance tasks
- Trigger backup processes
- Interface with system services

### Development Workflows
- Run test suites during performance
- Launch debugging tools
- Start development servers

## Technical Details

The Process Launcher uses Qt's QProcess internally, ensuring proper cross-platform process management. The external process is launched in a separate thread and managed through Qt's event loop system.

## Related Processes

- **Script Editor**: For executing JavaScript code within ossia score
- **Shell**: For simple command execution (if available)
- **File I/O processes**: For reading/writing data to external files