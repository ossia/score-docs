---
layout: default
title: Using score in the browser
description: "Opening, playing and saving projects in the WebAssembly version of score"
parent: Quick start
permalink: /quick-start/using-score-in-the-browser.html
---

# Using score in the browser

Open [score for the web](https://ossia.io/score-web/) to work without installing the desktop application. This page describes the current development web build, not a promise that every desktop process or device works in a browser.

## Before starting

Use an up-to-date browser with **WebAssembly JavaScript Promise Integration (JSPI)**. The loader checks for `WebAssembly.Suspending` and `WebAssembly.promising`; without them it displays an explanation instead of starting score. Follow that message if your browser requires a setting, or switch to a browser providing those APIs. Browser name alone is not a compatibility guarantee.

The threaded build also needs shared WebAssembly memory and a cross-origin-isolated page. Use the hosted HTTPS application, rather than opening a downloaded HTML file directly. Audio uses **Web Audio (MiniAudio)** and an AudioWorklet; camera capture additionally needs `getUserMedia`, `MediaStreamTrackProcessor` and WebCodecs video frames. A browser capable of launching score may still lack camera support.

Allow time for the application and its bundled library to download. The application, imported media and decoded media consume browser memory: start with a small project before trying a large desktop session.

## Open a document and bring in media

- Use **File → Open** to select a `.score`, `.scorejson`, `.scorebin` or project `.zip` file. The browser grants access to the selected file, not its entire surrounding folder.
- Drop supported media files into the timeline as on desktop. score copies the dropped bytes into its virtual filesystem; it cannot follow arbitrary paths on your computer.
- For an existing project with media, prefer a **project ZIP archive** rather than a bare score file. Absolute desktop media paths are not accessible to the web application. Package the project on desktop with **Archive project...**, then open the ZIP in the browser.

The deployed application includes a snapshot of the user library. Its presence does not guarantee that every library preset can run: some require desktop-only processes, devices or external files.

### Opening a shared URL

The page accepts `?open=` followed by a document or project ZIP URL, for example:

```text
https://ossia.io/score-web/?open=/path/to/project.zip
```

This is a URL pattern, not a bundled example. The document must be served from the **same origin** as the application (same scheme, host and port). For a file on another site, download it first and use **File → Open**. Only open projects from sources you trust: documents can contain scripts and device addresses.

The URL importer accepts ordinary stored or deflated ZIPs, not ZIP64. It limits downloads to 256 MiB and total extracted file data to 512 MiB. These are URL-import limits, not a guarantee that a project of that size will play successfully.

## Audio and camera permissions

Interact with the page before starting playback: browser autoplay policies can suspend audio until a user gesture. The Web Audio backend requests microphone input, so the browser may show a microphone permission prompt even when you first intend to play a score. Captured input remains silent until permission is granted. Check the site's permissions if input is missing.

Camera discovery may itself request camera permission so that device names become available. Allow camera access, select the camera in score, and check the browser's camera indicator. Capture requires a secure context and the camera APIs listed above; denying access or using an unsupported browser prevents capture. Desktop capture-card and camera-driver integrations are not interchangeable with browser camera capture.

## Save outside the tab

**Save / Save As** hands a JSON `.score` document to the browser's save/download mechanism; it does not silently overwrite the original local file. A score file alone does not include its media.

Use **Archive project...** to download a ZIP containing the document and the media collected from its project folder. Check that referenced media is available before archiving: an archive cannot recover missing files. Keep the resulting download somewhere persistent before reloading or closing the tab.

Preferences and crash-recovery document/command data use the site's **local storage**. They can survive a reload, but clearing site data, private browsing policies or storage limits can remove them. Imported media lives in an in-memory filesystem: recovery data is not a persistent media library or a substitute for a downloaded project archive.

## When to use the desktop application

- **JavaScript processes do not execute in the web build.** Their execution component explicitly rejects browser execution; do not interpret the JavaScript used to launch the web page as support for score's JavaScript process.
- Native plug-ins and drivers cannot be loaded into WebAssembly. Desktop VST/LV2 installations and platform-specific video, hardware and device SDKs do not become available to the browser.
- Browser networking is sandboxed. A desktop OSC/UDP, raw TCP, serial or hardware workflow must not be assumed to work unchanged; browser-compatible transports need a compatible endpoint and the appropriate build support.
- Filesystem access, background execution and permissions are controlled by the browser. Keep the application in the foreground for interactive work; use desktop score for a deployment requiring native devices or dependable unattended operation.

See [Installation]({{ site.baseurl }}/quick-start/installation.html) for desktop options, or [Building for WebAssembly]({{ site.baseurl }}/development/build/wasm.html) for hosting and build details.
