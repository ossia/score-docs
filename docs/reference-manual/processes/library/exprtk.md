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
- Audio Generator: generates multi-channel audio.
- Audio Mapping: filters multi-channel audio.
- Value Generator: generates values suitable for the device explorer.
- Custom Mapping (Value): filters values suitable for the device explorer.

![ExprTK]({{ site.img }}/reference/processes/exprtk.png)

These expressions are solved within *score* using the [ExprTK library](https://www.partow.net/programming/exprtk/index.html "ExprTK website").

The expression can be written in the process built-in editor on multiple lines.

Numerous math functions are available: `sin`, `cos`, `abs`, `log`, as well as the usual `pi`, etc. constants.

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
  out[i] := clamp(0, dist, 1);
}
```


## Available variables

### Everywhere
* `t`: the current time
* `pos`: the position in the interval
* `a, b, c`: three provided controls
* `pa, pb, pc`: previous value of a, b, c
* `m1, m2, m3`: three provided variables (which will keep their value across a tick)
  * In the audio cases they are arrays.

### Value mapping

* `x`: the value of the current input if it's a single value
* `px`: the value of the previous input if it was a single value
* `po`: the value of the previous output if it was a single value
* `xv`: the value of the current input if it's an array
* `pxv`: the value of the previous input if it was an array
* `pov`: the value of the previous output if it was an array
* `dt`: the time delta

### Audio mapping

* `x`: the value of the current sample
* `out`: where to write the output
* `px`: the value of the previous sample
* `fs`: the sampling rate

### Value generator

* `dt`: the time delta

### Audio generator

* `out`: where to write the output
* `fs`: the sampling rate

## Available functions

### [ExprTK-provided functions](http://www.partow.net/programming/exprtk/):

* Basic math: `min, max, avg, sum, abs, ceil, floor, round, roundn, exp, log, log10, logn, pow, root, sqrt, clamp, inrange, swap`
* Trigonometry: `sin, cos, tan, acos, asin, atan, atan2, cosh, cot, csc, sec, sinh, tanh, d2r, r2d, d2g, g2d, hyp`
* Numeric integration and differentiation
* Vector Processing: `BLAS-L1 (axpy, axpby, axpb), all/any-true/false, count, rotate-left/right, shift-left/right, sort, nth_element, iota, sum, kahan-sum, dot-product, copy`

### score-provided functions

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