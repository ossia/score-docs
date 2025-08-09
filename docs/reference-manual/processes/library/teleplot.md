---
layout: default

title: Teleplot
description: "Remote plotting and data visualization"

parent: Processes
grand_parent: Reference

permalink: /processes/teleplot.html
---
# Teleplot

![Teleplot]({{ site.img }}/reference/processes/teleplot.png "Teleplot")

Send data to remote plotting applications for real-time visualization and analysis. Teleplot streams parameter data over network connections, allowing you to monitor and analyze your *score* project's behavior using external visualization tools.

Perfect for system monitoring, performance analysis, debugging complex control systems, or creating real-time data visualizations for presentations and installations.

## How it works

Teleplot captures data from your *score* processes and streams it to external plotting applications using network protocols. This lets you visualize parameter changes, analyze system behavior, and monitor performance from remote locations.

**Data input** - Connect any parameter or signal for visualization  
**Network streaming** - Send data over TCP/UDP to plotting applications  
**Multiple streams** - Support for multiple simultaneous data streams  
**Remote monitoring** - Monitor *score* projects from other computers

## Supported visualization tools

**Web browsers**: Built-in web interface for simple real-time plotting accessible from any browser.

**Scientific tools**: Integration with MATLAB, Python matplotlib, R, or other scientific computing environments.

**Monitoring dashboards**: Send data to Grafana, custom dashboards, or system monitoring tools.

**Mobile devices**: View plots on smartphones or tablets for remote monitoring during performances.

## Data streaming features

**Real-time streaming**: Live data transmission with configurable update rates and buffering.

**Multiple parameters**: Stream several different parameters simultaneously with individual scaling and labeling.

**Historical data**: Maintain data history for trend analysis and performance monitoring.

**Network protocols**: TCP for reliable delivery or UDP for low-latency streaming.

## Creative applications

**Performance monitoring**: Monitor audio levels, effect parameters, or system performance during live performances.

**Installation analytics**: Track user interaction patterns, sensor readings, or system behavior in interactive installations.

**Composition analysis**: Visualize musical parameters, harmony progressions, or algorithmic composition processes in real-time.

**System debugging**: Plot control signals, automation curves, or device communications to troubleshoot complex systems.

**Educational demonstrations**: Show real-time parameter behavior for teaching interactive media or electronic music concepts.

## Integration with score

Teleplot can monitor any parameter in your *score* project - [[Audio Effects]] controls, [[Mapping Tool]] responses, sensor data from device protocols, or automation curves from timeline processes.

**Non-intrusive monitoring**: Teleplot doesn't affect the monitored processes - it's purely observational.

**Flexible data selection**: Choose exactly which parameters to monitor without impacting system performance.

**Network distribution**: Share visualization data across networks for collaborative monitoring or remote performance management.

## Setup workflow

1. **Configure network settings** - Set IP addresses and ports for data streaming
2. **Select data sources** - Choose which parameters to monitor and visualize
3. **Set up receiver** - Configure plotting application or web browser to receive data
4. **Test streaming** - Verify data transmission and visualization quality
5. **Optimize settings** - Adjust update rates and buffer sizes for your use case

## Network configuration

**Local monitoring**: Use localhost (127.0.0.1) for same-computer visualization.

**Network monitoring**: Configure IP addresses for remote monitoring across networks.

**Port selection**: Choose appropriate network ports that don't conflict with other services.

**Firewall settings**: Ensure network firewalls allow data streaming on selected ports.

## Performance considerations

**Update rates**: Higher streaming rates provide smoother plots but increase network and CPU usage.

**Data compression**: Option to compress data streams for bandwidth-limited networks.

**Buffer management**: Configure buffering to balance responsiveness with network efficiency.

**Multiple streams**: Each monitored parameter adds network overhead - select carefully for optimal performance.

## Visualization options

**Time series plots**: Standard real-time plotting with scrolling time axis.

**Multi-parameter displays**: Multiple parameters on single plots with different scales and colors.

**Statistical displays**: Show parameter statistics, distributions, or frequency analysis.

**Custom dashboards**: Create specialized visualization layouts for specific monitoring needs.

## Security considerations

**Network exposure**: Be aware that data streaming may expose parameter information over networks.

**Access control**: Implement appropriate network security for sensitive installations or performances.

**Data privacy**: Consider what parameter data reveals about your project and users.

## Related processes

Teleplot works with any *score* process for data monitoring. It's particularly useful with [[Signal Display]] for local visualization, [[Mapping Tool]] for parameter analysis, or system monitoring alongside [[Audio Effects]] and device protocols.