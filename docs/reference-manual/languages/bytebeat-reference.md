---
layout: default
title: Bytebeat expressions
parent: Languages
grand_parent: Reference
permalink: /reference/languages/bytebeat.html
---

# Bytebeat expressions

## What is bytebeat?

Bytebeat is a minimal approach to programming synthetic sounds using arithmetic and bit-level properties of numbers. Expressions turn a time counter `t` into an audio waveform. score's [Bytebeat process]({{ site.baseurl }}/processes/bytebeat.html) compiles these expressions as C++; it is not a JavaScript interpreter or a separate general-purpose language implementation.

Guides and other implementations:

- [Countercomplex's blogpost which introduced Bytebeat](https://countercomplex.blogspot.com/2011/10/algorithmic-symphonies-from-one-line-of.html)
- [The absolute beginner’s guide to coding Bytebeats!](https://nightmachines.tv/the-absolute-beginners-guide-to-coding-bytebeats.html)
- [Greggman's implementation](https://github.com/greggman/html5bytebeat)
- [Radavis's implementation](https://github.com/radavis/bytebeat)

## Expression evaluation in score

Enter one expression per line, not a complete C++ program. Each non-empty expression line is evaluated independently; the generated wrapper converts each result to `signed char`, sums the converted values and divides by `128` times the number of expressions. Multiple lines are mixed together, not evaluated as consecutive statements in a script. The generated signal is copied to both output channels.

`t` is an integer-based counter. In the current implementation it is the output sample counter divided by four using integer division, so it advances once per four output samples. Formula comments mentioning 8, 11, 22 or 32 kHz describe their original context, not a per-expression sample-rate setting in score.

Common operators include arithmetic `+`, `-`, `*`, `/`, `%`; bitwise `&`, `|`, `^`, `~`; shifts `<<`, `>>`; comparisons; and the conditional expression `condition ? a : b`. `^` means XOR, not exponentiation. Use parentheses when combining operators. See the [C++ language reference]({{ site.baseurl }}/reference/languages/cpp.html#language-and-runtime-requirements) for the underlying syntax.

### C++ versus JavaScript semantics

Many published Bytebeat formulas target JavaScript players. They are inspiration, not a promise of source compatibility:

- C++ integer division truncates; ordinary C++ `%` operates on integers. JavaScript number arithmetic, coercions and floating-point remainder do not carry over unchanged.
- In score's current wrapper, expressions containing `/` or `%` select an integer-backed helper type for `t`. Its overloaded division and remainder return zero for a zero divisor in the guarded operations. This is not a JavaScript numeric model, and it does not make every expression safe: operations that use ordinary C++ values, invalid shifts and other undefined behavior still need care.
- JavaScript bitwise operations apply their own numeric conversions and shift-count rules. C++ shifts require a valid count for the operand width; do not assume formulas such as `t >> t` have portable behavior.
- Names such as `w`, `b`, `r` and `n` in the archive are not predefined score variables. JavaScript-style assignments do not implicitly declare C++ variables. JavaScript array literals such as `[1,2,3]` are not C++ array expressions; string indexing in C++ yields a character value rather than JavaScript's numeric string coercion.
- If the SDK supplies `<cmath>`, the wrapper includes it, allowing C++ mathematical functions. A JavaScript formula may require adapting a call such as `Math.abs` to an appropriate C++ `abs` / `std::abs` overload. The current wrapper also provides a limited `Math` compatibility object when these headers are available, but it is **not JavaScript's `Math` object**.

The current `Math` helper exposes `max`, `min`, `abs`, `pow`, `sqrt`, `floor`, `ceil`, `round`, `sin`, `cos`, `tan`, `sinh`, `cosh`, `tanh`, `asin`, `acos`, `atan`, `asinh`, `acosh`, and `atanh`; constants are `E`, `LN10`, `LN2`, `LOG10E`, `LOG2E`, `PI`, `SQRT1_2`, and `SQRT2`. Its functions use the wrapper's integer-based type: `sqrt` is an integer square root, `floor` / `ceil` / `round` return their already-integer argument, and trigonometric results are converted back to that type. `pow` uses repeated integer multiplication for positive exponents. Do not expect JavaScript floating-point results or undocumented `Math` methods.

The [Bytebeat implementation](https://github.com/ossia/score/blob/master/src/plugins/score-plugin-jit/Bytebeat/Bytebeat.cpp) defines the wrapper, helper operators and output conversion. These are score-specific behavior, separate from the [ISO C++ language definition](https://isocpp.org/std/the-standard).

## Safety and availability

Bytebeat uses the [native C++ JIT runtime]({{ site.baseurl }}/reference/languages/cpp.html#language-and-runtime-requirements). Its code is **unsandboxed** and runs inside score; numeric helpers do not provide memory isolation or protect against blocking code. Compile only trusted expressions, save your document and start playback at a low audio level. The historical collection includes explicitly loud formulas and formulas needing adaptation; successful compilation does not establish safe execution or a safe listening level.

## Examples

A simple yet efficient tune, also used by the process example:

```cpp
(((t<<1)^((t<<1)+(t>>7)&t>>12))|t>>(4-(1^7&(t>>19)))|t>>7)
```

## Historical formula collection

The complete formula collection previously shown on the Bytebeat process page is preserved below with its original comments and attribution. It is an archive of community formulas, **not a list of verified C++ expressions**: JavaScript arrays, undeclared variables, escaped punctuation and sample-rate annotations are retained as published in the old documentation. In particular, the archived `\?` spelling must be adapted to `?` for a C++ conditional expression. Review the semantic differences above before using a formula; examples credited to tejeez and mu6k retain those credits in their comments.

These formulas were collected from the community's [“Cool equations” thread](https://www.reddit.com/r/bytebeat/comments/20km9l/cool_equations/), of which the old process page preserved a partial backup. Consult that source for the original discussion and contributors.

```cpp
(t%255&t)-(t>>13&t)

(t&t%255)-(t>>13&(t%(t>>8|t>>16)))

t*(t>>10&((t>>16)+1))  //cycles through all t*(t>>10&) melodies, like the 42 melody

(t>>10)^(t>>14)|(t>>12)*42319 //basic rng w/ slight bias to fliping between high and low

t>>t //odd thing

(t>>8&t)*t //chaotic

(t>>13&t)*(t>>8) //Slower version, has interesting properties

(t>>8&t)*(t>>15&t) //Ambient

(t%(t>>8|t>>16))^t //mod fractal tree cycles through different rhythms

t%(t>>8|t>>16)  //Acts like t and can be used for cool effect. Generates interesting and infinite rhythm variations.

-0.99999999*t*t //Add more 9s to make slower, remove to make faster.

t%(t>>13&t) //Quiet, do -1 for to make louder and change the rhythm slightly.

((t>>8&t>>4)>>(t>>16&t>>8))*t //Not really sure.

(((t*t) & t>>8)/t)-1 //t>>8&t variation?

t%(t>>8^t>>4) // 11 khz only

t%(t>>11^t>>12) //Another t like formula. Also a sweet 11khz song

t%(t>>4^t>>16) // 22 khz only

t*(t>>(t>>13&t)) //i don't even

(t-(t>>4&t>>8)&t>>12)-1 //The 8-bit echo, to play with, edit t>>12 to a number. Powers of 2 give square waves, powers of 2-1 give sawtooth, others are from t>>8&t. Change t>>12 to t>>n to speed up or slow down. Remove -1 for starting quiet.

(((t%(t>>16|t>>8))>>2)&t)-1 //WARNING LOUD! Some kind of glitchcore thing?

(((t%(t>>1|t>>9))>>2)&t)-1 //Variation on above.

(((t & t>>8)-(t>>13&t))&((t & t>>8)-(t>>13)))^(t>>8&t) //Differences

t<<((t>>8&t)|(t>>14&t)) //strange rhythms

(t<<(t/(t>>8&t))) //(t>>8&t)-1 chaos remix

t<<((t>>1|t>>8)^(t>>13)) //call and respond, 11kHz

t<<((t>>1|t>>8)*(t>>13&t>>12)) //call and respond 2, 11kHz

t<<(t>>8&(t/(t>>10&t))) //another chaos remix

t/(t%(t>>8|t>>16)) //8 or 11khz best, extremely loud grinding machine

(t>>8&t>>16)*t>>4 //32kHz, super Sierpinski scale

(t & (t>>15+(t>>8&t)))*t //quarternoisemachine

(t*(t>>5|t>>8))>>(t>>16&t) //tejeez's t>>5|t>>8 song, edited to last forever and be scariers

((t>>8&t)-(t>>3&t>>8|t>>16))&128 //Pulse wave heaven, General formula: ((BYTEBEAT1)-(BYTEBEAT2))&MULTOF2, bytebeat1 can be just "1"

(t^t>>8)*(t>>16&t) //dance of the fractals

(t*t)/(t^t>>12) //Voice changes

((t*t)/(t^t>>8))&t //fractal heaven

(t>>4 & t>>8)*(t>>16&t) //t>>4&t>>8 builder

(t>>4 & t>>8)/(t>>16&t) //dialtones

((2*(t&1)-1)*t)-(t>>8) //weaoowwwoooooiiinnn

(t>>5)*((t&1)+(t>>16)) //eeclicks, change t>>16 to t>>16&t for a variation.

(((sin(t*t/10000000))>0.5)-1)*t //speedupupup

(((-t&t>>12)/32)-1)*t //filterspinsky

(((-t&128)/64)-1)*t //triangle wave, todo: find a way to allow for any pitch.

sin(t/40)>0.5\?t:-t //tertiary operator maddness

sin(t/5+(sin(t/5))+t/1000)*64+t/2500 //wowaowowao

sin(t/5+((sin(t/5)/(t/(4000*(t>>8^t>>4))))))*64+128 //signal to noise ratio

(sin(sin(t/5)+t*t/(t>>8^t>>4))*100)+128 //sine wave harmonics and such

(t*t)/(t>>8&t) //signal decay2

t*t/(t>>n) //replace n with a smallish number (1 to 16 best) for a variety of effects.

(t*t/(1+(t>>9&t>>8)))&128 //everything is broken

t*(1/t*t)^t //fire crackles

t%(t>>10&t)

(t & t>>8)-(t>>16&t)

(sin(sin(t/10)*t*t/10000000000)*32)+128 //generic: (sin(sin(t/pitch))*t*t/speed)*amplitude)+128

(sin(tan(t/50)*t*t/10000000000)*32)+128

((sin(t/10000)*t)>>4&t>>8)*t //Speedupslowdown

(sin(t/10000)*t>>n)/(sin(t/10001)) //t>>n like formula, where n is which t>>_ to act like. It's glitchy-ish.

(sin(t/10000)*t>>8)/(sin(t/10001))&t //Example of formula

(sin(t/10)*(((t>>8&t)%256)/2)+128) //non-cliping, sine form of t>>8&t

sin(t/(1+(t>>8&t>>13)))*64+128 //Sine wave heaven

t*t/(10000*(t>>8&t>>13))

(t&(t>>7|t>>8|t>>16)^t)*t

w=Math.pow(2,t>>8&t>>13),(128/w&t)>1?w*t:-w*(t+1) //Triangle wave song.

t*((t/401)^(t/400)) //it wont stop

(t>>(t>>(t/4)))^t //Chain dance

((t/256)>>(t>>t)) //Slow n Noisy chain

(sin(t/10+sin(t*Math.pow(2,t>>10))))*64+128 //creepy

t/64>>(t>>t/4) //ambient

(t%256)>(cos(t/40000)*128+128)?0:128 //conditional expression experiment. Pulse wave duty cycle cycler

t*((t>>8&t>>3)>>(t>>16&t)) //Use with below

(t*(t>>8&t>>3))>>(t>>16&t) //Use with above

(t*((t%(t>>8|t>>16))>>8|t>>5))^(t*(t>>5)) //break

t%(t>>(t/4)) //ambient

sin(t/(t>>8&t&t>>13))>0?128:64 //more conditional expressions!

sin(t/((t>>8&t>>7)%3))>0?128:0 //morse code dialoge

(sin(t/((t>>8&t>>7)%3))*64)+128 //alternate version (uses sine waves instead of square)

(t*(-(t>>8|t|t>>9|t>>13)))^t //ststututterter

((Math.abs(sin(t/("34543"[t>>13&3])))+sin(t/"23432"[t>>14&3])))*40+128 //basic array thing

(((t/91)&t)^((t/90)&t))-1 //waiver

(t*t)/(t>>13 ^ t>>8) //glissando

(t/(t%(t>>8|t>>16)))|(t*t/(t>>8|t>>13)) //(t/(t%(t>>8|t>>16))) and (t*t/(t>>8|t>>13)) mashup

(t/(t%(t>>8|t>>16)))|(t*t/(t>>8|t>>16)) //variation

w=t/10,sin((w>>8&w))*64+128 //run

(sin(sin(t/10)+t/(1000-(t>>10|t>>12)))*64)+128 //click and pop

(sin(sin(t/10)+t/(1000-(t>>10^t>>12)))*64)+128 //click and pop 2

(sin(sin(t/10)+t/(1000-(t>>10^t>>12)))*64)^(sin(sin(t/10)+t/(1000-(t>>10|t>>12)))*64)+128 //Distort

(sin(sin(t/10)+t/(1000-(t>>10&t>>4))))*64+128 //bit crusher

t>>(t%(t>>1&t)) //Broken Signal

sin((t%(t>>8|t>>16))/10)*64+128 //click and pop 3

w=(sin(t>>16)*6890866887),(t>>5|t>>8)*(t|w) //RNG changes stuff. Replace the big number with another for a variation.

w=t%(t>>8|t>>16),b=w>>5|t>>8,(b*t)^(t*(t>>8))  //what's left behind

t*t/(t>>8&t>>4) //chaos

((t/(t>>8&t>>7))&t)-1   //beep

((t/(t>>8&t>>4))&t>>8)*t  //t>>4&t>>8 remix

t/(t%(t>>8|t>>12)) //32kHz

sin(sin(t/100)-t/((2+(t>>10&t>>12)%9)))*64+128 //trill

w=t%(t>>8|t>>16),b=w>>5|t>>8,(b*t)-(t*(t>>8)) //(t>>5|t>>8)*t builder

(1.001*t^-t*1.001)+t/(500+(t>>16&t>>8))  //process complete

(t&t>>4)-(t>>13&t) //dark kick

r=sin(t>>12)*30,w=sin(t/(r%5))+sin(t/(r%6)),w*64+128  //replace "30" with another number to get a new song

w=t%(t>>15)>0?t:-t,((w>>4&w>>8)*w)  //green noise, black noise

((t*.98)%(t>>13&t>>12))+(t%(t>>13&t>>10))  //duo team. Based off of mu6k's "Long Line Theory"

t%50.01+t%40.1+t%30.1+t%60.01  //harmony. Based off of mu6k's "Long Line Theory"

w=[1,2,3,4,3,4,1][(t>>13)%7]*t,(w%50.01+w%40.1+w%30.1+w%60.01)  //harmony v2. Based off of mu6k's "Long Line Theory"

n=50+([4,6,4,6,1,3,1,3][(t>>13)%8]),w=([1,1,1][(t>>13)%3])*t,(w%n)+(w%(n-10)+(w%(n+10)))  //sad chords, again based off of mu6k's "Long Line Theory"

(t>>8&(t/(t>>4&t>>8))>>4)*t  //glitch

s=((t>>8&t>>4)%24)+1,v=128,(t*(t>>8&t>>4))&128?sin(t/s)*v+128:-sin(t/s)*v+128 //not quite a sine wave

(((t>>8)+(t>>16&t))&t>>2)*t //use with below

(((t>>8)+(t>>16&t))&t>>3)*t //use with above, tag team swish

a=[1,1,2,3,1,1,2,3,1,1,2,4,4,4,5,5,5][(t>>12)%17],b=[5,4,3,2][(t>>16)%4],(t*b/a)%50.1+(t*b/a)%50  //array song. First real one i promise this time.

t>>(8/((t/32)%3))  //reverse

 t*((((t>>8)&t>>2)*t)/(((t>>8)&t>>3)*t)+(((t>>8)&t>>3)*t)/(((t>>8)&t>>2)*t))  //everytype smasher

 ((t>>10|t>>1)&t|(t>>18&t))-t  //muncher

 ((t/4)>>(t/4))>>(t>>(t/8))|t>>2  //plucker

((t/4)>>t/4)|(t>>2)  //plucker v2

 (t & ((t%(t>>1&t))|t>>3^t>>4)>>7)-1  //fractal glitcher

(t & ((t%(t>>1&t))|t>>13^t>>5)>>7)-1 //fractal glitcher v2

 ((t/1000)^(t/1001))*t    //jumper

t/((t%(t>>13&t)))  //noisecore synthcore

t/(t^(t+1+(t>>16))) //cyclic
```
