---
layout: default

title:  Matrix Spatialization
description: "Spatializing sound according to loudspeaker weights"

parent: Processes
grand_parent: Reference

permalink: /processes/matrix-spatialization.html
score: /reference/processes/matrix-spatialization.score
---

# Matrix spatialization

![Matrix spatialization]({{ site.img }}/reference/processes/matrix-spatialization.png "Matrix spatialization") 

This process distributes a mono audio source across several output channels. Each channel receives the input multiplied by its weight and the overall Gain.

## Inputs and controls

| Name | Purpose |
|---|---|
| Input | Audio source |
| Weights | A flat list of output-channel gains |
| Gain | Overall multiplier, from 0 to 10; default 1 |
| Channel offset | Number of silent leading channels, from 0 to 128; default 1 |
| Audio outs | Number of channels after the offset, from 0 to 128; default 1 |

Output is a multichannel audio port. Its channel count is Audio outs plus Channel offset.

Set Channel offset to `0` for a direct correspondence between the weight list and output channels. For example, Audio outs `4`, Channel offset `0` and Weights `[1, 0.5, 0, 0.25]` distribute the source to four channels with those gains.

With a nonzero offset, the first channels are silent, but the weight index still follows the absolute output-channel index. For offset `1`, the first audible channel uses the second weight, not the first. Include leading entries in the weight list when using an offset.

If the list is too short, the last weight is repeated for the remaining channels. Supply one weight per output channel when each loudspeaker needs its own gain.

The current implementation does not mix multiple input channels: successive input channels overwrite the output. Use one Matrix Spatialization per mono source and mix their outputs for independent sources.

## Spatialization

Connect [[DBAP]]'s Output to Weights. For one source from [[GBAP]], pass its nested weight list through Array Flattener first. Set Audio outs to the speaker count and route Output to the corresponding audio-device channels.

See [[Spatial audio techniques]] for a complete four-speaker patch.

## Try it!

Try it by downloading this [simple example!]({{ site.scores }}{{ page.score }})