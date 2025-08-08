---
layout: default

title: Process Launcher
description: "Execute system processes and external applications from score"

parent: Processes
grand_parent: Reference

permalink: /processes/process-launcher.html
---
# Process Launcher

![Process Launcher]({{ site.img }}/reference/processes/process-launcher.png "Process Launcher Process")

The Process Launcher allows you to launch and manage external system processes directly from your ossia score timeline. This powerful utility lets you integrate external scripts, commands, or applications into your interactive performances.

## Overview

The Process Launcher process executes external commands or scripts for the lifetime of the process object. When the process starts in the timeline, the external command is launched. When the process stops or is removed, the external command is terminated.

Process Launcher enables:
- **External application execution** with command-line arguments
- **System process integration** for complex workflows  
- **Script execution** (Python, shell scripts, etc.)
- **Process lifetime management** tied to score timeline
- **Inter-process communication** through standard I/O
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
| Working Dir | String | Working directory for process |
| Environment | Object | Environment variables |
| Start Trigger | Impulse | Start the process |
| Stop Trigger | Impulse | Terminate the process |

## Outputs

| Port | Type | Description |
|------|------|-------------|
| Process State | String | Current process status |
| Exit Code | Integer | Process exit code when finished |
| Standard Output | String | Process stdout stream |
| Standard Error | String | Process stderr stream |
| Process ID | Integer | System process ID |

## Parameters

| Parameter | Widget | Description | Default | Range |
|-----------|--------|-------------|---------|-------|
| **Script** | Text Input | The command line to execute | Empty | Any command |
| Executable | File Browser | Path to executable | - | Any executable |
| Arguments | Text | Command line arguments | - | String |
| Auto Start | Toggle | Start when interval begins | Off | On/Off |
| Auto Kill | Toggle | Kill when interval ends | On | On/Off |
| Shell | Toggle | Run through system shell | Off | On/Off |
| Timeout | Integer | Maximum run time (seconds) | 0 | 0 = no limit |

### Script Parameter Details

The command line to execute. This can be:
- A simple command: `echo "Hello World"`
- A script with arguments: `python3 /path/to/script.py --arg1 value1`
- A complex shell command: `ls -la | grep .txt`

The command uses standard shell parsing, so you can include arguments and options as you would in a terminal.

## Process States

The Process Launcher tracks execution state:

| State | Description |
|-------|-------------|
| **Stopped** | Process not running |
| **Starting** | Process is launching |
| **Running** | Process is active |
| **Finished** | Process completed normally |
| **Killed** | Process was terminated |
| **Failed** | Process failed to start |
| **Timeout** | Process exceeded time limit |

## Basic Usage Examples

### Launch External Application

Start a media player with specific file:

```
Command: "vlc"
Arguments: "/path/to/media/file.mp4 --fullscreen"
Auto Start: On
Auto Kill: On
```

### Execute Python Script

Run data analysis script:

```
Command: "python3"
Arguments: "/path/to/analysis.py --input data.csv --output results.json"
Working Dir: "/home/user/projects"
```

### System Administration

Execute system maintenance:

```
Command: "rsync"
Arguments: "-av /source/path/ /backup/path/"
Shell: On (for shell expansion)
```

### Cross-platform File Operations

Handle files across different OS:

```
# Windows
Command: "cmd"
Arguments: "/c copy source.txt destination.txt"

# Linux/macOS  
Command: "cp"
Arguments: "source.txt destination.txt"
```

## Advanced Usage Patterns

### Sequential Process Execution

Chain multiple processes using state outputs:

```
[Process 1] → [State: Finished] → [Trigger] → [Process 2] → [State: Finished] → [Process 3]
```

### Data Pipeline Processing

Create multi-stage data processing:

```
[Data Source] → [Python Preprocessing] → [R Analysis] → [Visualization Tool] → [Report Generation]
```

Example configuration:
```
Process 1: python3 preprocess.py input.csv clean.csv
Process 2: Rscript analysis.R clean.csv results.csv  
Process 3: gnuplot plot_script.gp
Process 4: pandoc report.md -o report.pdf
```

### Parallel Processing

Launch multiple processes simultaneously:

```
[Start Trigger] → [Process Launcher 1] → [Task A]
               → [Process Launcher 2] → [Task B]  
               → [Process Launcher 3] → [Task C]
               → [Sync Point] → [Final Processing]
```

### Interactive Applications

Launch interactive tools with controlled lifecycle:

```
[Performance Start] → [Launch Blender] → [3D Visualization]
                   → [Launch TouchDesigner] → [Real-time Effects]
                   → [Launch MAX/MSP] → [Audio Processing]
[Performance End] → [Kill All Processes]
```

## Environment and Configuration

### Environment Variables

Pass configuration through environment:

```javascript
Environment: {
    "DISPLAY": ":0.0",           // X11 display (Linux)
    "PATH": "/custom/bin:$PATH", // Add to system PATH
    "API_KEY": "secret_key",     // Application secrets
    "LANG": "en_US.UTF-8"       // Locale settings
}
```

### Working Directory

Control process execution context:

```
Working Dir: "/project/root"     // Process runs from here
Command: "./build/my_app"        // Relative to working directory
Arguments: "--config config.json" // Files relative to working dir
```

### Platform-Specific Execution

