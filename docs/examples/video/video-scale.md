---
layout: default
title: "Video transforms and fitting"
description: "Compare animated placement with fitting modes when adapting a movie to different display proportions."
parent: Video Examples
grand_parent: Examples
permalink: /examples/video/video-scale.html
score: /examples/video/video-scale.zip
---

# Video transforms and fitting

![A looping movie with timed transform and fitting controls]({{ site.baseurl }}/assets/scores/thumbnails/examples-video-video-scale.png)

See how the same movie changes when it is moved and rotated, then fitted into a different-sized output. This is a practical starting point for adapting a composition to a tall screen, a wide projection or another display proportion without confusing image placement with image fitting.

## Placement versus fitting

The first section shows the looping movie unchanged. Transform then animates its translation and rotation. Scale and Fit follows with an animated zoom and a sequence of fitting modes. Continuous automation creates movement, while timeline states switch between discrete ways of occupying the viewport.

## Try it

Open the ZIP directly in score and start playback. The animated transform begins at four seconds. Trigger the manual time-sync at the end of Transform to enter Scale and Fit.

- Change the Window render size or aspect ratio and compare the fitting modes. Look for what is preserved, cropped or stretched as the source occupies the new viewport.
- Alter a Transform automation curve to change the movie's motion without changing the output proportions.
- Compare the zoom animation with a fitting-mode change: one evolves continuously, while the other changes the rule used to place the image.

Keep the movie and Scale and Fit intervals running to observe the mode sequence; their ending time-syncs are manual. No camera or network source is required.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
