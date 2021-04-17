---
layout: default
title: Javascript

parent: Processes
grand_parent: Reference manual

permalink: /processes/javascript.html
---

# Javascript support

## Scripting in Javascript / QML.
*score* allows to write scripts using the JavaScript language. Thses scripts can be used to write specific processes such as value mappers, audio generators.

*score* uses JavaScript version ES7. See the [JavaScript reference](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference) for more information about JS language.

It also uses QML (property real, etc.). See the [QML Reference](https://doc.qt.io/qt-5/qmlreference.html) for more information.

Setting the path to a file is possible

## Editing code

An important thing to note is that the edited script *won't* be saved in the scenario if there are compilation errors.

## General syntax

Every script must contain
{% highlight qml %}
import Score 1.0
{% endhighlight %}
somewhere at the top.

A script defines a javascript object, with :
- Input and output ports
- Callbacks that are called either regularly on every tick, or on special events (start, stop, pause, resume).

The smallest valid empty script looks like this:
{% highlight qml %}
import Score 1.0
Script {
  tick: function(token, state) { }
}
{% endhighlight %}

The tick function's two arguments give both timing and contextual information useful for writing algorithms.

Please read the [Timing]({{ site.baseurl }}/reference/musical.html#timing) page to understand the timing concepts used in ossia score, in particular
how model, physical and musical dates relate to each other.

### Token object

Important note: due to the way numbers work in Javascript (that is, double-precision floating point numbers),
and due to the timing units, scripts can only be expected to be accurate for representing durations no greater than 147 days.

That is, if a time interval lasts a year, after 147 days the timing values returned by `prev_date`, `date`, ... may not be accurate anymore.
This limit is pushed back to the hard limit of 414 years when using the C++ integer-based API instead.

Note that this does not affect for instance, scores with normal durations which would loop back to the beginning - permanently running installations are safe.

#### Properties

- `previous_date`: the model date at which the tick starts.
- `date`: the model date at which the tick ends
- `parent_duration`: the nominal model duration of the closest parent interval.
- `offset`: the model date at which we must start reading from our input.
- `speed`: current speed (a multiplicative factor).
- `tempo`: current tempo.

- `musical_start_last_signature`: what is the position in quarter notes of the closest previous musical signature change to `previous_date`.
- `musical_start_last_bar`: what is the position in quarter notes of the closest previous bar change to `previous_date`.
- `musical_start_position`: what is the position of `previous_date` in quarter notes.
- `musical_end_last_bar`: what is the position in quarter notes of the closest previous musical signature change to `date`.
- `musical_end_position`: what is the position of `date` in quarter notes.

- `signature_upper`: 6 in "6/8", at the start of the tick.
- `signature_lower`: 8 in "6/8", at the start of the tick.

#### Methods

- `logical_read_duration()`: how long are we reading from the model data.

- `physical_start(ratio)`: at which sample in the output must we start to write.
- `physical_read_duration(ratio)`: how many samples are we reading from the input ports.
- `physical_write_duration(ratio)`: how many samples are we writing to the output ports.
- `to_physical_time_in_tick(time, ratio)`: convert a model time into a physical time.
- `from_physical_time_in_tick(time, ratio)`: convert a time in physical dates, to a time in model dates.

- `in_range(time)`: check that the model time given is indeed in the range of this tick.

- `position()`: where are we in relation to our parent interval. 0 is the beginning, 1 is the nominal duration. If an interval has a greater max, or is infinite, this will go beyond 1.
- `forward()`: is the time going forward in this tick (speed > 0).
- `backward()`: is the time going backward in this tick (speed < 0).
- `paused()`: is the time going anywhere in this tick (speed == 0). Note that there is a difference between setting the speed to zero, and pressing the "pause" button - in the first case, processes will still keep being executed, just with no duration.
- `get_quantification_date(quant)`: get a model date if there is a quantification date for the requested quantification in this tick. -1 is returned if there isn't any.

- `get_physical_quantification_date(quant, ratio)`: get a physical date if there is a quantification date for the requested quantification in this tick. -1 is returned if there isn't any.

### State object
The `state` object contains global properties relevant for the whole score execution.

#### Properties

- `sample_rate`: explicit.
- `buffer_size`: explicit.
- `model_to_physical`: the ratio to pass to the `token` functions going from model to physical dates.
- `physical_to_model`: the ratio to pass to the `token` functions going from physical to model dates.
- `physical_date`: how many samples have elapsed since the score has started playing.
- `start_date_ns`: the date in nanoseconds when the score started playing.
- `current_date_ns`: the current date in nanoseconds.

## Example of a value mapper

{% highlight qml %}
// Necessary for the Script object.
// It is also possible to import QtQml 2.15
import Score 1.0

// Create our script object
Script {
  // Define the inputs & outputs - they are sub-objects of the script object
  ValueInlet { id: in1 }
  ValueOutlet { id: out1 }
  FloatSlider { id: slider; min: 10; max: 100; }

  // QML syntax for defining a floating-point constant
  readonly property real my_constant: 1.234

  // This function is called on each tick.
  tick: function(token, state) {
    // has a message been received ?
    if (typeof in1.value !== 'undefined') {
      // print it in the console
      console.log(in1.value);

      // transform it with some math operations.
      var newValue = in1.value + slider.value * Math.random() + my_constant;

      // write it in the output
      out1.value = newValue;
    }
  }

  start: function() { console.log("I am called on start"); }
  stop: function() { console.log("I am called on stop"); }
  pause: function() { console.log("I am called on pause"); }
  resume: function() { console.log("I am called on resume"); }
}
{% endhighlight %}

Note: it is also possible to access the list of messages with their precise timing, with `values`.

## Example of an audio generator

{% highlight qml %}
import Score 1.0

Script {
  // Declare our inputs & outputs
  FloatSlider { id: in1; min: 20; max: 800; init: 440; objectName: "Frequency" }
  AudioOutlet { id: out1 }

  // Index to keep track of the phase
  property real phase: 0;

  tick: function(token, state) {
    var arr = [ ];

    // How many samples we must write
    var n = token.physical_write_duration(state.model_to_physical);

    if(n > 0) {
      // Computer the sin() coefficient
      var freq = in1.value;

      // Notice how we get sample_rate from state.
      var phi = 2 * Math.PI * freq / state.sample_rate;

      // Where we must start to write samples
      var i0 = token.physical_start(state.model_to_physical);

      // Fill our array
      for(var s = 0; s < n; s++) {
        phase += phi;
        var sample = Math.sin(phase);
        sample = freq > 0 ? sample : 0;
        arr[i0 + s] = 0.3 * sample;
      }
    }

    // Write two audio channels, which will give stereo output by default in score.
    out1.setChannel(0, arr);
    out1.setChannel(1, arr);
  }
}

{% endhighlight %}

## Example of a MIDI transposer

See the user library: Presets/JS/transpose.qml

## Port types
## Properties common to all ports
{% highlight qml %}
FloatSlider {
    id: myVariableName  // <- how you refer to it in the javascript Code
    objectName: "The name shown in the score UI"
    address: "foo:/bar/baz" // <- default address used when the object is created
}
{% endhighlight %}

## Audio
Create an audio input:
{% highlight qml %}
AudioInlet {
    id: in
}

...

var left = in.channel(0);
var right = in.channel(1);

console.log(left[0]); // print the first sample of the first channel

for (var value in left) { ... }
{% endhighlight %}

Create an audio output:

{% highlight qml %}
AudioOutlet {
    id: out
}

...
// set the data of channel 0 to the following:
out.setChannel(0, [0.1, 0.0, 0.2, 0.0, -0.1, 0.0]);

{% endhighlight %}

## MIDI
Create a MIDI input:
{% highlight qml %}
MidiInlet {
    id: in
}

...

var messages = in.messages();
for (var message in messages) {
    // Print the MIDI bytes
    console.log(message[0], message[1], message[2]);
}
{% endhighlight %}

Create a MIDI output:

{% highlight qml %}
MidiOutlet {
    id: out
}

...
// push a new message
out.add([144, 64, 127]);

// set & replace all the messages to be pushed
out.setMessages([
    [144, 64, 127],
    [144, 68, 127],
    [127, 30, 0]
]);
{% endhighlight %}


## Messages
Receiving:
{% highlight qml %}
ValueInlet {
    id: in
}

...

// Print the latest message received
console.log(in.value());

// Iterate through all the messages received for this tick, with their timestamp
for (var message in in.values) {
    console.log(message.timestamp, message.value);
}
{% endhighlight %}

Sending:
{% highlight qml %}
ValueOutlet {
    id: out
}

...
// Use either
out.setValue(1.234);

// or
out.addValue(timestamp, 1.234);
{% endhighlight %}

## Controls
Controls behave exactly like ValueInlet but show up as actual UI
controls. They have as such relevant properties: min, max, etc.
{% highlight qml %}
FloatSlider {
    min: 0.0
    max: 1.0
    init: 0.5
}
{% endhighlight %}

{% highlight qml %}
IntSlider {
    min: 0
    max: 127
    init: 0
}
{% endhighlight %}

{% highlight qml %}
Enum {
    choices: ["foo", "bar", "baz"]
    index: 2
}
{% endhighlight %}

{% highlight qml %}
Toggle {
    checked: true
}
{% endhighlight %}

{% highlight qml %}
LineEdit {
    text: "Hello world"
}
{% endhighlight %}


<!--
{% highlight qml %}
ControlInlet { }
{% endhighlight %}
{% highlight qml %}
ControlOutlet { }
{% endhighlight %}
-->