---
layout: default
title: "Video transforms and fitting"
description: "An example showing how to position, transform and fit video to its output."
parent: Video Examples
grand_parent: Examples
permalink: /examples/video/video-scale.html
score: /examples/video/video-scale.zip
---

# Video transforms and fitting

![Cat video above Passthrough, Transform and Scale and Fit intervals with automation curves]({{ site.baseurl }}/assets/scores/thumbnails/examples-video-video-scale.png)

This example demonstrates changing how a video is positioned and fitted to its output.

## Overview

The same looping movie is shown unchanged, then translated and rotated, then fitted to the available space. Automation and timeline states make it possible to compare continuous motion with changes of fitting mode. This is useful when adapting a composition to displays with different proportions.

## Try it

Open the ZIP directly in score; it includes `cat.mov`. Start playback to see the unchanged movie, followed by the animated transform at four seconds. Trigger the manual time-sync at the end of Transform to enter Scale and Fit, where the zoom is animated and a sequence cycles through fitting modes.

Compare the result after changing the Window render size or aspect ratio. Transform changes image placement, whereas Scale and Fit chooses how the source occupies a destination viewport. Keep the Scale and Fit and movie intervals running while observing their mode changes; their ending time-syncs are manual. The archive includes the movie and shader code, with no camera or network source required.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
