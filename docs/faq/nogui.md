---
layout: default

title: "How to run score without GUI ?"
description: "Using the command line API to launch score witht GUI"

parent: FAQ

permalink: /faq/nogui.html
---

# How to run *score* without GUI ?

Score can run in the background while not opening its full UI (which may be handy for example when running score in a video installation). To do so, you can launch score from the Command line using the following:

{% highlight bash %}
`$ ossia-score --no-gui --autoplay /home/oscar/my-score.score`
{% endhighlight %}

You may find other useful commands in the [command line reference page]({{ site.baseurl }}/reference/commandline.html).
