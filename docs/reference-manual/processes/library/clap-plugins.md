---
layout: default

title: CLAP Plugins
description: "Support for CLever Audio Plugin format"

parent: Processes
grand_parent: Reference

permalink: /processes/clap-plugins.html
---
# CLAP Plugins

![CLAP Plugins]({{ site.img }}/reference/processes/clap-plugins.png "CLAP Plugin Support")

ossia score now supports CLAP (CLever Audio Plugin), a modern, open-source audio plugin format designed for performance and flexibility. CLAP plugins offer advanced features and better performance compared to traditional formats.

## Overview

CLAP is a new plugin standard that provides:
- Better performance through modern API design
- Enhanced parameter automation capabilities
- Improved threading model for real-time safety
- Native support for modulation and note expressions
- Cross-platform compatibility (Windows, macOS, Linux)

## Loading CLAP Plugins

### Automatic Scanning

score automatically scans for CLAP plugins in standard locations:
- **Windows**: `C:\Program Files\Common Files\CLAP` and `%LOCALAPPDATA%\Programs\Common\CLAP`
- **macOS**: `/Library/Audio/Plug-Ins/CLAP` and `~/Library/Audio/Plug-Ins/CLAP`
- **Linux**: `/usr/lib/clap` and `~/.clap`

### Manual Loading

1. In the Process Library, navigate to Audio > Plugins > CLAP
2. Drag the desired plugin to your score
3. Or use the "Add Process" menu and select from available CLAP plugins

## Features

### Parameter Control

CLAP plugins in score support:
- Full parameter automation
- Sample-accurate automation
- Modulation inputs
- Per-note expressions

### Advanced Capabilities

| Feature | Description |
|---------|-------------|
| Polyphonic Modulation | Modulate parameters per-voice |
| Note Expressions | Pitch bend, pressure, brightness per note |
| Preset Management | Load/save plugin states |
| GUI Support | Native plugin interfaces |
| Threading | Optimized for real-time performance |

## Usage

### Basic Setup

1. **Add Plugin**: Drag CLAP plugin from library
2. **Configure Audio**: Connect audio inputs/outputs
3. **Set Parameters**: Adjust via inspector or plugin GUI
4. **Automate**: Create automation curves for any parameter

### Parameter Automation

CLAP plugins expose parameters that can be automated:

```
[LFO] → [Scale] → [CLAP Plugin.Parameter]
                          ↓
                   [Audio Output]
```

### Modulation Routing

CLAP's modulation system integrates with score:

```
[Envelope] → [CLAP.Modulation Input]
[LFO] → [CLAP.Modulation Input 2]
```

## CLAP vs Other Formats

| Feature | CLAP | VST3 | LV2 |
|---------|------|------|-----|
| Performance | Excellent | Good | Good |
| Modulation | Native | Limited | Extensions |
| Threading | Modern | Legacy | Varies |
| Open Source | Yes | No | Yes |
| Note Expression | Native | Supported | Extensions |

## Recommended CLAP Plugins

### Free/Open Source

- **Surge XT** - Powerful synthesizer
- **Vital** - Wavetable synthesizer
- **CLAP Tutorial Plugins** - Example implementations

### Commercial

- **u-he plugins** - High-quality synthesizers and effects
- **Bitwig devices** - Native Bitwig Studio devices as CLAP

## Performance Considerations

### CPU Usage
- CLAP plugins generally offer better performance
- Multi-threading support reduces audio dropouts
- Efficient parameter handling

### Latency
- Report latency accurately for compensation
- Support for latency-free parameter changes
- Optimized for live performance

## Troubleshooting

### Plugin Not Found
1. Check installation path
2. Verify plugin architecture matches score (64-bit)
3. Rescan plugins in Audio Settings
4. Check file permissions

### Audio Issues
- Ensure sample rate compatibility
- Check buffer size settings
- Verify audio routing

### GUI Problems
- Update graphics drivers
- Check display scaling settings
- Try running without GUI

## Advanced Features

### Per-Note Modulation

CLAP plugins can receive modulation per note:

1. Use MIDI note with modulation data
2. Connect to CLAP plugin
3. Each note can have unique modulation

### State Management

- Save plugin states as score presets
- Recall states during performance
- Interpolate between states

### Custom Extensions

CLAP's extensible architecture allows:
- Vendor-specific features
- Custom parameter types
- Enhanced communication protocols

## Best Practices

1. **Organization**: Keep CLAP plugins in standard directories
2. **Updates**: Keep plugins updated for best compatibility
3. **Presets**: Save presets within score for consistency
4. **Performance**: Monitor CPU usage with system monitor
5. **Backup**: Export plugin states with projects

## Integration Examples

### Synthesis Chain
```
[MIDI] → [CLAP Synth] → [CLAP Effect] → [Audio Out]
              ↑               ↑
         [Automation]    [Modulation]
```

### Live Processing
```
[Audio In] → [CLAP Filter] → [CLAP Delay] → [Mix]
                  ↑               ↑
            [Expression]     [Tempo Sync]
```

## Related Documentation

- [Audio Plugins](/processes/audio-plugins.html) - General plugin support
- [VST Plugins](/processes/vst-plugins.html) - VST support
- [LV2 Plugins](/processes/lv2-plugins.html) - LV2 support
- [Audio Effects](/processes/audio-effects.html) - Built-in effects