---
layout: default

title: "Score preferences"
description: "User preferences and settings of ossia score"

parent: Reference

permalink: /reference/preferences.html
---

## Audio
Audio settings allow to configure which sound card score is going to use for playback.

If no sound is needed, it is possible to set the "Dummy" engine which won't output sound.

## Execution

Note that every execution settings change require stopping and restarting the score.

### Enable listening during execution
This controls whether the Device Explorer panel updates its UI when the score is running. If there are thousands of parameters being updated all the time, monitoring them and updating the UI to show their new value can take some CPU usage which is not always required.

### Logging
When "Logging" is selected in the settings, if you click on the title of a process, then the Messages panel ({% include shortcut.html content="Ctrl+Shift+G" %}) will show all the messages getting in and out of that process.

### Benchmark
When "Benchmark" is selected in the settings, the relative computation time of each process will be computed. This is useful for instance to find if there is a super intensive process taking too much CPU.

### Advanced execution settings
#### Parallel
Runs the processes on separate CPU cores as far as possible.

#### Value compilation
When doing a "play from here", this will try to guesstimate in which state the score should be at that point, by looking for the closest previous sent messages in the score and sending them to the devices.


#### Transport value compilation
Same as value compilation, but redoes it every time you do a transport while the score is playing, with the "play" tool.


