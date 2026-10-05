---
layout: default
title: "Video transforms and fitting"
description: "Compare texture copying, geometric transforms and output-size fitting."
parent: Video Examples
grand_parent: Examples
permalink: /examples/video/video-scale.html
score: /examples/video/video-scale.zip
---

# Video transforms and fitting

![Cat video above Passthrough, Transform and Scale and Fit intervals with automation curves]({{ site.baseurl }}/assets/scores/thumbnails/examples-video-video-scale.png)

A looping cat movie feeds three successive processing intervals: Passthrough, Transform, and Scale and Fit. Each writes to `Window:/` while active. Transform has a rotation automation plus separate X/Y translation automations at `score:/controls/Transform/translate@[0]` and `@[1]`. Timeline states change its extend mode.

## Try it

Open the ZIP directly in score; it includes `cat.mov`. Start playback: Passthrough runs first, followed by Transform at four seconds. Trigger the manual time-sync at the end of Transform to enter Scale and Fit. Its zoom is automated; a separate state sequence cycles fitting modes through local `score:/controls/Scale and Fit` addresses.

Compare the result after changing the Window render size or aspect ratio. Transform changes image placement, whereas Scale and Fit chooses how the source occupies a destination viewport. Keep the Scale and Fit and movie intervals running while observing their mode changes; their ending time-syncs are manual. The archive includes the movie and shader code, with no camera or network source required.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
