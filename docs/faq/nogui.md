---
layout: default
title: "How to run score without GUI ?"

parent: FAQ

permalink: /docs/faq/nogui.html
category: "site-score"

description: "Using the commad line API to launch score witht GUI"

tag: "FAQ"
visible: true
---

# How to run *score* without GUI ?

Score can run in the background while not opening its full UI (which may be handy for example when running score in a video installation). To do so, you can launch score from the Command line using the following:

{% highlight bash %}
`$ ossia-score --no-gui --autoplay /home/oscar/my-score.score`
{% endhighlight %}

You may find other useful commands in the [command line reference page](/score-docs/docs/reference-manual/references/commandline.html).
