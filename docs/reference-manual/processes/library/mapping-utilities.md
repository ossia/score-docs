---
layout: default

title: Mapping utilities
description: "Mapping utilities"

parent: Processes
grand_parent: Reference

permalink: /processes/mapping-utilities.html
---
# Mapping utilities


These processes route, combine and trigger control values. They do not process audio samples; use [Audio utilities]({{ site.baseurl }}/processes/audio-utilities.html) for audio buses.

## Spigot

Passes **Input** events to **Output** only while **Enabled** is on. Closed means no new output event, not an output value of zero.

## Repeat

Retains the last valid **Input** and emits it continuously on **Output** while executing. This converts a sporadic message into a continuously available control value.

## Mux inlets {#mux}

Set **Input count**, connect values to the generated inputs, then choose the zero-based **Current index** to select the value sent to **Output**. Keep the index within the available input count.

## Demux outlets {#demux}

Set **Output count** and select the zero-based **Current index**. The **Input** value is assigned to that outlet. For routing by exact value rather than by index, use [Switch]({{ site.baseurl }}/processes/switch.html).

## Counter

Each message to **Increase** increments the counter. **Count** reports it; **Ceiling** signals when the internal count reaches or exceeds **Max**. **Mode** is Free, Clip, Wrap or Fold, shaping the reported count relative to Max. **Reset** returns the internal counter to zero; **Output** requests the current shaped value without incrementing. **Send** selects EveryTick, OnInput or Manually. In manual mode, Reset changes state without sending Count until Output is triggered.

## Value Mixer {#mix}

**Input count** creates numeric inputs with individual **Mix**, **Solo** and **Mute** controls. A solo selects the soloed group; muting still excludes a soloed input. **Output** is the selected combination:

- **Mix** averages the gain-scaled active inputs by active input count.
- **Weight** divides their weighted sum by the sum of weights.
- **Min**, **Max**, **Multiply** and **Sum** combine gain-scaled values accordingly.
- **Difference** returns the negative sum of the active gain-scaled inputs.
- **AltSum** adds even-indexed inputs and subtracts odd-indexed inputs.

Use [Multi-choice]({{ site.baseurl }}/processes/multi-choice.html) instead to select one confident winner, rather than mixing its value.

## Impulse

Converts each **Message** into an **Impulse**. **Skip false-y values** suppresses zero, false, empty strings and empty containers; an incoming impulse still triggers.

## Bang

Press **Bang** to send one event on **Impulse**. This is useful for manually requesting output from [Buffer queue]({{ site.baseurl }}/processes/buffer-queue.html) or Counter.

## Button

Hold **Hold** to send an **Impulse** every processing tick while pressed. Unlike Bang, it repeats for the duration of the press. A connected impulse acts as a one-tick press, not a latched toggle.

## Flip Flop {#flipflop}

Each received **Input** toggles the boolean state. **Output** continuously reports the state, initially false.

## Repetition Filter

Passes the first **Input**, then only values different from the previous input to **Output**. Use it to suppress repeated values before an event-driven destination.

## Basic value sources

### Integer {#integer}

Emits the integer **Value** setting on **Integer** while executing.

### Float {#float}

Emits the numeric **Value** setting on **Out** while executing.

### String {#string}

Emits the text in **Value** on **Out** while executing.

## More mappings

- [Regex]({{ site.baseurl }}/processes/regex.html): search, capture, replace and split text.
- [Rendezvous]({{ site.baseurl }}/processes/rendezvous.html): emit only once all inputs have fresh values.
- [Value delay]({{ site.baseurl }}/processes/value-delay.html): delayed taps, feedback and smoothing.
- [Array utilities]({{ site.baseurl }}/processes/array-utilities.html): numerical array processing and enumeration.
- [Mapping tool]({{ site.baseurl }}/processes/mapping-tool.html): scale and shape a numerical range.
- [String / byte conversion]({{ site.baseurl }}/processes/string-bytes.html) and [Value serialization]({{ site.baseurl }}/processes/value-serialization.html): data interchange.