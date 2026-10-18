---
layout: default
title: C++ native code
parent: Languages
grand_parent: Reference
nav_order: 14
permalink: /reference/languages/cpp.html
---

# C++ native code

score compiles C++ into native code for the [C++ JIT process]({{ site.baseurl }}/processes/cpp_jit.html) and [Texture generator]({{ site.baseurl }}/processes/texgen.html). These are two different host interfaces, not standalone programs with a `main()` function. [Bytebeat expressions]({{ site.baseurl }}/reference/languages/bytebeat.html) use the same JIT infrastructure through a generated expression wrapper.

## Language and runtime requirements

The authoritative language definition is the [ISO C++ standard](https://isocpp.org/std/the-standard); [cppreference](https://en.cppreference.com/w/cpp) is a useful, non-normative language and standard-library reference. The current score JIT uses C++23 with GNU extensions (`-std=gnu++23`). The callbacks and graph-node types below are **score APIs**, not part of standard C++.

The JIT plug-in requires LLVM 20 or newer and compatible Clang development libraries when building score. It is omitted from fast-development builds and builds without these dependencies. Texture generation additionally requires the graphics plug-in. Install the matching score SDK headers for code using score and libossia interfaces; standard-library header availability also depends on the installed toolchain and SDK.

Windows JIT and run-time add-ons use llvm-mingw, the official Windows toolchain. MSYS2 CLANG64 is the development alternative; MSVC is only needed for exceptional Qt WebEngine builds. Match the application version, architecture and compiler ABI rather than mixing headers from another score installation. See [SDK setup]({{ site.baseurl }}/development/plugins/plugins-with-avendish.html#build-against-a-matching-sdk).

## Native-code safety

**This is unsandboxed native code running with the same privileges as score.** A crash, invalid memory access or blocking operation can affect the whole application. Only compile trusted code, save documents before experimenting, and keep allocation and blocking I/O out of real-time processing. Successful compilation is not a safety check.

## C++ JIT factory

The entry point must retain its C linkage, name and signature:

```cpp
extern "C" ossia::graph_node* score_graph_node_factory();
```

The factory returns a newly allocated graph node; score takes ownership. It may create a node to inspect its ports as well as a node for execution, so do not return a stack object or a single shared raw pointer. The node's declared inlets and outlets determine the process ports: there is no fixed universal list of controls.

The supplied example derives from `ossia::nonowning_graph_node`, declares a value inlet and outlet, and multiplies incoming values by two while preserving their timestamps. Its processing override has this signature:

```cpp
void run(const ossia::token_request& t,
         ossia::exec_state_facade st) noexcept override;
```

Start from the example supplied by your installed version and the [current process implementation](https://github.com/ossia/score/blob/master/src/plugins/score-plugin-jit/JitCpp/JitModel.cpp), which includes the complete factory example and port mapping. The callback is a libossia graph-node method, not an Avendish processor call operator. Recompilation may change the interface; check cables after modifying the ports.

## Texture-generator callback

Texture generator accepts C++23 code exporting this callback:

```cpp
extern "C"
void score_rgba(unsigned char* rgba, int width, int height, int t);
```

| Parameter | Meaning |
| --- | --- |
| `rgba` | Writable CPU pixel buffer: four consecutive unsigned bytes per pixel, in red, green, blue, alpha order. |
| `width`, `height` | Current texture dimensions in pixels. Write only within the `width * height * 4` byte buffer. |
| `t` | Integer render-call counter, starting at zero for a renderer and incremented on each callback invocation; not elapsed seconds or an audio sample counter. |

Pixels are laid out row by row; pixel `(x, y)` begins at `4 * (y * width + x)`. The callback is invoked for rendered frames, and the buffer is uploaded as an RGBA8 texture. Texture data is retained across frames while the buffer is reused, so a callback can update only part of an image. Do not rely on previous contents after a resize or renderer recreation, or retain the buffer pointer beyond the call.

Rendering happens on the CPU, not in a GLSL shader. Large textures therefore increase the work your callback must complete. Use a smaller fixed render-target size if rendering is too slow. The [process page]({{ site.baseurl }}/processes/texgen.html#example) retains the complete example, preset images and downloadable score.

Implementation references: [callback compilation](https://github.com/ossia/score/blob/master/src/plugins/score-plugin-jit/Texgen/Texgen.cpp), [callback type](https://github.com/ossia/score/blob/master/src/plugins/score-plugin-jit/Texgen/Texgen.hpp), and [pixel buffer and frame invocation](https://github.com/ossia/score/blob/master/src/plugins/score-plugin-gfx/Gfx/Graph/TexgenNode.hpp).

## Avendish is a separate workflow

For a reusable processor with declarative controls and ports, use [Plug-ins with Avendish]({{ site.baseurl }}/development/plugins/plugins-with-avendish.html). Avendish describes a processor as a C++ type, with its own port contracts and package metadata. It does not use either callback above as its authoring interface.

The developer command `--compile-node file.hpp` compiles an Avendish object into a registered add-on; it is **not** the low-level graph-node entry point used by the C++ JIT document process. Source add-ons and prebuilt add-ons are packaged and installed through the development workflow, rather than pasted into a document's C++ JIT or texture editor. See also the [command-line reference]({{ site.baseurl }}/reference/commandline.html).
