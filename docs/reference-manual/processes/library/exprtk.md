---
layout: default

title: Math expressions
description: "Math expression syntax and processes in ossia score"

parent: Processes
grand_parent: Reference

permalink: /processes/exprtk.html
---

# ExprTK support

Several processes allow to write simple math expressions. Such processes include:

- Micromap: for very simple math expressions, e.g. `x * 100`.
- Expression Audio Generator: generates multi-channel audio.
- Expression Audio Filter: filters multi-channel audio.
- Expression Value Generator: generates values suitable for the device explorer on every tick.
- Expression Value Filter: filters values suitable for the device explorer.
- Arraygen: generates an array of values.
- Arraymap: applies the function to each value of the input array.

![ExprTK]({{ site.img }}/reference/processes/exprtk.png)

These expressions are evaluated within *score* using the [ExprTK library](https://www.partow.net/programming/exprtk/index.html "ExprTK website").

The expression can be written in the process built-in editor on multiple lines.

Numerous math functions are available: `sin`, `cos`, `abs`, `log`, as well as the usual `pi`, etc. constants.

## Audio handling

For audio processes, the processing is done per-frame. The input `x` is an array, where `x[0]` is the first channel, `x[1]` the second channel, etc.

Note that ExprTK has powerful array processing features; the following two codes implement the same distortion:

```matlab
// This is the syntax to get the size of the array
// e.g. the number of channels here:
var n := x[];

for (var i := 0; i < n; i += 1) {
  var dist := tan(x[i]*log(1 + 200 * a));
  out[i] := clamp(-1, dist, 1);
}
```

```matlab
out := clamp(-1, tan(x * log(1 + 200 * a)), 1);
```

## Using arrays in ExprTK

For value processes, the same expression syntax cannot be used for single-value or array input: 

- Use `x`, `px`, `po` to write an expression that processes single values, e.g. a float input.
- Use `xv`, `pxv`, `pov` to write an expression that processes arrays.

For instance:

```matlab
tanh(x + 1)
```

will process a single float as input, while:

```matlab
return [ xv[0] cos(xv[1]), xv[0] sin(xv[1]) ];
```

will take a vec2 that contains polar coordinates `[r, theta]` and convert it into cartesian coordinates `[x, y]`.

Note that it isn't possible to create dynamic arrays in ExprTK. To return an array, it has to be wrapped in an array itself and then unwrapped with an [[Object filter]]:

![ExprTK]({{ site.img }}/reference/processes/exprtk/vec.png)

Alternatively, the Arraygen object can be used to create an array from a generator expression.

## Using Arraygen {#arraygen}

![Arraygen]({{ site.img }}/reference/processes/exprtk/arraygen.png)

Arraygen will generate an array with as many elements as chosen.
The expression will be used to generate each element. 
`i` represents the current element index, starting from zero and `n` is useable as the total count of elements.

Arraygen can also return arrays: 

![Arraygen used for arrays]({{ site.img }}/reference/processes/exprtk/arraygen-array.png)

[Download the example score here]({{ site.scores }}/reference/processes/arraygen-array.score).

## Using Arraymap {#arraymap}

![Arraymap]({{ site.img }}/reference/processes/exprtk/arraymap.png)

Arraymap applies the expression to every element used as input. 
The same variables are useable than for Arraygen, the only difference is that triggering 
is bound to the presence of an input value instead of the timeline.

# Available variables

### Everywhere
* `t`: the current time in flicks.
* `pos`: the position in the interval

### Value filter, Value generator, Audio filter, Audio generator
* `a, b, c`: three provided controls
* `pa, pb, pc`: previous value of a, b, c
* `m1, m2, m3`: three provided variables (which will keep their value across a tick)
  * In the audio cases they are arrays.

### Value filter, Micromap, Arraymap

* `x`: the value of the current input if it's a single value
* `px`: the value of the previous input if it was a single value
* `po`: the value of the previous output if it was a single value
* `dt`: the time delta

### Value filter, Micromap

* `xv`: the value of the current input if it is an array
* `pxv`: the value of the previous input if it was an array
* `pov`: the value of the previous output if it was an array

### Value generator

* `dt`: the time delta
* `po`: the value of the previous output

### Audio filter

* `x`: the value of the current sample
* `out`: where to write the output
* `px`: the value of the previous sample
* `fs`: the sampling rate

### Audio generator

* `out`: where to write the output
* `fs`: the sampling rate

### Arraymap, Arraygen

* `i`: the current index
* `n`: the total count

# Available functions

## [ExprTK-provided functions](http://www.partow.net/programming/exprtk/):

* Basic math: `min, max, avg, sum, abs, ceil, floor, round, roundn, exp, log, log10, logn, pow, root, sqrt, clamp, inrange, swap`
* Trigonometry: `sin, cos, tan, acos, asin, atan, atan2, cosh, cot, csc, sec, sinh, tanh, d2r, r2d, d2g, g2d, hyp`
* Numeric integration and differentiation
* Vector Processing: `BLAS-L1 (axpy, axpby, axpb), all/any-true/false, count, rotate-left/right, shift-left/right, sort, nth_element, iota, sum, kahan-sum, dot-product, copy`

## score-provided functions

* `random(min, max)`: returns a random real number in the given interval. 
  * `random(0, 1)` can be 0., 0.3, 0.23455436, 1.
  * `round(random(1, 20))` is a 20-sided dice with lower probabilities for 1, 20.
  * `floor(random(1, 21))` is a 20-sided dice with same probabilities for everyone.

* `noise(t, octaves, persistence)`: [Perlin noise](https://adrianb.io/2014/08/09/perlinnoise.html).
  * `t` should be something that increases ; `pos` is generally a good candidate.
  * `octaves`: the higher this is, the more detailed the noise is. 2 would be smooth, 7 very detailed but more computationally intensive. Between 1 and 10.
  * `persistence`: how much each octave fades. 1: no fade, very noisy. 0: very smooth.
  * `5 * (noise(pos * 100, 4, 0.5) - 0.5)` gives a convincing fairly dynamic noise between -1 and 1.
  * `noise(pos * 10, 3, 0.1)` gives a very smooth evolution between 0 and 1.

![ExprTK]({{ site.img }}/reference/processes/exprtk/noises.png)

# Examples

The user library comes with a few utility functions, be sure to check them in the preset pane !

Contributing useful functions to the library is also very welcome.

- [Audio Filter](https://github.com/ossia/score-user-library/tree/master/Presets/Expression%20Audio%20Filter)
- [Audio Generator](https://github.com/ossia/score-user-library/tree/master/Presets/Expression%20Audio%20Generator)
- [Value Filter](https://github.com/ossia/score-user-library/tree/master/Presets/Expression%20Value%20Filter)
- [Value Generator](https://github.com/ossia/score-user-library/tree/master/Presets/Expression%20Value%20Generator)
- [Micromap](https://github.com/ossia/score-user-library/tree/master/Presets/Micromap)
- [Arraymap](https://github.com/ossia/score-user-library/tree/master/Presets/Arraymap)
- [Arraygen](https://github.com/ossia/score-user-library/tree/master/Presets/Arraygen)

## Value generator

### Logistic function

Implemented as a preset (`Logistic`):
```matlab
if(m1 == 0) {
  m2 := 0.8;
  m1 := 1;
}

var r := 4 * a;
m2 := r * m2 * (1 - m2)
```

## Value mapper

### Add noise
Implemented as a preset (`Noisify`):
```matlab
var rnd_m := pow(2, 31);
var rnd_a := 1103515245;
var rnd_c := 12345;

if(m2 == 0) {
  m2 := 1;
  m1 := 12345678;
}

var r := (rnd_a * m1 + rnd_c) % rnd_m;
m1 := r;
x + a * r / (2^33);
```

## Audio generator

### Sine wave
Implemented as a preset (`Sine`):
```matlab
var phi := 2 * pi * (20 + a * 500) / fs;

m1[0] += phi;

out[0] := b * cos(m1[0]);
out[1] := b * cos(m1[0]);
```

### Square wave
Implemented as a preset (`Square`):

```matlab
var phi := 2 * pi * (20 + a * 500) / fs;

m1[0] += phi;

var f := cos(m1[0]) > 0 ? b : -b;
out[0] := f;
out[1] := f;
```

### Wobbly synth
Implemented as a preset (`Wobbly`):

```matlab
var freq_l := 225 +  cos(t/(100*(a+0.1)));
freq_l := 2 * pi * m1[0] *  freq_l * b / fs;

var freq_r := 215 +  sin(t/(100*(a+0.1)));
freq_r := 2 * pi * m1[0] *  freq_l * b / fs;

m1[0] += 1;

out[0] := b * cos( freq_l );
out[1] := b * cos( freq_r );
```

## Audio filter

### Crude distortion

2-channel version:
```matlab
out[0] := clamp(0,  tan(x[0]*log(1 + 200 * a)), 1);
out[1] := clamp(0,  tan(x[1]*log(1 + 200 * a)), 1);
```

Any number of channel version:
```matlab
var n := x[];

for (var i := 0; i < n; i += 1) {
  var dist := tan(x[i]*log(1 + 200 * a));
  out[i] := clamp(-1, dist, 1);
}
```

