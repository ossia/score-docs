---
layout: default

title: Start/stop cues
description: "Actions when playing and stopping the score"

nav_order: 7
parent: Common practices

permalink: /common-practices/7-start-stop-cues.html
---

# Start and stop cues

We want to send a [[Cues|cue]] whenever the score starts playing, and whenever it is stopped.

To do so:

- Dropping a cue from the [[Device explorer]] on the first state at the top left of the score, in timeline view, will make that state being played:
* Whenever the score is started (for instance when pressing the Global Play button).
* Whenever the score is reinitialized (for instance when pressing the Reinitialize button).

- Dropping a cue on the last state at the top right of the score, in timeline view, will make that state being played:
* Whenever the score is stopped (for instance when pressing the Stop button).

Remember that the transport bar's button are in the following order:

![Transport bar]({{ site.img }}/common-practices/transport.png)
1. Local play
2. Global play
3. Stop
4. Reinitialize

## Example

![Start / stop cues example]({{ site.img }}/common-practices/start-stop-cues-example.png)

Consider the above score.

When pressing "Global Play":
* `test:/lights 1` is sent.
* The score plays.

Then, when pressing "Stop":
* The playback is stopped.
* `test:/sound 0` is sent.

If instead of pressing "Stop", "Reinitialize" had been pressed:
* The playback is stopped.
* `test:/sound 0` is sent.
* `test:/lights 1` is sent.

If "Reinitialize" is pressed while the score isn't playing:
* `test:/lights 1` is sent.
