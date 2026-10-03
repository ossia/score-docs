---
layout: default
title: "Multi-choice"
description: "Select a confident winner from several control inputs"
parent: Processes
grand_parent: Reference
permalink: /processes/multi-choice.html
---

# Multi-choice

Multi-choice chooses among numeric inputs after smoothing, useful for selecting a gesture or classification result without immediately reacting to every fluctuation.

**Input count** creates the **In** ports. **Smooth** sets the smoothing coefficient: smaller values respond more slowly. A winner must exceed **Threshold**, and exceed the runner-up by more than **Margin**. **Output index** is zero-based and announces a newly accepted winner. An ambiguous frame clears the accepted choice internally and sends no index; it does not send a special “none” number. **Current Weights** provides the smoothed values for monitoring.

Connect Current Weights to [LED View]({{ site.baseurl }}/processes/led-view.html) while tuning Threshold and Margin. For an immediate minimum/maximum and softmax probabilities from one array, use Array Best Match in [Array utilities]({{ site.baseurl }}/processes/array-utilities.html#best-match).
