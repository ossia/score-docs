---
layout: default

title: "Scripting"
description: "Writing JS scripts to perform editor actions"

parent: In depth

permalink: /in-depth/scripting.html
---

# Scripting

The software can be scripted with Javascript (ES7).

The available functions are defined by the following C++ class: [EditJsContext](https://github.com/ossia/score/blob/master/src/plugins/score-plugin-js/JS/ConsolePanel.hpp#L80).

These functions will be available under the global `Score` object in the JS contexts.
Additional utility functions are available under the `Util` object.

```js
let data = Util.readFile("/Users/me/foo.txt");
```

## Putting scripts in the User Library

Scripts ending in `.js` in the user library can be double-clicked: they will be run in the global application context.
A script can introduce a function which can then be leveraged by the Javascript processes.

## Scripting in the console panel

The [[console]] (shortcut: {% include shortcut.html content="Ctrl+Shift+C" %}) allows to quickly test scripts in a REPL fashion.

It is also useful as a simple calculator :-)

For instance, here is how a small console session may look:

```js
// Gets the first selected object.
> var obj = Score.selectedObject();

// Print it to check what we got.
> obj;
Scenario::IntervalModel(0x555556411330, "Scenario::IntervalModel")

// Play it.
> Score.play(obj);
```

## Making scripts available as GUI actions

It is possible to put scripts in the "Scripts" menu at the top of the software.

Scripts must be valid Javascript modules, and be present somewhere in the system library.

Here is an example, which should go in for instance `Documents/ossia/score/packages/user/my_scripts/Hello.mjs`. It will add an "Example > Hello" sub-menu in the "Scripts" menu. The script will also be triggable at any point with the Alt+A, Alt+H keyboard shortcut.

A single script module can register multiple actions in one go.

```js
// This will be called whenever the action is triggered in the menu.
function your_custom_function() {
  console.log("Triggered");
}

export function initialize() {
  // This will be called when the module is loaded on startup.
  console.log("Hello world !")
}

// This is used to register actions in the Scripts menu in score
export const actions = [
 { name: "Example/Hello"
 , context: ActionContext.Menu
 , shortcut: "Alt+A, Alt+H"
 , action: your_custom_function
 }
]
```

