---
layout: default
title:  "Musical metrics"

parent: In depth

permalink: /in-depth/musical.html
---

# Musical metrics
Musical metrics are hierarchic
  * the tempo, and musical position in an interval is either relative to this interval
    (if the 4/4 button in the inspector is pressed)
    or it's taking the musical information from its closest parent (recursively).

This means that it is possible to have polyrythmic scores.
The musical signature changes can be controlled by going into the children intervals in full view.

# Tempo
Likewise, by default the tempo is the global one. It is possible to add a tempo curve to an interval
to give it a different speed behaviour - its children will all take this tempo unless another more precise tempo is
given at a deeper nesting level.

# Usage
- Processes which are able to use tempo & metrics information (audio plug-ins, LFO, arpeggiator, etc) will do so automatically
- Triggers can be quantified to fall on the next quantification date from when they are triggered.



# Timing

How timing works in ossia score.

- Quantification
- Model time
- Physical time
