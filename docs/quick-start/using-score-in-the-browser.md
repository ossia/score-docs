---
layout: default
title: Using score in the browser
description: "Opening, playing and saving projects in the WebAssembly version of score"
parent: Quick start
permalink: /quick-start/using-score-in-the-browser.html
---

# Using score in the browser

Open [score for the web](https://ossia.io/score-web/) to work without installing the desktop application. Only features supported by web browsers can be used in the WASM builds of score.

## Before starting

Use an up-to-date browser with WebAssembly JavaScript Promise Integration (JSPI). The loader checks for `WebAssembly.Suspending` and `WebAssembly.promising` and explains which APIs are missing if it cannot start.

The threaded build needs shared WebAssembly memory and a cross-origin-isolated page. Use the hosted HTTPS application rather than opening a downloaded HTML file directly. Audio uses Web Audio (MiniAudio) and an AudioWorklet; camera capture also needs `getUserMedia`, `MediaStreamTrackProcessor` and WebCodecs video frames.

Allow time for the application and its bundled library to download. The application, imported media and decoded media consume browser memory: start with a small project before trying a large desktop session.

## Open a document and bring in media

- Use **File → Open** to select a `.score`, `.scorejson`, `.scorebin` or project `.zip` file. The browser grants access to the selected file, not its entire surrounding folder.
- Drop supported media files into the timeline as on desktop. score copies the dropped bytes into its virtual filesystem; it cannot follow arbitrary paths on your computer.
- For an existing project with media, prefer a **project ZIP archive** rather than a bare score file. Absolute desktop media paths are not accessible to the web application. Package the project on desktop with **Archive project...**, then open the ZIP in the browser.

The application includes a snapshot of the user library. Presets requiring desktop-only processes, devices or external files need adapting for the browser.

### Opening a shared URL

The page accepts `?open=` followed by a document or project ZIP URL, for example:

```text
https://ossia.io/score-web/?open=/path/to/project.zip
```

Replace `/path/to/project.zip` with a document served from the same origin as the application (same scheme, host and port). For a file on another site, download it first and use File → Open.

The URL importer accepts stored or deflated ZIPs, but not ZIP64. Downloads are limited to 256 MiB and total extracted file data to 512 MiB. Playback memory requirements depend on the project's media and processing.

## Audio and camera permissions

Interact with the page before starting playback: browser autoplay policies can suspend audio until a user gesture. The Web Audio backend requests microphone input, so the browser may show a microphone permission prompt even when you first intend to play a score. Captured input remains silent until permission is granted. Check the site's permissions if input is missing.

Camera discovery may request permission to read device names. Allow camera access, select the camera in score, and check the browser's camera indicator. Capture requires HTTPS and the camera APIs listed above.

## Save outside the tab

Save / Save As downloads a JSON `.score` document through the browser. This file contains the score, not its media.

Use Archive project... to download a ZIP containing the document and its collected project media. Relink missing media before archiving, and save the download before closing or reloading the tab.

Preferences and crash-recovery data use the site's local storage. Clearing site data or using private browsing can remove them. Imported media lives in memory, so download a project archive to keep it.

## When to use the desktop application

- JavaScript processes do not execute in the web build.
- Desktop VST/LV2 plug-ins and native hardware drivers require desktop score.
- Browser networking supports browser-compatible transports and endpoints, rather than raw desktop OSC/UDP and TCP sockets.
- Keep the tab in the foreground for interactive work. Use desktop score for unattended installations and native device access.

See [Installation]({{ site.baseurl }}/quick-start/installation.html) for desktop options, or [Building for WebAssembly]({{ site.baseurl }}/development/build/wasm.html) for hosting and build details.
