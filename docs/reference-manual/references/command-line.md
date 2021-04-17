---
layout: default

title: "Command line API"
description: "Options for the score start-up"

parent: Reference

permalink: /reference/commandline.html
---

You can launch ossia score from the command line or shell scripts with various useful options.

## Command-line reference

### Getting the list of options
{% highlight shell %}
$ ossia-score --help
{% endhighlight %}

### Loading a score on startup:
{% highlight bash %}
$ ossia-score filename

# For example:
$ ossia-score /home/oscar/my-score.score
{% endhighlight %}

### Playing a score on startup
{% highlight bash %}
$ ossia-score --autoplay filename

# For example:
$ ossia-score --autoplay /home/oscar/my-score.score
{% endhighlight %}

### Playing a score on startup after some delay
This is useful if for instance the score has audio plug-ins that take some time to load, such as
orchestral plug-ins with large sound banks.

{% highlight bash %}
$ ossia-score --autoplay filename --wait delay_in_seconds

# For example:
$ ossia-score --autoplay /home/oscar/my-score.score --wait 5
{% endhighlight %}

### Loading score without showing the GUI
{% highlight bash %}
$ ossia-score --no-gui
{% endhighlight %}
(note: this is not very useful without specifying a file to load).

### Loading score without showing the "do you want to restore" pop-up dialog
  This is useful if you are quitting score for instance by killing the process, as score will register that as a crash, which will cause the
  pop-up to show up next time.
{% highlight bash %}
$ ossia-score --no-restore
{% endhighlight %}

### Loading score in software rendering mode
ossia score uses as of v3 OpenGL for rendering the main timeline.
On some old machines or machines with bad GL drivers, this can cause issues. We then recommend using that switch to launch it.

{% highlight bash %}
$ ossia-score --no-opengl
{% endhighlight %}

## Complete recommended command line to launch a score on startup

### On Linux:
{% highlight console %}
$ /usr/bin/ossia-score --no-gui --no-restore --wait 5 --autoplay "/path/to/your/score.score"
{% endhighlight %}


### On macOS:
{% highlight bash %}
$ /Applications/Score.app/Contents/MacOS/score --no-gui --no-restore --wait 5 --autoplay "/path/to/your/score.score"
{% endhighlight %}


### On Windows:
{% highlight dosbatch %}
> "c:\Program Files\ossia score\score.exe" --no-gui --no-restore --wait 5 --autoplay "c:\path\to\your\score.score"
{% endhighlight %}