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

The **CSV** process records and replays device parameters matching an [[Pattern matching|address pattern]] expression. Each matched address becomes a column; each sampling time becomes a row.

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

## Controls and replay

**Interval** sets the sampling interval with a [Time Chooser]({{ site.baseurl }}/reference/time-chooser.html). The recording samples current parameter values at that interval; it is not a log of every intervening message. **Timestamped** uses the first column for timestamps in milliseconds. **Mode** selects recording, Playback or Loop. During playback, column addresses must resolve to parameters in the current device tree.

**Separator** selects comma, semicolon or pipe. The comma option is currently labelled **Colon** in the control, despite writing `,`. Strings containing separators or quotes are escaped, and the player reads quoted strings and pipe-separated data back. Match the separator to the file when importing.

## Filenames and takes

**File pattern** accepts `%t`, replaced by the current UTC date/time with colons changed to underscores, and `%n`, replaced by an available number in the resolved destination directory. A path ending in `capture-%n.csv` keeps separate takes; a fixed filename can be overwritten when recording starts again.

For playback, select the actual recorded filename rather than a template that generates a new name. Keep the destination directory writable and the recorded device addresses available for replay. For audio rather than device values, use [Audio recorder]({{ site.baseurl }}/processes/audio-recorder.html).