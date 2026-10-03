---
layout: default

title: Control utilities
description: "Useful processes for sending control messages"

parent: Processes
grand_parent: Reference

permalink: /processes/control-utilities.html
---

# Impulse metronome

![Impulse metronome]({{ site.img }}/reference/processes/impulse-metronome.png "Impulse metronome")

The simplest possible metronome, synchronized to its parent interval. Will send an impulse on each beat.

# Free metronome

![Free metronome]({{ site.img }}/reference/processes/free-metronome.png "Free metronome")

A desynchronized metronome. It can ignore the parent interval's tempo and will instead beat at its own unrelated speed, a bit like the `[metro]` objects in Pure Data or Max/MSP.

If "Quantify" is set on "Free", then the raw frequency in Hertz will be used as tempo source.
Else, the parent tempo is used. The rate can be chosen with the musical division selector.

See [Free Metronome]({{ site.baseurl }}/processes/metronome.html) for the current time-chooser-based version and legacy behaviour.

# Messages, routing and storage

| Task | Processes |
|---|---|
| Send a manual trigger or hold a repeated trigger | [Bang and Button]({{ site.baseurl }}/processes/mapping-utilities.html#bang) |
| Gate, select or distribute values | [Spigot, Mux and Demux]({{ site.baseurl }}/processes/mapping-utilities.html#spigot), [Switch]({{ site.baseurl }}/processes/switch.html) |
| Count arrivals or walk through a sequence | [Counter]({{ site.baseurl }}/processes/mapping-utilities.html#counter), [Enumerator]({{ site.baseurl }}/processes/array-utilities.html#enumerator) |
| Retain and release messages | [Buffer queue]({{ site.baseurl }}/processes/buffer-queue.html), [Value delay]({{ site.baseurl }}/processes/value-delay.html) |
| Join asynchronous values | [Rendezvous]({{ site.baseurl }}/processes/rendezvous.html) |
| Store indexed data | [Tables]({{ site.baseurl }}/processes/table.html) |
| Combine or choose inputs | [Value Mixer]({{ site.baseurl }}/processes/mapping-utilities.html#mix), [Multi-choice]({{ site.baseurl }}/processes/multi-choice.html) |
| Parse text and binary values | [Regex]({{ site.baseurl }}/processes/regex.html), [String / byte conversion]({{ site.baseurl }}/processes/string-bytes.html), [Value serialization]({{ site.baseurl }}/processes/value-serialization.html) |

Where a process uses musical or absolute durations, see [Time Chooser]({{ site.baseurl }}/reference/time-chooser.html). “Every tick” means every execution processing block, not every beat or graphics frame.

# String processing

## String tool

Send UTF-8 **Text** to apply **ASCII trim**, optional **Slice** (Start and Length in Unicode codepoints), literal **Find/Replacement**, ASCII **Case**, **Reverse**, **Rotate left**, **Repeat** and padding. **Min length**, **Max length** and **Max bytes** bound the result. Negative slice Start counts from the end; Length -1 retains the remainder. The output is **Text**, with failures on **Error**. Reversal works on codepoints, not grapheme clusters, so combined characters can separate.

## Split string

Splits **Text** into **Parts** using a literal **Delimiter**. An empty delimiter splits Unicode codepoints. **Keep empty** retains empty fields; **Max parts** and **Max bytes** bound processing. Invalid UTF-8 or exceeded limits are reported on **Error**.

## Join string

Joins a string list on **Parts** using **Separator**, emitting **Text**. **Max bytes** bounds output; invalid UTF-8 and limit failures go to **Error**. This is literal joining, not CSV quoting. Use [Value serialization]({{ site.baseurl }}/processes/value-serialization.html) when nested values or typed fields need a defined interchange format.

# File operations

These processes work with raw string data. Async execution keeps file operations on a worker; Sync can block execution and should not be used for slow storage during a real-time performance. Observe **Busy**, **Success** and **Error** rather than assuming a request completed immediately.

## Read File

Select **Path** and trigger **Read**. **Mode** chooses Whole, Range, Stream or Autostream. Whole reads a bounded file; Range uses byte **Offset** and **Count**; Stream requests chunks; Autostream delivers chunks as execution advances. **Maximum bytes** bounds reads, and **Timeout** bounds stream worker requests. Outputs include **Data**, **Bytes**, **Lines**, **EOF**, Busy, Success, Error and **Timed out**. Async Autostream may temporarily lack a chunk on startup or with slow sources; it is not an uninterrupted real-time streaming guarantee or a FIFO session.

## Read File Line

Select **Path**, trigger **Open**, then send **Next** for each line. **Rewind** restarts the cursor and **Close** ends it. **Maximum line bytes** bounds a line. **Line**, **Line number**, **Bytes**, **Open**, **EOF**, Busy, Success and Error expose results and status. LF and CRLF are supported, including blank lines.

## Write File

Each raw-string arrival on **Data** performs the selected **Mode** at **Path**: Ignore does nothing, Write replaces the file, WriteRange overwrites a byte range while preserving surrounding bytes, and Append adds data. **Offset** and **Count** apply to WriteRange. **Line ending** chooses None, LF or CRLF; **Maximum bytes** bounds writes. Bytes, Lines, Busy, Success and Error report results. Equal consecutive messages are distinct writes; retained values are not automatically replayed.

Save paths support `%n` (available numbered name) and `%t` (date/time). To append several chunks into one file, use a fixed resolved path rather than a fresh-name template for every write. For sampled device data with address columns and playback, prefer [CSV recorder]({{ site.baseurl }}/processes/csv-recorder.html).
