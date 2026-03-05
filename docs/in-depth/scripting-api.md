---
layout: default

title: Scripting API
description: "JS scripting API reference"

parent: Scripting
grand_parent: In depth

permalink: /in-depth/scripting-api.html
---

The *score* console and JS scripts have access to several global objects. This page documents all their available functions.

# Available global objects

| Object | Available in | Description |
|---|---|---|
| `Score` | Console | Edit the score, control transport, manage devices, undo/redo. |
| `Util` | Console, JS processes | File I/O, text layout, UUID generation, shell commands. |
| `Device` | Console, Mapper scripts | Read/write device parameter values at run-time. |
| `Protocols` | Console, Mapper scripts | Create raw network sockets (UDP, TCP, WS, MIDI...) and HTTP requests. |
| `System` | Console | Query system capabilities (CUDA, MDM). |
| `Library` | Console | List, install, and manage *score* packages. |

# Score object

## Undo-redo and general helpers

```js
// Find an object by name
let obj = Score.find("Interval.foobar");

// Find an object by its label metadata
let obj = Score.findByLabel("my label");

// Get a reference to the object first selected in the score
let obj = Score.selectedObject();

// Get a reference to all the objects currently selected in the score
let objs = Score.selectedObjects();

// Get a reference to the current root document object
let doc = Score.document();

// Get the root interval of the score
let root = Score.rootInterval();

// Undo-redo:
Score.undo();
Score.redo();

// Undo-redo macros:
// this is so that commands that do multiple
// changes to the score, e.g. by adding multiple processes,
// only show up as one single action in the undo-redo panel.
// Every action that changes the score must be between these two calls.
Score.startMacro();
Score.endMacro();
```

## UI

```js
// This function allows to show a prompt to the user.
// The object passed in argument allows to configure the UI to show.
// They will be shown as a UI form.
// The return value will be the list of values that the user has set on
// every widget if the prompt was accepted, and 'undefined' otherwise.

const res = Score.prompt({
  title: "Input JSON",
  widgets: [
    { name:"Name", type: "lineedit", init: "Hello" },
    { name:"JSON", type: "textfield" },
    { name:"Foo", type: "spinbox", min: 0, max: 100, init: 10 },
    { name:"Bar", type: "slider", min: 0.5, max: 10.2, init: 1.0 },
    { name:"Baz", type: "checkbox", init: false }
  ]
});

// Res could look like:
// ["text", "long text", 30, 4.6, true]

// Zoom and scroll the view
Score.zoom(1.5, 1.0);
Score.scroll(100, 0);
```

![UI prompt]({{ site.img }}/in-depth/scripting/ui.prompt.png)

## Transport

```js
// Plays the score
Score.play();

// Plays a specific object
let an_interval = Score.find("my_interval");
Score.play(an_interval);

// Pause playback
Score.pause();

// Resume after pause
Score.resume();

// Stops playback
Score.stop();

// Reinitialize
Score.reinitialize();

// Seek to a position
Score.scrub(0.5);

// Get the transport object
let t = Score.transport();
```

## Functions operating on devices

```js
// Converts a device tree to JSON.
// Useful for e.g. preset snapshotting, sending over the internet...
let json = Score.deviceToJson("deviceName");

// Convert a device tree to OSCQuery JSON
let json = Score.deviceToOSCQuery("deviceName");

// Get a device object by name
let dev = Score.device("myOSC");

// Create an OSC device
Score.createOSCDevice("name", "127.0.0.1", 9000, 9001);

// Connect to an OSCQuery device
Score.connectOSCQueryDevice("name", "ws://127.0.0.1:5678");

// Create a WebSocket device from QML code.
// See the QML code examples in the library.
Score.createQMLWebSocketDevice("name", "QML Code");

// Create a Serial device from QML code.
// See the QML code examples in the library.
Score.createQMLSerialDevice("name", "/dev/ttyUSB1", "QML Code");

// Create a custom device with a protocol UUID and JS configuration
Score.createDevice("name", "protocol-uuid", { /* config */ });

// Create an OSC address on a device
Score.createAddress("myDevice:/foo/bar", "float");

// Remove a device by name
Score.removeDevice("name");

// Enumerate available devices
let enumerator = Score.enumerateDevices();
let enumerator = Score.enumerateDevices("protocol-uuid");

// Listen to device changes
Score.listenDevice("myOSC");

// Iterate over all nodes of a device
Score.iterateDevice("myOSC", function(node) { console.log(node); });

// Enable/disable OSC learn mode on a device
Score.setDeviceLearn("myOSC", true);
```

## Functions operating on the score

