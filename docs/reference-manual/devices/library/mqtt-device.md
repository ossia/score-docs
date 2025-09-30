---
layout: default

title: MQTT Device
description: "IoT communication using MQTT protocol"

parent: Devices
grand_parent: Reference

permalink: /devices/mqtt-device.html
---

# MQTT Device

![MQTT Device Setup]({{ site.img }}/reference/devices/mqtt-device.png "MQTT Device Setup")

[MQTT](https://en.wikipedia.org/wiki/MQTT) (Message Queuing Telemetry Transport) is a lightweight messaging protocol designed for IoT and embedded systems. ossia score's MQTT device enables seamless integration with IoT ecosystems, smart home systems, and industrial automation networks.

## Overview

MQTT support in score enables:
- **Publish/subscribe messaging** patterns for distributed systems
- **IoT device integration** with smart home and industrial networks  
- **Cloud service communication** (AWS IoT, Google Cloud IoT, Azure IoT)
- **Low-bandwidth, high-reliability** messaging for resource-constrained devices
- **Real-time data collection** from sensor networks

## Supported Transports

### TCP (Default)
- Standard MQTT over TCP (port 1883, or 8883 for TLS)
- Reliable, ordered message delivery
- Most common deployment method

### WebSocket  
- MQTT over WebSocket protocol  
- Browser compatibility and firewall-friendly
- Useful for web-based integrations and cloud services

## Device Setup

### Basic Configuration

1. **Add MQTT Device**: Right-click Device Explorer → Add Device → MQTT
2. **Configure Connection**:
   - **Host**: MQTT broker address (e.g., `mqtt.broker.com` or `127.0.0.1`)
   - **Port**: Broker port (1883 for TCP, 8080 for WebSocket)  
   - **Transport**: Select TCP or WebSocket
   - **Client ID**: Unique identifier (auto-generated if empty)

### Authentication & Security

| Parameter | Description | Example |
|-----------|-------------|---------|
| Username | MQTT username | `user123` |
| Password | MQTT password | `secret456` |  
| Keep Alive | Heartbeat interval (seconds) | 60 |
| Clean Session | Start with clean state | Enabled |
| Use TLS | Enable encryption | For secure connections |

## Topic Structure & Discovery

MQTT uses hierarchical topics separated by forward slashes. Unlike OSC, MQTT has no automatic discovery mechanism - you must use the "Learn" feature or create topics manually.

### Topic Patterns & Wildcards

- **Single level wildcard** (`+`): `home/+/temperature` matches `home/kitchen/temperature`
- **Multi-level wildcard** (`#`): `sensors/#` matches all topics under `sensors/`
- **Examples**:
  - `home/livingroom/lights/brightness`
  - `industrial/sensor01/pressure/value`
  - `score/performance/cue_state`

## Usage Examples

### Smart Home Integration

Control smart home devices from score:

```
[Score Automation] → [MQTT: home/lights/living_room] → [Smart Bulb]
[Sensor Input] → [MQTT: home/thermostat/target] → [HVAC System]
```

### IoT Sensor Networks

Collect data from distributed sensors:

```
[MQTT: sensors/+/temperature] → [Score Processing] → [Visualization]
[MQTT: sensors/+/humidity] → [Data Analysis] → [Environmental Control]
```

### Cloud IoT Platforms

Connect to major cloud services:

#### AWS IoT Core
```
Host: your-endpoint.iot.us-east-1.amazonaws.com
Port: 8883 (TLS required)
Topics: $aws/things/device-name/shadow/update
```

#### Google Cloud IoT
```  
Host: mqtt.googleapis.com
Port: 8883 (TLS required)
Topics: /devices/device-id/events
```

## Getting Started Example

To try MQTT locally, use [Mosquitto](https://mosquitto.org/):

### 1. Start MQTT Broker
```bash
$ mosquitto
```

### 2. Test with Command Line Tools

**Publish test data:**
```bash
$ mosquitto_pub -t /sensors/temperature -m 23.5 -h 127.0.0.1
```

**Subscribe to responses:**
```bash
$ mosquitto_sub -t /controls/# -h 127.0.0.1
```

### 3. Configure in ossia score

1. **Add MQTT Device** with host `127.0.0.1`, port `1883`
2. **Use "Learn" feature** to discover `/sensors/temperature` topic
3. **Add child node** to send to `/controls/lighting` topic
4. **Test bi-directional communication**

![MQTT Example Setup]({{ site.img }}/reference/devices/mqtt/example.png "MQTT Example")

## Important Considerations

### Loop Prevention
**Warning**: Many MQTT brokers cannot handle loops (publishing and subscribing to the same topic). Unlike OSC, avoid creating feedback loops between publish and subscribe on identical topics.

### Message Persistence
- Use **retained messages** for state information
- Configure **QoS levels** based on reliability needs:
  - QoS 0: At most once (fire and forget)
  - QoS 1: At least once (acknowledged)
  - QoS 2: Exactly once (guaranteed)

### Performance Tips
- **Batch updates** for high-frequency data
- **Use appropriate keep-alive intervals** (60-300 seconds)
- **Organize topics hierarchically** for efficient wildcards
- **Consider message size limits** (typically 256KB max)

## Related Documentation

- [OSC Device](/devices/osc-device.html) - Alternative real-time protocol
- [HTTP Device](/devices/http-device.html) - REST API communication  
- [WebSocket Device](/devices/ws-device.html) - Real-time web communication
- [Serial Device](/devices/serial-device.html) - Direct hardware communication