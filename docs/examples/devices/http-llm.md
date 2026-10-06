---
layout: default
title: HTTP chat API and rendered text
description: "An example showing how to interact with a language model over HTTP"
parent: Device Examples
grand_parent: Examples
permalink: /examples/devices/http-llm.html
score: /examples/devices/http-llm.score
---

# HTTP chat API and rendered text

![Rendered chat response behind the prompt-string processing nodes and text animation timeline]({{ site.baseurl }}/assets/scores/thumbnails/examples-devices-http-llm.png)

This example demonstrates bringing an HTTP service into an interactive score. A local language model answers typed prompts, and the timeline animates the response as text.

## Overview

The HTTP device handles the conversation, while the visual processes present the question and answer. Keeping those roles separate lets you experiment with how generated text appears without changing the request itself.

The client uses the OpenAI-compatible `/v1/chat/completions` endpoint with conversation history. It requests a complete response rather than a token stream; the gradual reveal is an animation in score.

## Connect a server

1. Run an OpenAI-compatible server with a loaded model, for example `llama-server -m /path/to/model.gguf`. Neither the server nor model weights are included.
2. Set `LLM:/config/host` to the base URL, initially `http://127.0.0.1:8080`, and set `/config/model` to the server's model identifier if `default` is not accepted. Do not append `/v1`: the script adds the endpoint path.
3. Start playback, write a question to `LLM:/chat/prompt`, and inspect `/chat/response`. When a response arrives, an auto-retriggering time sync starts a ten-second automation of Answer's Write On control.
4. Send another prompt to continue the conversation. Send an impulse to `LLM:/chat/clear` to discard history. That action also requests `/health`; clearing the displayed response depends on receiving its answer.

## Try it

Ask a short question, then a follow-up that refers to the previous answer. Clear the history and ask the follow-up again to compare the results. Try changing the ten-second Write On automation: a quick reveal and a slow reveal give the same text a different rhythm.

The device also exposes sampling controls, `/chat/finish_reason` and token counts under `/chat/usage`. Its separate `/completion/prompt` request has no conversation history and is not connected to this display.

## Requirements and limits

The saved script does not set custom Authorization or Content-Type headers. Use a local server that accepts its requests, or configure a proxy to provide the headers required by your endpoint. It does not authenticate directly to a cloud API. `/health/check` assumes the server provides `/health`.

The graphics are JavaScript-rendered text textures mixed with a native ISF shader, not a Qt Quick 3D scene. The saved text preset comes from the default library's `Javascript/advanced-text/advanced-text.qml`. No microphone, audio synthesis or external media is involved.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

