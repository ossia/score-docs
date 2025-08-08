---
layout: default

title: CoAP Device
description: "Constrained Application Protocol for embedded and IoT devices"

parent: Devices
grand_parent: Reference

permalink: /devices/coap-device.html
---

# CoAP Device

![CoAP Device Setup]({{ site.img }}/reference/devices/coap-device.png "CoAP Device Setup")

[CoAP](https://en.wikipedia.org/wiki/Constrained_Application_Protocol) (Constrained Application Protocol) is a specialized web transfer protocol designed for use with constrained nodes and networks in the Internet of Things (IoT). It is a [standard internet protocol](https://datatracker.ietf.org/doc/html/rfc7252) closely related to HTTP in behavior and operations, but with much more efficient communication optimized for resource-limited devices.

## Overview

CoAP is designed for:
- **Constrained devices** with limited processing power and memory
- **Lossy networks** with high packet loss and low bandwidth  
- **Battery-powered devices** requiring energy-efficient communication
- **Machine-to-machine** (M2M) communication in IoT ecosystems
- **Embedded control systems** and sensor networks

Key CoAP features:
- **UDP-based** for low overhead (default port: 5683)
- **RESTful architecture** similar to HTTP but optimized for constraints
- **Built-in discovery** mechanism via `/.well-known/core`
- **Observe pattern** for real-time data subscription
- **Block-wise transfers** for handling large payloads

## Supported Transports

ossia score supports all standard CoAP transports:

### UDP (Default)
- Lightweight, connectionless communication
- Best for battery-powered and resource-constrained devices
- Port 5683 (5684 for DTLS secure connections)

### TCP
- Reliable, connection-oriented communication  
- Better for stable network connections
- Useful when message ordering is critical

### WebSocket
- CoAP over WebSocket transport
- Browser compatibility and firewall traversal
- Integration with web-based systems

## Device Setup & Discovery

### Basic Configuration

1. **Add CoAP Device**: Right-click Device Explorer → Add Device → CoAP
2. **Configure Connection**:
   - **Host**: Target device IP address (e.g., `192.168.1.100`)
   - **Port**: CoAP port (5683 for UDP, custom for others)
   - **Transport**: UDP, TCP, or WebSocket

### Automatic Resource Discovery

CoAP's discovery mechanism automatically finds available resources:

1. **Enable Discovery** in device settings
2. Device queries `/.well-known/core` endpoint
3. **Available resources** appear in Device Explorer with their capabilities
4. **Observe subscriptions** can be created for real-time data streams

## CoAP Methods & Operations

### GET - Query Resource Values
Read sensor data or device state:
```
[CoAP GET /sensors/temperature] → [25.3°C]
[CoAP GET /lights/brightness] → [80%]
```

### POST - Send Commands  
Execute actions on devices:
```
[Command] → [CoAP POST /actuators/motor] → [Motor Action]
[Reboot] → [CoAP POST /system/reboot] → [Device Restart]
```

### PUT - Update Resource State
Set device configuration:
```
[New Threshold] → [CoAP PUT /config/alarm_level] → [Configuration Updated]
[RGB Values] → [CoAP PUT /lights/color] → [Color Changed]
```

### OBSERVE - Real-time Subscriptions
Subscribe to resource changes:
```
[CoAP OBSERVE /sensors/motion] → [Motion Events] → [Automated Response]
[CoAP OBSERVE /environmental/co2] → [Air Quality Data] → [Ventilation Control]
```

## Practical Examples

### Public CoAP Testing

Try with the public CoAP server at **coap.me**:

1. **Add CoAP Device** with host `coap.me`, port `5683`, UDP transport
2. **Enable discovery** to automatically find available resources
3. **Explore resources** like `/hello`, `/time`, `/separate`
4. **Test OBSERVE** on resources that support real-time updates

![CoAP.me Example]({{ site.img }}/reference/devices/coap/example.png "CoAP.me Discovery")

### IoT Sensor Network

Monitor distributed environmental sensors:

```
[CoAP OBSERVE /env/temperature] → [Temperature Processing] → [HVAC Control]
[CoAP OBSERVE /env/humidity] → [Humidity Analysis] → [Dehumidifier Control]  
[CoAP GET /env/battery] → [Battery Monitoring] → [Maintenance Alerts]
```

### Industrial Control

Interface with industrial equipment:

```
[Safety Check] → [CoAP GET /safety/status] → [Safety System Monitoring]
[Process Control] → [CoAP PUT /valve/position] → [Flow Control]
[Equipment Status] → [CoAP OBSERVE /machine/status] → [Dashboard Updates]
```

## Content Formats & Data Types

CoAP supports multiple formats for different use cases:

| Format | Media Type | Best For |
|--------|------------|----------|
| Plain Text | text/plain | Simple sensor values, strings |
| JSON | application/json | Structured data, web integration |
| CBOR | application/cbor | Efficient binary encoding |
| Link Format | application/link-format | Resource discovery responses |

## Advanced Features

### Block-wise Transfers
For large payloads exceeding packet size:
- Automatic fragmentation for images, logs, firmware
- Resume capability for interrupted transfers
- Efficient handling of large data sets

### Caching & Efficiency
Built-in optimization features:
- **Max-Age** options for cache duration
- **ETag validation** for cache freshness  
- **Conditional requests** to minimize network traffic

### Security Options
- **DTLS** (Datagram TLS) for encrypted UDP communication
- **Pre-shared keys** (PSK) for simple authentication
- **X.509 certificates** for enterprise-grade security

## Performance Considerations

### For Constrained Devices
- Use **confirmable messages** sparingly to save battery
- Implement **exponential backoff** for retry logic
- Use **OBSERVE** instead of polling for real-time data
- **Batch operations** when possible

### Network Optimization  
- Choose appropriate **content formats** (CBOR vs JSON)
- Configure suitable **timeout values** for network conditions
- Use **multicast discovery** for efficient device finding
- Implement **proper error handling** for lossy networks

## Troubleshooting

### Connection Issues
- **Verify port 5683 accessibility** through firewalls
- **Check device IP address** and network connectivity
- **Test with CoAP tools** (coap-client, Copper browser plugin)
- **Monitor UDP packet loss** on unreliable networks

### Discovery Problems
- **Check `/.well-known/core` endpoint** responds correctly
- **Validate link format syntax** in discovery responses
- **Try manual resource addition** if auto-discovery fails
- **Verify content-type** headers in discovery responses

## Best Practices

### Resource Design
1. **Follow RESTful principles** for resource organization
2. **Implement standard response codes** (2.xx, 4.xx, 5.xx)
3. **Provide descriptive resource names** in discovery
4. **Use appropriate content formats** for data efficiency

### Communication Patterns
1. **Use OBSERVE for real-time data** instead of frequent polling
2. **Implement proper retry mechanisms** with exponential backoff
3. **Handle network partitions gracefully**
4. **Cache frequently accessed resources** when appropriate

### Device Management
1. **Implement health check endpoints** for monitoring
2. **Provide configuration resources** for remote management
3. **Support secure firmware updates** when possible
4. **Log critical events** for debugging and maintenance

## Related Documentation

- [MQTT Device](/devices/mqtt-device.html) - Alternative IoT messaging protocol  
- [HTTP Device](/devices/http-device.html) - Full-featured web protocol
- [UDP Device](/devices/udp-device.html) - Raw UDP communication
- [OSC Device](/devices/osc-device.html) - Real-time multimedia control