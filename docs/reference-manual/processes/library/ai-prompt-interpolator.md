---
layout: default

title: AI Prompt Interpolator
description: "Smoothly interpolate between different AI prompts"

parent: Processes
grand_parent: Reference

permalink: /processes/ai-prompt-interpolator.html
---
# AI Prompt Interpolator

![AI Prompt Interpolator]({{ site.img }}/reference/processes/ai-prompt-interpolator.png "AI Prompt Interpolator")

The AI Prompt Interpolator enables smooth transitions between different prompts, creating dynamic and evolving AI-generated content. This is essential for creating fluid, generative experiences where prompts gradually transform over time.

## Overview

This process intelligently blends between multiple prompts while maintaining semantic coherence. It's particularly useful for:
- Generative art installations with evolving themes
- Live performances with gradual style transitions
- Interactive experiences responding to user input

It will blend over time to enable controlling prompt-based systems: given the message "castle in the sky" at t=0 and the message "oasis trees" at t=1, the output will be: 

```
(castle in the sky: 1)
(castle in the sky: 0.9), (oasis trees: 0.1)
...
(castle in the sky: 0.1), (oasis trees: 0.9)
(oasis trees: 1)
```


## Related Processes

- [AI Prompt Composer](/processes/ai-prompt-composer.html) - Create structured prompts
- [Interpolator](/processes/interpolator.html) - General value interpolation
- [Tweener](/processes/tweener.html) - Advanced easing functions
- [Nodes](/processes/nodes.html) - 2D interpolation space