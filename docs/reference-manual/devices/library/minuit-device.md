---
layout: default

title: Minuit device
description: "Distributed parameter tree discovery and synchronization"

parent: Devices
grand_parent: Reference

permalink: /devices/minuit-device.html
---
# Minuit device

![Minuit device]({{ site.img }}/reference/devices/minuit-device.png "Minuit device setup")

Connect to other creative coding applications and automatically discover their parameter trees. Minuit enables rich bidirectional communication between *score* and other software, sharing not just values but complete parameter hierarchies with metadata like types, ranges, and descriptions.

Perfect for collaborative setups, distributed installations, or any project where multiple applications need to share parameter data seamlessly.

Note that Minuit has been superseded by [[OSCQuery]].

## Setting up a Minuit device

1. **Add device** in the [[Device explorer]] and choose "Minuit"
2. **Configure network settings** - set host IP and ports for communication
3. **Set device name** - choose a unique identifier for this *score* instance  
4. **Connect to remote** - the device automatically discovers the remote parameter tree
5. **Monitor synchronization** - watch as remote parameters appear in your device explorer

Both applications need to support the Minuit protocol for full bidirectional communication.

## How Minuit works

Minuit builds on [[OSC]] but adds automatic tree discovery and rich metadata exchange. Instead of manually creating parameter addresses, Minuit lets applications announce their entire parameter structure and automatically stay synchronized.

**Tree discovery** - Applications broadcast their parameter hierarchies
**Metadata exchange** - Share parameter types, ranges, units, and descriptions
**Real-time sync** - Changes in one application instantly appear in others
**Bidirectional control** - Both applications can control each other's parameters

## Network configuration

**Host address**: IP address of the remote application (use 127.0.0.1 for same computer)

**Remote port**: Port where the remote application receives data (default 9998)

**Local port**: Port where *score* listens for incoming data (default 13579)  

**Device name**: Unique identifier for this *score* instance (default "score")

**Rate limiting**: Optional throttling to prevent network flooding during rapid parameter changes

## Automatic discovery features

**Zeroconf integration**: Minuit devices can automatically discover each other on the network without manual configuration.

**Dynamic tree updates**: When the remote application adds or removes parameters, your *score* device tree updates automatically.

**Metadata synchronization**: Parameter types, value ranges, units, and descriptions sync automatically from the remote application.

**Connection monitoring**: The device detects when remote applications connect or disconnect.

## Parameter types and metadata

Minuit handles rich parameter information beyond simple values:

**Data types**: Integers, floats, strings, booleans, vectors, and complex data structures

**Value ranges**: Minimum and maximum bounds with different clipping behaviors (clamp, wrap, fold)

**Units and dataspaces**: Physical units like frequencies, distances, colors with automatic conversion

**Descriptions**: Human-readable parameter descriptions for better interface understanding

**Access modes**: Parameters can be read-only, write-only, or bidirectional based on their function

## Creative applications

**Multi-app performances**: Connect *score* with Max/MSP, Pure Data, TouchDesigner, or other creative tools for complex multi-system performances.

**Collaborative composition**: Multiple composers can work with the same parameter set simultaneously, seeing each other's changes in real-time.

**Distributed installations**: Spread an installation across multiple computers while maintaining centralized parameter control.

**Educational environments**: Students can connect their projects to shared parameter spaces for collaborative learning experiences.

**Cross-platform integration**: Bridge different creative coding environments regardless of their native parameter systems.

## Integration advantages

**Automatic setup**: No need to manually create parameter addresses or configure complex routing - Minuit handles discovery automatically.

**Rich metadata**: Unlike plain [[OSC]], you get parameter types, ranges, and descriptions, making integration much more robust.

**Bidirectional control**: Both applications can control each other's parameters, enabling true collaborative workflows.

**Network resilience**: Built-in error handling and reconnection logic keeps distributed systems running smoothly.

## Advanced features

**Listen subscriptions**: Subscribe only to parameters you actually need to reduce network traffic and improve performance.

**Tree exploration**: Explore large parameter trees efficiently with asynchronous discovery and lazy loading.

**Connection management**: Robust handling of network disconnections, timeouts, and reconnections.

**Multi-device support**: Connect to multiple Minuit-enabled applications simultaneously for complex distributed setups.

## Integration with score

Minuit devices appear in the [[Device explorer]] just like any other device, but with automatic parameter discovery.

**Parameter mapping**: Use discovered parameters with [[Mapping Tool]] or [[Automation]] just like local parameters.

**Real-time control**: Control remote application parameters in real-time during performances.

**State management**: Parameter values and ranges are preserved in *score* projects for consistent setups.

## Troubleshooting

**Discovery failures**: Check that both applications are on the same network and using compatible Minuit protocol versions.

**Port conflicts**: Ensure the specified ports aren't used by other applications - try different port numbers if connections fail.

**Firewall issues**: Network firewalls may block UDP communication - configure firewall rules to allow Minuit traffic.

**Network latency**: High network latency can affect real-time parameter control - use local networks for best performance.
