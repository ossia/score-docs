---
layout: default
title: HTTP chat API and rendered text
description: "Turn a language-model reply into timed visual text, separating the pace of its presentation from the server's response."
parent: Device Examples
grand_parent: Examples
permalink: /examples/devices/http-llm.html
score: /examples/devices/http-llm.score
---

# HTTP chat API and rendered text

![Rendered chat response behind the prompt-string processing nodes and text animation timeline]({{ site.baseurl }}/assets/scores/thumbnails/examples-devices-http-llm.png)

Type a prompt and let a local language model supply text for the screen. When the answer arrives, score reveals it over time at a pace you set.

## Request and display

The HTTP device manages prompts and conversation history; the visual processes render the question and answer. The client requests a complete response from the OpenAI-compatible `/v1/chat/completions` endpoint. The gradual appearance of the answer is score's animation, not a stream of arriving tokens.

This separation lets you change how the text is presented without changing the conversation. A slower reveal does not make the server generate more slowly; it changes how the audience encounters the result.

## Connect a server

1. Run an OpenAI-compatible server with a loaded model, for example `llama-server -m /path/to/model.gguf`. Neither the server nor model weights are included.
2. Set `LLM:/config/host` to the base URL, initially `http://127.0.0.1:8080`, and set `/config/model` to the server's model identifier if `default` is not accepted. Do not append `/v1`: the script adds the endpoint path.
3. Start playback, write a question to `LLM:/chat/prompt`, and inspect `/chat/response`. When a response arrives, an auto-retriggering time sync starts a ten-second automation of Answer's Write On control.
4. Send another prompt to continue the conversation. Send an impulse to `LLM:/chat/clear` to discard history. That action also requests `/health`; clearing the displayed response depends on receiving its answer.

## Try it

Ask a short question, then a follow-up that depends on its answer. Clear the history and repeat the follow-up: without the earlier exchange, the model no longer knows what it refers to.

Keep the prompt fixed and shorten or lengthen the ten-second Write On automation, then try a longer answer: the same reveal duration gives different amounts of text a different reading pace.

Sampling controls are available on the device if you want to vary generation. For diagnosing a reply that stops unexpectedly, inspect `/chat/finish_reason` and the token counts under `/chat/usage`. The separate `/completion/prompt` request has no conversation history and does not feed this display.

## Requirements and limits

The saved script does not set custom Authorization or Content-Type headers. Use a local server that accepts its requests, or configure a proxy to supply the headers your endpoint requires; it cannot authenticate directly to a cloud API. Its health check expects a `/health` endpoint.

Text is rendered by the default library's advanced-text JavaScript preset and mixed with a native ISF shader. The patch has no microphone input or speech synthesis: the interaction is typed input and visual output.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

