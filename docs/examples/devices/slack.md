---
layout: default
title: Slack messages through Companion
description: "An example showing how to send Slack notifications from score"
parent: Device Examples
grand_parent: Examples
permalink: /examples/devices/slack.html
score: /examples/devices/slack.score
---

# Slack messages through Companion

![Send HELLO and Send BYE cues beside the CPU-monitoring timeline loop]({{ site.baseurl }}/assets/scores/thumbnails/examples-devices-slack.png)

This example demonstrates sending notifications from a score to a Slack channel. Manual cues send greetings, while a conditional loop warns when CPU usage crosses a threshold.

The Bitfocus Companion integration connects timeline states to Slack, showing how a scenario can communicate its activity without audio or graphics. These are real webhook requests: choose a test channel before running the example.

## Configure the connection

1. Install the Bitfocus Companion extension from score's Settings → Package Manager. A separate Companion application is not required for this example.
2. Follow Slack's [incoming webhook setup](https://docs.slack.dev/messaging/sending-messages-using-incoming-webhooks/) to create an app, authorize a channel and obtain its webhook URL.
3. Edit the `slack` device and configure that URL. Check that its Slack Webhooks module path exists in your installation. The saved path is `<LIBRARY>:packages/companion-modules/companion-bundled-modules/slack-webhooks`, with `main.js`, module identifier `slack-webhooks` and Node runtime `node22`.
4. Start playback and trigger `Send HELLO` or `Send BYE`. Confirm the corresponding message appears in the selected channel. Keep the webhook URL private when sharing a configured document.

## Inspect the monitoring loop

A System info device samples every 1000 ms. The second branch waits on `%sysinfo:/cpu/usage% >= 0.75`, then sends `Warning: CPU load over threshold` and returns through a zero-duration interval. The threshold in the saved expression is **75%**, despite an annotation that says 70%.

The incoming interval has a minimum duration of about 1.94 seconds and no finite maximum. While load remains high, the loop can send repeated warnings; it is not a one-shot notification. Stop playback or disable that branch when testing only the manual messages. Without the installed Companion module, a valid webhook and network access, the timeline can be inspected but cannot deliver Slack messages.

## Try it

With the monitoring branch disabled, change the text in one of the manual states and trigger it. This is a simple starting point for notifying collaborators when a performance or installation reaches a particular cue. Inspect the CPU condition to see how a measured value can trigger the same kind of message automatically.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

