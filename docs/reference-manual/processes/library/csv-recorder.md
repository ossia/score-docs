---
layout: default

title: CSV recorder
description: "Record and replay input addresses to a .csv file"

parent: Processes
grand_parent: Reference

permalink: /processes/csv-recorder.html
---

# CSV Recorder

![CSV Recorder]({{ site.img }}/reference/processes/csv-recorder.png "CSV recorder Example")

This process allows to record a set of addresses matching an [[Pattern matching|address pattern]] expression.

It will create a CSV file containing the recorded data, one row per address matched by the pattern.

For instance, in the screenshot above, the following configuration would recreate a CSV file on each playback of the score called `/tmp/save.csv` with content such as :

```csv
timestamp,/0/co2,/1/co2,/2/co2
0,0.5429007,0.6073362,0.3612722
63,0.5429007,0.6073362,0.3612722
127,0.5429007,0.6073362,0.3612722
191,0.5037621,0.42720786,0.28013167
255,0.6991433,0.42720786,0.47998703
319,0.8627539,0.42720786,0.36869702
383,0.9684921,0.42720786,0.8776827
447,0.9994888,0.42720786,0.36079046
511,0.95079887,0.42720786,0.80060333
575,0.8301902,0.42720786,0.39480355
639,0.65690416,0.42720786,0.7897841
```

with a row of data saved every 0.05 seconds (50 milliseconds).

For archiving purposes, it is possible to use the `%t` macro in the filename which will be replaced by the date of recording in the filename.

Given an existing CSV file, `Playback` or `Loop` mode will play the content back.