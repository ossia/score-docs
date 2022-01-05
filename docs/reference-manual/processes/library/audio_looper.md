---
layout: default

title: Audio looper
description: "Recording and playing back audio in a live setting"

parent: Processes
grand_parent: Reference

permalink: /processes/audio-looper.html
---
# Audio Looper

![Audio looper]({{ site.img }}/reference/processes/audio_looper.png "Audio looper example")

Different options are available when you use the audio looper: the operation mode and the passthrough.

- If passthrough is enabled, while recording and overdubbing, the input audio will be copied to the output of the looper.
- The looper's state change can be [quantized]({{ site.baseurl }}/in-depth/musical.html#quantization).
- In the inspector, it is possible to make the looper automatically change mode after a fixed amount of bars instead of waiting 
  on an automated change: the second "loop" parameter will control the state on which the looper moves after N bars in the initial state. 

## Play

Play what the looper recorded.

## Recording

Record the actual sound the looper is going to loop to.

## Overdub

Record on top of the already recorded sound.

## Stop

Output nothing.