```js
// Create a new process in an interval.
// The process names are those in the library.
// Third argument is reserved for future use.
let new_process = Score.createProcess(an_interval, "Automation (float)", null);

// Change the name of an object
Score.setName(an_interval, "Foo");


// Create a new free-floating interval
// Arguments:
// - parent scenario
// - At which time the interval is created (e.g. "00:01:15.345" for 1 minute 15 seconds 345 millis)
// - How long it lasts (same format)
// - Which vertical position (between [0;1] (top;bottom))
let new_itv = Score.createBox(scenar, "00:00:10.000", "00:01:15.000", 0.2);

// createBox also accepts numeric times in flicks
let new_itv = Score.createBox(scenar, 705600000, 3528000000, 0.2);

// Create a new interval after a state
let new_itv = Score.createIntervalAfter(state, duration, y);

// Create an interval between two existing states
let new_itv = Score.createIntervalBetween(startState, endState);

// Create a new state on an event
let st = Score.createState(event, 0.5);

// Get a port by name given a process
let port = Score.port(my_lfo, "Frequency");

// Get an inlet / outlet by index given a process.
// Here "port1" would be the "Offset" port of a LFO process
let port1 = Score.inlet(my_lfo, 2);
// Here "port2" would be the "Outlet" port of a LFO process
let port2 = Score.outlet(my_lfo, 0);

// Returns how many inlets / outlets there are in a given process
let count = Score.inlets(my_lfo);
let count = Score.outlets(my_lfo);

// Create a cable between two ports
Score.createCable(outlet_port, inlet_port);

// Set the address of a port
Score.setAddress(port1, "midi:/1/control/34");

// Set the value of a port (only relevant for ports with UI controls)
Score.setValue(port1, 0.34);
Score.setValue(portA, "foo");
Score.setValue(portB, true);
// Also supports Vec2, Vec3, Vec4, int, list of strings, list of reals

// Get the type of a port as a string. Float, Int, String, etc.
let type = Score.valueType(port1);

// Get the min/max range of a port if it has one
let min = Score.min(port1);
let max = Score.max(port1);

// Get the list of values if the port is an enum / combo box / chooser ...
let vals = Score.enumValues(port1);

// Access the metadata object of an object. Allows to see the label, comments, etc
let meta = Score.metadata(scenario);
console.log(meta.name, meta.label, meta.comment)

// Access the start / end elements of an interval
let st = Score.startState(itv);
let st = Score.endState(itv);

let ev = Score.startEvent(itv);
let ev = Score.endEvent(itv);

let ts = Score.startSync(itv);
let ts = Score.endSync(itv);

// Remove an object from the score
Score.remove(itv);

// Create an automation on the given interval from an address
Score.automate(itv, "foo:/bar");

// Create an automation on the given interval from a port object
Score.automate(itv, port1);

// Get and set state messages
let msgs = Score.messages(a_state);
Score.setMessages(a_state, [ /* message list */ ]);

// Replace an address string across multiple objects
Score.replaceAddress([obj1, obj2], "old:/addr", "new:/addr");
```

## Interval properties

```js
// Set interval duration (in flicks)
Score.setIntervalDuration(itv, 705600000);

// Set min/max duration
Score.setIntervalMinDuration(itv, 0);
Score.setIntervalMaxDuration(itv, 705600000);

// Set max duration to infinite
Score.setIntervalMaxInfinite(itv, true);

// Set playback speed
Score.setIntervalSpeed(itv, 1.5);
```

## Functions operating on curves

```js
// Set a curve from a list of points:
// [ [ x1, y1 ], [ x2, y2 ], ... ]
let points = [
    [0, 0.5],
    [0.2, 1.],
    [0.5, 0.9],
    [1.0, 0.0],
];
Score.setCurvePoints(an_automation_process, points);
```

![Curve points]({{ site.img }}/in-depth/scripting/curve.points.png)

## Functions operating on step sequencer
```js
// Sets the step on a Step Sequencer
Score.setSteps(a_step_sequencer_process, [0.1, 0, 1., 0.4, 0.5]);
```

## File operations

```js
// Load a document
Score.load("/path/to/score.score");

// Save the current document
Score.save();

// Save as a new file
Score.saveAs("/path/to/new.score");

// Read a file's contents (returns a string)
let data = Score.readFile("/path/to/file.txt");

// Serialize the current document to JSON
let json = Score.serializeAsJson();
```

## Introspection

```js
// List all available process types
let procs = Score.availableProcesses();

// List all available processes with their presets
let procs = Score.availableProcessesAndPresets();

// List all available device protocols
let protos = Score.availableProtocols();
```

# Util object

```js
// Reads the entire content of a file
let data = Util.readFile("/path/to/file.txt");

// Write bytes to a file
Util.writeFile("/path/to/file.txt", data);

// Execute a shell command with a completion callback
Util.shell("ls -la", function(result) { console.log(result); });

// Layout a text so that it fits a rect of a given width by
// adding line breaks. Naive algorithm.
// Arguments are: text to lay out, font to use, font size, maximum width in pixels
let text = Util.layoutTextLines("some long text", "Monospace", 24, 100);

// Generate a UUID string
let id = Util.uuid();

// Get the current timestamp in seconds
let ts = Util.timestamp();

// Time conversion utilities
let time = Util.toTime(timeval);          // Convert TimeVal to QTime
let ms = Util.toMilliseconds(timeval);    // Convert TimeVal to milliseconds
let inf = Util.isInfinite(timeval);       // Check if a TimeVal is infinite
let tv = Util.timevalFromMilliseconds(1000); // Create a TimeVal from milliseconds

// Access a settings object by UID
let s = Util.settings("some-uid");
```