A video example is available [here](https://vimeo.com/711841390) ; here 
is [an example of script that randomizes a process's controls](https://github.com/ossia/score-user-library/blob/master/Scripts/Randomize.mjs).
 
# Examples

## Simple example
```js
// Creates an OSC device named foo. Messages will be sent from score to 127.0.0.1:5678.
// Score will listen to messages on port 1234.
Score.createOSCDevice("foo", "127.0.0.1", 5678, 1234);

// Creates an OSC address on the device foo, named /bar/baz. It will receive color.rgba types.
// All the usual ossia unit names are accessible,
// as well as useful names such as the ones found in [addresses](addresses doc)
Score.createAddress("foo:/bar/baz", "color.rgba");

// Finds an object in the current score.
// The name is the object name, put in the inspector
var myObject = Score.find("the object name");

// Creates an automation. The first argument must be a valid pointer to an interval
// found by Score.find(...).
Score.automate(myInterval, "foo:/my/address");

// Undo-redo
Score.undo();
Score.redo();

// Transport
Score.play();
Score.stop();
```

## Advanced example 1

This example shows how to generate a sequence of randomized processes: automations, step sequencer, LFO which will control an address starting from a state.

It declares a function that can then be called like this:

```js
gengis_gen("my_state", "foo:/bar")
```

```js
// This function randomizes all the parameters of an LFO process
// (or any process with inlets)
function randomizeLFO(lfo) {
  // First count the number of inlets 
  const N = Score.inlets(lfo);

  // For each inlet:
  for (let i = 0; i < N; ++i) {
    // Get it
    const inl = Score.inlet(lfo, i);

    // Get what its type is ("Float", "Int", "String", etc)
    const val_type = Score.valueType(inl);

    if (val_type === "Float" || val_type === "Int") {
      // In that case check the range of the control
      const min = Score.min(inl);
      const max = Score.max(inl);

      // Generate a value in that range
      const val = min + Math.random() * (max - min);

      // Apply it to the control
      Score.setValue(inl, val);
    } else if (val_type === "String") {
      // If the input is a string it's likely an enumeration
      const values = Score.enumValues(inl); // ["Sin", "Square", ...]

      // Pick an enum value at random
      const val = Math.round(Math.random() * (N - 1));
      const N = values.length;

      // Apply it
      Score.setValue(inl, values[val]);
    }
  }
}

// This function creates a random automation.
// Automations are defined like this: 
//   [
//    [0, 0.2],
//    [0.5, 0.7],
//    [1., 0.4]
//   ]
// will make a curve that starts at 0.2, goes up to 0.7 at the half of the curve, 
// and reaches 0.4 at the end.
// The y values should be between 0 and 1, 
// the x values can go beyond 1 (to write past the default length of the automation).
function randomizeAutomation(autom) 
{
  let arr = [];
  for (let i = 0; i <= 10; i++) {
    let x = i / 10;
    let y = Math.random();

    arr.push([x, y]);
  }
  Score.setCurvePoints(autom, arr);
}

// This function creates a random series of steps for the step sequencer.
function randomizeStep(step) {
  let arr = [];
  for (let i = 0; i <= 10; i++) {
    arr.push(Math.random());
  }
  Score.setSteps(step, arr);
}

// Takes the name of a state and an address to set to each process's output.
function gengis_gen(startState, address) {
  // Look for our state object.
  let ss = Score.find(startState);
  if (ss === null) {
    console.log(`${startState} not found`);
    return;
  }

  // We'll create 16 processes.
  const num = 16;
  const y = ss.heightPercentage;
  var cur_state = ss;

  // Start recording undo / redo commands.
  Score.startMacro();

  for (let i = 0; i < num; i++) {
    const seconds = Math.floor(Math.random() * 10);
    const duration = `00:00:0${seconds}`;

    // Create an interval after the state
    let new_itv = Score.createIntervalAfter(cur_state, duration, 0.1);

    // Create processes by name.
    var p;
    switch (Math.floor(Math.random() * 3) % 3) {
      case 0: {
        p = Score.createProcess(new_itv, "LFO", "");
        randomizeLFO(p);
        break;
      }
      case 1: {
        p = Score.createProcess(new_itv, "Automation (float)", "");
        randomizeAutomation(p);
        break;
      }
      case 2: {
        p = Score.createProcess(new_itv, "Step sequencer", "");
        randomizeStep(p);
        break;
      }
    }

    if (p) {
      // Get the outlet of the process.
      let main_outlet = Score.outlet(p, 0);
      // Set its address.
      Score.setAddress(main_outlet, address);
    }

    // The next interval will start from the end state of the current interval.
    cur_state = Score.endState(new_itv);
  }

  // Apply the macro so that it can be un-done in one step.
  Score.endMacro();
}
```


## Advanced example 2

This example creates images process, plays them and remove them.
The function `bullet` can be added to a Javascript process. For instance, 
this will create a Javascript process that makes an image sub-scenario be created randomly, 
every time it gets an input value:

```js
import Score 1.0
Script {
  ValueInlet { id: in1 }

  tick: (token, state) => {
    if (typeof in1.value !== 'undefined') {
      Device.exec("bullet(Score.find('Scenario.1'))")
    }
  }
}
```

```js
function bullet(scenario) {
    if(scenario === null) 
      return;

    Score.startMacro();

    // Create a new box    
    const start_seconds = Math.floor(Math.random() * 10);
    const start_duration = `00:00:0${start_seconds}`;

    const len_seconds = Math.floor(1 + Math.random() * 2);
    const len_duration = `00:00:0${len_seconds}`;

    let itv = Score.createBox(scenario, start_duration, len_duration, Math.random() * 0.4 + 0.2);

    // Add an image process within
    {
      let img = Score.createProcess(itv, "Images", "");
  
      // Set the bullet image
      let files = Score.port(img, "Images");
      Score.setValue(files, ["/home/jcelerier/genuary/bullet.png"]);
  
      // Set the output address
      let outlet = Score.outlet(img, 0);
      Score.setAddress(outlet, "window:/");
  
      // Set a random position
      let pos = Score.port(img, "Position");
      Score.setValue(pos, [4*(Math.random()-0.5), 4*(Math.random()-0.5)]);

      // Set a random scale
      let scaleX = Score.port(img, "Scale X");
      let scaleY = Score.port(img, "Scale Y");
      let sc = 0.5 + Math.random() * 0.3;
      Score.setValue(scaleX, sc);
      Score.setValue(scaleY, sc);

      // Add an automation on the opacity
      {
        let opacity = Score.port(img, "Opacity");
        let autom = Score.automate(itv, opacity);
        Score.setCurvePoints(autom, [
            [0., 1.], [1., 0.]
        ]);
      }
    }

    // In the end state, add a small script, which will destroy that box 
    {
        let end = Score.endState(itv);
        const script = `import Score 1.0
Script { start: () => Device.exec("Score.remove(Score.find('${Score.metadata(itv).name}'))"); }
`
        Score.createProcess(end, "Javascript", script);
    }
    // Save as an undo-redo command
    Score.endMacro();

    // Play it
    Score.play(itv);
}
```