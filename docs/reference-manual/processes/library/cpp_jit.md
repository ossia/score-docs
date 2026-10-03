---
layout: default

title: C++ JIT
description: "Write super-fast processes in C++"

parent: Processes
grand_parent: Reference

permalink: /processes/cpp_jit.html
---

# C++ JIT

This process compiles C++ into a native processing node while score is running. Open its code editor from the process's window icon or inspector, edit the supplied program and use **Compile** to rebuild it.

## Workflow and ports

The supplied example derives from `ossia::nonowning_graph_node`, declares a value inlet and outlet, and multiplies incoming values by two while preserving their timestamps. Its entry point is:

```cpp
extern "C" ossia::graph_node* score_graph_node_factory();
```

The factory returns a newly allocated graph node. The node's declared inlets and outlets determine the process ports; there is no fixed universal list of controls. Start from the supplied example and the [current process implementation](https://github.com/ossia/score/blob/master/src/plugins/score-plugin-jit/JitCpp/JitModel.cpp), rather than pasting a standalone C++ `main()` program.

Connect the input to a value-producing process and the output to a monitor, mapping or device destination. Recompilation can change the port structure, so check cables after changing the interface. Compilation errors appear in the editor/log; verify compilation before starting a performance.

## Availability and safety

This is native, unsandboxed code with the same privileges as score. A crash, blocking operation or invalid memory access in a node can affect the whole application. Keep allocation and blocking I/O out of real-time processing.

Availability depends on the build: the JIT plug-in requires LLVM 20 or newer and compatible Clang development libraries, and is omitted from fast-development builds or configurations without those dependencies. A compatible score SDK/header environment is also needed for compilation. Current development work includes Windows LLVM/MinGW JIT and run-time add-on support; do not assume an older release or an arbitrary system package contains it.

## Avendish is a separate workflow

To implement a reusable processor with declarative controls and ports, use [Plug-ins with Avendish]({{ site.baseurl }}/development/plugins/plugins-with-avendish.html). The developer command `--compile-node file.hpp` compiles an Avendish object into a registered add-on; it is **not** the low-level graph-node entry point used by this document process. See also the [command-line reference]({{ site.baseurl }}/reference/commandline.html).