# Device object

In the console, the `Device` object allows reading and writing live parameter values across all devices in the document.

```js
// Read the current value of a parameter
let val = Device.read("OSCdevice:/sensor/x");

// Write a value to a parameter
Device.write("OSCdevice:/sensor/x", 0.5);

// Value conversion helpers
Device.asArray(v)   // Convert a value to an array
Device.asColor(v)   // Convert a value to a color (RGBA)
Device.asVec2(v)    // Convert a value to a Vec2
Device.asVec3(v)    // Convert a value to a Vec3
Device.asVec4(v)    // Convert a value to a Vec4
Device.toValue(v)   // Convert a JS value to an ossia value
```

In Mapper device scripts, the `Device` object additionally provides:

```js
// Add a new parameter node to the mapper device
Device.addNode("/my/new/parameter", "float");

// Remove a parameter node
Device.removeNode("/my/new/parameter", "float");
```

# Protocols object

The `Protocols` object is available in the console and in Mapper device scripts. It provides low-level networking primitives. For detailed usage examples, see the [Mapper device]({{ site.baseurl }}/devices/mapper-device.html) documentation.

## Socket functions

All socket configuration objects use a `Transport` sub-object and support `onOpen`, `onClose`, and `onError` callbacks.

```js
// UDP
var sock = Protocols.outboundUDP({ Transport: { Host: "127.0.0.1", Port: 1234 } });
sock.write("/some/data");

Protocols.inboundUDP({
  Transport: { Bind: "0.0.0.0", Port: 1234 },
  onMessage: function(bytes) { console.log(bytes); }
});

// TCP (client)
Protocols.outboundTCP({
  Transport: { Host: "127.0.0.1", Port: 1234 },
  onOpen: function(socket) { socket.write("hello"); }
});

// TCP (server)
Protocols.inboundTCP({
  Transport: { Bind: "0.0.0.0", Port: 1234 },
  onConnection: function(socket) {
    socket.receive(function(bytes) { console.log(bytes); });
  }
});

// WebSocket (client)
Protocols.outboundWS({
  Transport: { Host: "127.0.0.1", Port: 8080 },
  onTextMessage: function(msg) { console.log(msg); },
  onBinaryMessage: function(msg) { console.log(msg); }
});

// WebSocket (server)
Protocols.inboundWS({
  Transport: { Bind: "0.0.0.0", Port: 8080 },
  onConnection: function(socket) { /* ... */ }
});

// Unix sockets (Linux / macOS only)
Protocols.outboundUnixDatagram({ Transport: { Path: "/tmp/sock" } });
Protocols.inboundUnixDatagram({ Transport: { Path: "/tmp/sock" }, onMessage: function(b) {} });
Protocols.outboundUnixStream({ Transport: { Path: "/tmp/sock" } });
Protocols.inboundUnixStream({ Transport: { Path: "/tmp/sock" }, onConnection: function(s) {} });
```

## HTTP

```js
Protocols.http("http://127.0.0.1:1234/path", function(response) {
  console.log(response);
}, "GET");
```

## OSC parsing

```js
var osc = Protocols.osc({
  onOsc: function(address, args) { console.log(address, args); }
});
// Feed raw bytes (e.g. from a UDP socket) into the parser:
osc.processMessage(bytes);
```

## MIDI

```js
// List available MIDI 1.0 ports
var inputs = Protocols.inboundMIDIDevices();
var outputs = Protocols.outboundMIDIDevices();

// Open a MIDI input
Protocols.inboundMIDI({
  Transport: inputs[0],
  onMessage: function(bytes) { console.log(bytes); }
});

// Open a MIDI output
var out = Protocols.outboundMIDI({ Transport: outputs[0] });

// MIDI 2.0 (UMP) equivalents
var umpInputs = Protocols.inboundUMPDevices();
var umpOutputs = Protocols.outboundUMPDevices();
Protocols.inboundUMP({ Transport: umpInputs[0], onMessage: function(b) {} });
var umpOut = Protocols.outboundUMP({ Transport: umpOutputs[0] });
```

# System object

```js
// Check if the device is MDM enrolled (macOS)
let enrolled = System.isDeviceMDMEnrolled();

// Get available CUDA device ID (-1 if none)
let cudaDev = System.availableCudaDevice();

// Check CUDA toolkit dylib availability for a given version
let hasCuda = System.availableCudaToolkitDylibs(12, 0);
```

# Library object

```js
// List installed packages
let installed = Library.installedPackages();

// Fetch available packages from the server
Library.refreshAvailablePackages();

// List available packages (after refresh)
let available = Library.availablePackages();

// Install a package by its UID
Library.installPackage("package-uid");
```
