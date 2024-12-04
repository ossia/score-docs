---
layout: default

title: "Data processing and filtering"
description: "Data processing and filtering"

nav_order: 12
parent: Common practices

permalink: /common-practices/12-data-processing.html
---

# Data processing

*score* provides a set of facilities to process, filter and route sensor data, through various objects implementing useful behaviours.


## List of useful objects

Most of the objects useful for data mapping are in the process library, in the `Control > Mappings` and `Control > Data Processing` categories.

- [[Mapping (float)|Mapping curve]]
- [[Range Filter]]
- [[Calibrator]]
- [[Math expressions]]
- [[Rate limiter]]
- [[Object filter]]
- [[Smooth]]
- [[Pattern applier]]
- [[Pattern combiner]]
- [[Sweeper]]

## Creating a data processing pipeline from a sensor to an object.

The architecture of such projects generally involve:

- Input sensors.
- Outputs (sound, video, or various embedded or electronical devices)
- A score which defines how the inputs map to the outputs over time.

The inputs and outputs will be represented as devices in the [[Device explorer]]:

![Input and output devices]({{ site.img }}/common-practices/data-processing/data.1.png "Input and output devices")

The score can then map inputs to outputs, for instance through a [[Mapping (float)|Mapping curve]] which can be dropped inside the score.
Do not forget to hit "Play" for the mapping to start! And remember: the box has to be connected to the start of the score for the mapping to run.
To have mappings that run permanently, add a [[Breaking the timeline|trigger]] to the end of the box which contains the mappings. 

The inputs and outputs of the mapping curve can be adjusted by dropping the addresses on the ports from the explorer: 

![Mapping]({{ site.img }}/common-practices/data-processing/map.gif "Mappings")