Handle cross-platform differences:

```javascript
// Windows
Command: "powershell"
Arguments: "-File script.ps1"

// macOS
Command: "osascript"  
Arguments: "-e 'tell application \"iTunes\" to play'"

// Linux
Command: "notify-send"
Arguments: "Score Notification 'Process completed'"
```

## Integration Examples

### Scientific Computing

Integrate with scientific tools:

```
[Sensor Data] → [CSV Export] → [Python Analysis] → [Results Import] → [Visualization]

Process Config:
Command: "python3"
Arguments: "analyze.py --input sensor_data.csv --method fft --output fft_results.json"
Auto Start: On sensor data ready
```

### Media Processing

Chain media processing tools:

```
[Video Input] → [FFmpeg Processing] → [Audio Extraction] → [Analysis] → [Effects Control]

Process Configs:
1. FFmpeg: "ffmpeg -i input.mp4 -vf scale=1920:1080 output.mp4"
2. Audio: "ffmpeg -i output.mp4 -an audio.wav"  
3. Analysis: "python3 audio_analysis.py audio.wav features.json"
```

### Network Operations

Handle network tasks:

```
[Data Ready] → [Upload Process] → [Notification] → [Cleanup]

Process Config:
Command: "curl"
Arguments: "-X POST -H 'Content-Type: application/json' -d @data.json https://api.example.com/upload"
```

### Build Systems

Integrate development workflows:

```
[Code Change] → [Build Process] → [Test Process] → [Deploy Process]

Processes:
1. Build: "make clean && make release"
2. Test: "python3 -m pytest tests/"
3. Deploy: "./deploy.sh production"
```

## Security Considerations

### Command Injection Prevention

Avoid command injection vulnerabilities:

```
// DANGEROUS - Don't do this
Arguments: user_input  // Could contain "; rm -rf /"

// SAFE - Validate and sanitize
Arguments: validated_arguments  // Check against allowed patterns
```

### Process Isolation

Limit process capabilities:

```
// Run with limited permissions
Command: "sudo -u limited_user"
Arguments: "python3 safe_script.py"

// Use containers for isolation
Command: "docker"  
Arguments: "run --rm -v /data:/data alpine python3 /data/script.py"
```

### Resource Limits

Prevent resource exhaustion:

```
Timeout: 300  // Kill after 5 minutes
Memory Limit: "1GB"  // If supported by OS
CPU Limit: "50%"     // If supported by OS
```

## Performance Considerations

### Process Overhead

Minimize system impact:
- **Limit concurrent processes** to reasonable numbers
- **Use timeouts** to prevent runaway processes
- **Monitor system resources** during execution
- **Clean up temporary files** after processing

### I/O Handling

Manage input/output efficiently:
- **Stream large data** rather than loading entirely
- **Buffer output** appropriately for real-time display
- **Handle binary data** correctly in I/O streams
- **Prevent blocking** on slow I/O operations

### Process Lifecycle

Manage process lifetime effectively:
- **Use Auto Kill** to prevent orphaned processes
- **Handle process failures** gracefully
- **Clean up resources** on score exit
- **Monitor process states** for debugging

## Best Practices

### Command Construction
1. **Use absolute paths** when possible to avoid ambiguity
2. **Validate input parameters** before constructing commands
3. **Escape special characters** in shell commands
4. **Test commands** manually before using in score

### Error Handling
1. **Monitor exit codes** for success/failure detection
2. **Capture stderr** for error diagnostics
3. **Implement retry logic** for transient failures
4. **Provide meaningful error messages** to users

### Resource Management
1. **Set appropriate timeouts** for all processes
2. **Clean up temporary files** created by processes
3. **Monitor system resources** during execution
4. **Use process pools** for repeated operations

### Platform Compatibility
1. **Test on all target platforms** during development
2. **Use platform-specific commands** when necessary
3. **Handle path separators** correctly across platforms
4. **Consider different shell environments**

## Troubleshooting

### Process Won't Start
- **Check executable path** exists and is accessible
- **Verify permissions** for execution
- **Test command manually** in terminal
- **Check working directory** exists and is accessible

### Process Hangs or Timeout
- **Reduce timeout value** for testing
- **Check for interactive prompts** that need input
- **Monitor system resources** for bottlenecks
- **Test with simpler commands** first

### Output Issues
- **Verify process produces** expected output format
- **Check encoding** of text output
- **Test with verbose/debug flags** if available
- **Monitor both stdout and stderr** streams

### Cross-Platform Issues
- **Test on target operating systems**
- **Check path format** (forward vs back slashes)
- **Verify shell availability** and behavior
- **Handle platform-specific** command differences

## Execution Lifecycle

1. **Process Start**: When the timeline reaches this process, the external command is launched
2. **Process Active**: The external process runs independently while this object exists
3. **Process Stop**: When the timeline leaves this process or the process is removed, the external command is terminated

## Technical Implementation

The Process Launcher uses Qt's QProcess internally, ensuring proper cross-platform process management. The external process is launched in a separate thread and managed through Qt's event loop system.

## Related Processes

- [JavaScript](/processes/javascript.html) - Scripting within score
- [Python](/processes/python.html) - Python scripting integration
- [HTTP](/processes/http-device.html) - Web service integration
- [File I/O](/processes/file-io.html) - File system operations