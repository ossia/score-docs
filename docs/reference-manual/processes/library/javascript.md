---
layout: default

title: Javascript
description: "Javascript process and syntax in ossia score"

parent: Processes
grand_parent: Reference

permalink: /processes/javascript.html
---

# Javascript support

## Scripting in Javascript / QML.
*score* allows to write scripts using the JavaScript language. These scripts can be used to write specific processes such as value mappers, audio generators.

*score* uses JavaScript version ES7 through QML. See the [JavaScript reference](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference) for more information about the JS language.

QML is a superset language of Javascript which enables very efficient integration with Qt software and thus ossia. 
It comes with some additional syntax (`property real`, etc.). See the [QML Reference](https://doc.qt.io/qt-6/qmlreference.html) for more information as well as the [QML Book](https://www.qt.io/product/qt6/qml-book/ch01-meetqt-meet-qt) to get started with the language.

Either code directly or a path to the file can be added to the Javascript code editor - if it's a file it will be watched for changes.

JS can be used as a process both for intervals, and in states.
* To add a JS process to an interval, simply drag'n'drop it from the Process Library to the interval.
* To add a JS process to a state, right-click on the state in the Object Explorer, and choose "Add Process".

JS can also be used for generative graphics by using the whole power of QtQuick. A basic example is given below.

## Editing code

An important thing to note is that the edited script *will not* be saved in the scenario if there are compilation errors. This is a known issue and likely to change.

## General syntax

Every script must contain
```qml
import Score
```
somewhere at the top.

A script defines a javascript object, with :
- Input and output ports
- Callbacks that are called either regularly on every tick, or on special events (start, stop, pause, resume).

The smallest valid empty script looks like this:
```qml
import Score
Script {
  tick: function(token, state) { }
}
```

The tick function's two arguments give both timing and contextual information useful for writing algorithms.

Please read the [Timing]({{ site.baseurl }}/in-depth/musical.html#timing) page to understand the timing concepts used in ossia score, in particular
how model, physical and musical dates relate to each other.

### Available functions

A very simple API to read / write messages from the device explorer is provided:

```js
// Reads the current value of an address in the device explorer
let value = Device.read("an:/address");
console.log(JSON.stringify(value));

// Sends a value to the device explorer
Device.write("an:/address", 123);
```

Note that some types (vec2, vec3, vec4) that may be returned from the equivalent types in the device explorer 
require an import of QtQuick to be useable.

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
- `timings(token)`: given the token object, this gives back a timings object, which has the following properties:
  - `start_sample`: at which index is the first sample to write in an audio buffer.
  - `length`: how many samples must be written.

`timings` is most of the time what you need !

## Example of a value mapper

```qml
// Necessary for the Script object.
// It is also possible to import QtQml and QtQuick
import Score

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
```

Note: it is also possible to access the list of messages with their precise timing, with `values`.

## Example of an audio generator

```qml
import Score

Script {
  // Declare our inputs & outputs
  FloatSlider { id: in1; min: 20; max: 800; init: 440; objectName: "Frequency" }
  AudioOutlet { id: out1 }

  // Index to keep track of the phase
  property real phase: 0;

  tick: function(token, state) {
    // Create an array to store our samples
    let arr = new Array(state.buffer_size);
    for (let i = 0; i < state.buffer_size; ++i)
      arr[i] = 0;

    // How many samples we must write in this array
    // (the process could run for e.g. only frame 17 through 24 in a 128-frame buffer)
    const tm = state.timings(token);

    if(tm.length > 0) {
      // Computer the sin() coefficient
      var freq = in1.value;

      // Notice how we get sample_rate from state.
      var phi = 2 * Math.PI * freq / state.sample_rate;

      // Fill our array
      for(var s = 0; s < n; s++) {
        phase += phi;
        var sample = Math.sin(phase);
        sample = freq > 0 ? sample : 0;
        arr[tm.start_sample + s] = 0.3 * sample;
      }
    }

    // Write two audio channels, which will give stereo output by default in score.
    out1.setChannel(0, arr);
    out1.setChannel(1, arr);
  }
}

```

## Example of a MIDI transposer

See the user library: Presets/JS/transpose.qml

## Port types
## Properties common to all ports
```qml
FloatSlider {
    id: myVariableName  // <- how you refer to it in the javascript Code
    objectName: "The name shown in the score UI"
    address: "foo:/bar/baz" // <- default address used when the object is created
}
```

## Audio
Create an audio input:
```qml
AudioInlet {
    id: in
}

...

var left = in.channel(0);
var right = in.channel(1);

console.log(left[0]); // print the first sample of the first channel

for (var value in left) { ... }
```

Create an audio output:

```qml
AudioOutlet {
    id: out
}

...
// set the data of channel 0 to the following:
out.setChannel(0, [0.1, 0.0, 0.2, 0.0, -0.1, 0.0]);

```

## Example of fetching various timings

This example shows how one can access both score-relative and global-time-relative timing information from a JS script.

```qml
import Score
Script {
  ValueInlet { id: in1 }
  ValueOutlet { id: out1; objectName: "logical" }
  ValueOutlet { id: out2; objectName: "physical" }

  property int samples_since_beginning: 0
  tick: function(token, state) {
    // Logical time: this time is affected 
    // by the speed sliders in score.
    // The unit is the Flick.
    out1.value = token.date;
    
    // Logical time in seconds:
    out1.value = token.date / 705600000;
    
    // Physical time: the time in real-world clock since the interval started playing.
    // The physical time unit is the audio sample.
    samples_since_beginning += state.buffer_size;
    out2.value = samples_since_beginning;
    
    // Physical time in seconds:
    out2.value = samples_since_beginning / state.sample_rate;
  }
}
```


## MIDI
Create a MIDI input:
```qml
MidiInlet {
    id: in
}

...

var messages = in.messages();
for (var message in messages) {
    // Print the MIDI bytes
    console.log(message[0], message[1], message[2]);
}
```

Create a MIDI output:

```qml
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
```


## Messages
Receiving:
```qml
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
```

Sending:
```qml
ValueOutlet {
    id: out
}

...
// Use either
out.setValue(1.234);

// or
out.addValue(timestamp, 1.234);
```

## Controls
Controls behave exactly like ValueInlet but show up as actual UI
controls. They have as such relevant properties: min, max, etc.
```qml
FloatSlider {
    min: 0.0
    max: 1.0
    init: 0.5
}
```

```qml
IntSlider {
    min: 0
    max: 127
    init: 0
}
```

```qml
Enum {
    choices: ["foo", "bar", "baz"]
    index: 2
}
```

```qml
Toggle {
    checked: true
}
```

```qml
LineEdit {
    text: "Hello world"
}
```


<!--
```qml
ControlInlet { }
```
```qml
ControlOutlet { }
```
-->

## Generative graphics

```qml
TextureOutlet {
    item: Rectangle { }
}
```

Adding a `TextureOutlet` ports turns the JS object into a GPU one - rendering will be performed
by Qt Quick in the GPU thread. Note that it will not run if not connected to a graphical output!

Any QtQuick item can be put as `item`.
Here is an example of a basic animated rectangle:

```qml
import Score 
import QtQuick

Script {
    TextureOutlet {
        objectName: "out"
        item: Rectangle {
            id: rect
            color: "blue"
            width: 100
            height: 100
        }
    }

  tick: function(token, state) {
      rect.x = ((rect.x + 1) % 100)
      rect.y = ((rect.y + 1) % 100)
  }
}
```

![Texture Outlet example]({{ site.img }}/reference/processes/javascript/textureoutlet.gif "Rendering with QtQuick") 
