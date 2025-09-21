---
layout: default

title: Tweener
description: "Smooth parameter interpolation and easing"

parent: Processes
grand_parent: Reference

permalink: /processes/tweener.html
---
# Tweener

![Tweener]({{ site.img }}/reference/processes/tweener.gif "Tweener")

Create smooth transitions between values with professional easing curves. Instead of abrupt parameter changes, Tweener provides fluid, organic movement that feels natural and polished.

Essential for creating smooth animations, gentle parameter transitions, or any time you need to interpolate between different values with precise timing control.
It uses the duration of the parent interval as temporal reference: the tween will start at the beginning of the interval and will end at its end.


## Related processes

[[Easetanbul]] is the temporal alter-ego of Tweener: while Tweener tweens between its two inlets, [[Easetanbul]] tweens between incoming values.

[[Automation]] allows to tween but only between one value known in advance and one unknown, [[Tweener]] instead allows to tween between two unknown values.

## Try it!

Try it by downloading this [simple example!]({{ site.scores }}/reference/processes/tweener.score)