---
layout: default

title: Bitfocus Companion Device
description: "Integration with Bitfocus Companion for streaming and broadcast control"

parent: Devices
grand_parent: Reference

permalink: /devices/companion-device.html
---
# Bitfocus Companion Device

![Companion Device]({{ site.img }}/reference/devices/companion-device.png "Bitfocus Companion Integration")

Bitfocus Companion is a professional application for controlling streaming, broadcast, and AV equipment through hardware controllers like Stream Deck. ossia score's Companion integration enables seamless interaction between your interactive scores and Companion-controlled devices.

## Overview

This integration allows ossia score to:
- Control Companion buttons and actions remotely
- Receive feedback from Companion-controlled devices  
- Synchronize show states with broadcast equipment
- Integrate with professional streaming workflows
- Access Companion's extensive device module library

## Requirements

### Software
- [Bitfocus Companion](https://bitfocus.io/companion) 3.0 or later
- ossia score with Companion package installed
- Compatible hardware controllers (Stream Deck, etc.)

### Package Installation
1. Open ossia score Package Manager
2. Search for "Companion"
3. Install the Companion integration package
4. Restart ossia score

## Device Setup

### 1. Configure Companion

In Bitfocus Companion:
1. Enable the **Generic TCP** module
2. Set listen port (default: 16759)
3. Configure your hardware controllers
4. Set up device modules for your equipment

### 2. Add Companion Device in score

1. Right-click in **Device Explorer**
2. Select **Add Device**
3. Choose **Companion** from protocols
4. Configure connection settings

## Connection Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| Host | Companion server IP | 127.0.0.1 |
| Port | TCP connection port | 16759 |
| Instance ID | Companion instance | main |
| Timeout | Connection timeout (ms) | 5000 |

## Available Controls

### Button Actions

Control Companion buttons programmatically:

| Address | Type | Description |
|---------|------|-------------|
| /button/{page}/{button}/press | Impulse | Press button |
| /button/{page}/{button}/release | Impulse | Release button |
| /button/{page}/{button}/step | Impulse | Step through button states |
| /button/{page}/{button}/style | Object | Set button appearance |

### Variable Control

Read and write Companion variables:

| Address | Type | Description |
|---------|------|-------------|
| /variable/{instance}:{name} | String/Float | Variable value |
| /variable/{instance}:{name}/set | String/Float | Set variable |

### Page Control

Navigate Companion pages:

| Address | Type | Description |
|---------|------|-------------|
| /page/set | Integer | Change to page number |
| /page/up | Impulse | Next page |
| /page/down | Impulse | Previous page |

## Usage Examples

### Stream Deck Control

Control streaming scenes from score:

```
[Scene Trigger] → [/button/1/5/press] → [Stream to OBS]
```

### Broadcasting Integration

Synchronize show cues with broadcast equipment:

```
[Cue Start] → [/variable/vmix:scene] → [Video Switcher]
           → [/variable/audio:level] → [Audio Console]
```

### Interactive Performance

Map musical events to visual equipment:

```
[MIDI Note] → [Note Filter] → [/button/2/{note}/press] → [LED Control]
```

## Device Modules

Companion supports hundreds of devices. Common examples:

### Video
- OBS Studio
- vMix
- ATEM switchers
- Tricaster
- Wirecast

### Audio
- QLab
- Yamaha consoles
- Behringer X32
- Allen & Heath
- Reaper

### Lighting
- GrandMA
- ETC Eos
- Chamsys MagicQ
- QLC+
- Artnet nodes

### Streaming
- Twitch
- YouTube
- Facebook Live
- Custom RTMP

## Advanced Integration

### Bidirectional Communication

Set up two-way communication:

```
score → Companion → Hardware → Feedback → Companion → score
```

### State Synchronization

Keep show states synchronized:

```
[score Scene] → [Companion Variable] → [All Connected Devices]
                        ↑
                [Device Feedback] → [score State Update]
```

### Custom Actions

Create custom Companion actions that trigger score events:

1. Define custom TCP commands in Companion
2. Map to score addresses
3. Create complex interaction chains

## Best Practices

### Organization
- Use clear naming conventions for pages and buttons
- Group related controls on the same page
- Document your button layouts

### Performance
- Limit update rates for real-time controls
- Use rate limiting for rapid changes
- Monitor network traffic

### Reliability
- Set up connection monitoring
- Implement fallback systems
- Test all critical paths

## Troubleshooting

### Connection Issues
- Verify Companion TCP module is enabled
- Check firewall settings
- Confirm port numbers match
- Test with telnet: `telnet localhost 16759`

### Control Problems
- Verify button page/number addressing
- Check Companion button configuration
- Monitor Companion log for errors
- Test commands directly in Companion

### Performance Issues
- Reduce update frequency
- Check network latency
- Monitor Companion CPU usage
- Consider local vs remote instances

## Example Workflows

### Live Streaming Setup

```
[Musical Analysis] → [Beat Detection] → [/button/stream/scene_change]
[Audio Level] → [Scale] → [/variable/obs:volume]
[Show State] → [/page/set] → [Stream Deck Page Change]
```

### Theater Production

```
[Lighting Cue] → [/button/ma/go] → [GrandMA Console]
[Sound Cue] → [/variable/qlab:cue] → [QLab Control]
[Scene Change] → [/button/video/next] → [Video Playback]
```

### Interactive Installation

```
[Sensor Data] → [Threshold] → [/button/led/pattern] → [LED Controller]
[Visitor Count] → [/variable/display:count] → [Digital Signage]
[Time Event] → [/button/audio/ambient] → [Background Music]
```

## Security Considerations

- Use secure networks for production
- Limit access to Companion instance
- Monitor for unauthorized connections
- Implement access controls where needed

## Related Documentation

- [OSC Device](/devices/osc-device.html) - Direct OSC communication
- [TCP Device](/devices/tcp-device.html) - Raw TCP connections
- [Controlsurface](/processes/controlsurface.html) - Hardware control surfaces
- [Remote Control](/in-depth/remote.html) - score remote control