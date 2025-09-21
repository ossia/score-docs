---
layout: default

title: Teleplot
description: "Remote plotting and data visualization"

parent: Processes
grand_parent: Reference

permalink: /processes/teleplot.html
---
# Teleplot

![Teleplot]({{ site.img }}/reference/processes/teleplot.gif "Teleplot")

Send data to remote plotting applications for real-time visualization and analysis. Teleplot streams parameter data over network connections, allowing you to monitor and analyze your *score* project's behavior using external visualization tools.

Perfect for system monitoring, performance analysis, debugging complex control systems, or creating real-time data visualizations for presentations and installations.

## Using the teleplot process

1. Open [the Teleplot website](https://teleplot.fr/) or a Teleplot-compatible client, for instance the VSCode extension.
2. Create a Teleplot object in score.
3. Set the hostname and port from your teleplot instance: for instance, `teleplot.fr:45603`.
3. Set the list of addresses you want to plot through the [[Pattern matching|OSC pattern syntax]]. For instance, `my_device:/main/foo.*` would send all the nodes such as `/main/foo.1`, `/main/foo.bar`, etc.

## Try it!

Try it by downloading this [simple example!]({{ site.scores }}/reference/processes/teleplot.score)