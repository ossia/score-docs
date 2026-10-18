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

The canonical [C++ native-code reference]({{ site.baseurl }}/reference/languages/cpp.html) documents the factory ABI, compiler requirements and native-code restrictions.

## Workflow and ports

Start from the supplied example, which declares a value inlet and outlet and multiplies incoming values by two while preserving their timestamps. The node's declared ports determine the process interface; there is no fixed universal list of controls. See the [C++ JIT factory reference]({{ site.baseurl }}/reference/languages/cpp.html#c-jit-factory) for its entry point and graph-node contract rather than pasting a standalone C++ `main()` program.

Connect the input to a value-producing process and the output to a monitor, mapping or device destination. Recompilation can change the port structure, so check cables after changing the interface. Compilation errors appear in the editor/log; verify compilation before starting a performance.

## Availability and safety

This is native, unsandboxed code with the same privileges as score. A crash, blocking operation or invalid memory access in a node can affect the whole application. Keep allocation and blocking I/O out of real-time processing.

If the process is unavailable or SDK headers cannot be found, check the [language and runtime requirements]({{ site.baseurl }}/reference/languages/cpp.html#language-and-runtime-requirements).

## Avendish is a separate workflow

For reusable processors with declarative controls and ports, use [Plug-ins with Avendish]({{ site.baseurl }}/development/plugins/plugins-with-avendish.html). Its `--compile-node` command is not this document process's entry point; see the [workflow distinction]({{ site.baseurl }}/reference/languages/cpp.html#avendish-is-a-separate-workflow) and [command-line reference]({{ site.baseurl }}/reference/commandline.html).
