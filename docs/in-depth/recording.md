---
layout: default

title: Recording
description: "Recording external parameter changes"

parent: In depth

permalink: /in-depth/recording.html
---

# Recording

This records changes to device addresses as automations, rather than recording an audio or video file.

1. Select addresses in the [[Device explorer]].
2. Right-click at the desired position in the score.
3. Select **Record automations from here**. Recording is now waiting for input.
4. Change a selected parameter to send its first message, or press Play to start playback and the waiting recording together.
5. Press Stop when finished.

Starting playback while recording waits establishes the recording's start time immediately; it does not wait for another message. With **Play while recording** enabled in [Score preferences]({{ site.baseurl }}/reference/preferences.html), receiving the first message can also start playback automatically.

The separate **Record messages from here** action captures messages in states rather than automation curves.

See [Seek and transport]({{ site.baseurl }}/common-practices/9-seek-and-transport.html) for playback positioning and [Editing workflow]({{ site.baseurl }}/reference/editing-workflow.html) for live editing restrictions.