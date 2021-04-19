---
layout: default

title: "Automations"
description: "How automations work in ossia score"

parent: In depth

permalink: /in-depth/automations.html
---

# Automations

Automations are a specific kind of *score* [[process]], which will change the value of a parameter in time according to a visual curve.

## Automation types

- Normal, 1D automation: [[automation (float)|documented here]].
- 2D automation: [[2D Spline|documented here]].
- Color automation: [[gradient|documented here]].

## Creating automations

It is possible to create automations in various ways besides dropping an automation process from the [[library]]:

* By drag'n'dropping a parameter from the [[Device explorer]] to the score.
* By using the [Interpolate States]({{ site.baseurl }}/processes/scenario.html#interpolate-states) feature.
* By right-clicking on a value (green) port and pressing the "Create Automation" button.

## Tweening

Automations can be tweened: that is, instead of starting from a fixed value,
the automation can instead ramp from the current value of the parameter it is automating,
in order to allow for smooth transitions. Check the inspector to enable the feature.

## Units

Automations can use the ossia score [[unit system]].

## Recording

It is possible to [[record]] messages from external devices as automations.

See also the [[preferences]] for various options concerning the way these automations are recorded.