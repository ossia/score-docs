---
layout: default

title: "Polyphonic behaviours"
description: "Leveraging multi-channel data efficiently"

parent: In depth

permalink: /docs/advanced/polyphony.html
---

ossia supports some amount of polyphony especially for audio process.

Note that the polyphony has only been implemented with Faust at the moment and select Avendish processes.

To support polyphony:

- The audio processor must be a mono one. For instance, in a Faust process, make sure that you only have one input and one output: `process = _ : _;`.

- From now on, the right number of channels will be instantiated: sending 3 channels in will result in 3 processed channels out.

- In addition, it is possible to control the parameters on each channel individually: instead of sending a `float` to the port, sending a `list` will map each value to each individual channel.
