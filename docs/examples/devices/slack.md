---
layout: default
title: Slack messages through Companion
description: "Send a Slack message at a performance cue or monitored threshold, using timeline events as notifications to collaborators."
parent: Device Examples
grand_parent: Examples
permalink: /examples/devices/slack.html
score: /examples/devices/slack.score
---

# Slack messages through Companion

![Send HELLO and Send BYE cues beside the CPU-monitoring timeline loop]({{ site.baseurl }}/assets/scores/thumbnails/examples-devices-slack.png)

Manual cues send messages to a Slack channel, and a monitoring loop sends a warning when CPU usage meets a threshold, so collaborators can follow a rehearsal or installation from elsewhere.

The connection uses Bitfocus Companion's Slack module. These are real webhook requests, not a local message preview: choose a test channel before playback.

## Configure the connection

1. Install the Bitfocus Companion extension from score's Settings → Package Manager. A separate Companion application is not required for this example.
2. Follow Slack's [incoming webhook setup](https://docs.slack.dev/messaging/sending-messages-using-incoming-webhooks/) to create an app, authorize a channel and obtain its webhook URL.
3. Edit the `slack` device and enter the webhook URL. Check that its module path points to the installed Slack Webhooks module; the saved path is `<LIBRARY>:packages/companion-modules/companion-bundled-modules/slack-webhooks`. If you need to repair the selection, the module identifier is `slack-webhooks`, its entry point is `main.js`, and the saved Node runtime is `node22`.
4. Start playback and trigger `Send HELLO` or `Send BYE`. Confirm the message arrives in your test channel. Keep the webhook URL private when sharing a configured score; it authorizes posting to the channel.

## Inspect the monitoring loop

The System info device samples CPU usage once a second. The monitoring branch waits for `%sysinfo:/cpu/usage% >= 0.75`, sends `Warning: CPU load over threshold`, then loops back to wait again. The actual threshold is **75%**, despite a score annotation saying 70%.

This is repeated monitoring, not a one-shot alarm. The waiting interval has a minimum duration of about 1.94 seconds and no finite maximum; sustained high load can therefore produce repeated warnings. Stop playback or disable this branch while testing only the manual cues.

## Try it

With monitoring disabled, edit the message in one manual state and trigger it. Use the received message to check that the cue, connection and intended channel all agree before incorporating notifications into a performance.

Then inspect the CPU condition. A manual cue sends one message per trigger; a threshold keeps sending warnings as long as the condition persists, so test the monitoring branch only in a channel where repetition is acceptable.

Delivery needs the installed Companion module, a valid webhook and network access. Without those, you can inspect the timeline but cannot send a Slack message.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

