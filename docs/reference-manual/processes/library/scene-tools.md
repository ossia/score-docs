---
layout: default
title: Scene tools
description: "Inspect, select, group and filter native 3D scenes"
parent: Processes
grand_parent: Reference
permalink: /processes/scene-tools.html
---

# Scene tools

These processes work on native scenes from [[Asset Loader]], **PBR Mesh** and other scene producers. Except for the inspector and flattened filter, they take scenes and emit scenes; place them before [[Scene Preprocessor]].

## Scene Inspector

Connect **Scene In** to inspect an asset without modifying it. **Mode** selects Paths, Names, Tree or Summary. **Rows** emits a list of strings; **Readable** emits a formatted report. Additional outlets report node, mesh, light and camera counts, material count, total triangles and total vertices. **Show components**, **Show stats**, **Include hidden** and **Max depth** control the report (`-1` means unlimited depth).

Use Paths mode to obtain canonical paths such as `/Root/Body/Wheels`, then copy those paths into the selectors below. Connect Readable to a value display when debugging a patch.

## Scene Graph Filter

**Scene In → Scene Out**, with **Mode** selecting Pass through, Visible only, By path, By name, By component, By material tag, Set visibility, By alpha mode, By shadow caster, By reflection caster, By purpose, By node property or By material property.

- **Paths**, **Names** and **Material tags** are editable lists, one entry per row. Paths support `*` within a segment, `**` across segments and `?` for one character.
- **Invert** reverses inclusion: matching nodes are excluded instead of retained.
- **Component** selects Mesh, Light, Camera, Instance or Skeleton.
- **Alpha mode** selects Opaque, Mask or Blend; **Purpose** selects Default, Render, Proxy or Guide; **Caster flag** supplies the desired shadow/reflection flag.
- Property modes use **Property key**, **Property op** and **Property value**. Operations are equal, not equal, less than, greater than and contains (string). A missing key does not match.

Only the controls relevant to the selected mode are used. Start with Inspector output rather than guessing imported node names.

## Scene Filter

This smaller filter has three modes: **pass through**, **keep visible only** and **keep matching names**. The last keeps the subtrees whose node name matches the **Name** pattern, written like an OSC address part — `*` and `?` wildcards, `[0-9]` ranges and `{wheel,door}` alternatives — and matched against the whole name. A matching node is kept with everything under it; its parents stay, so that it keeps its place and transform, but lose their own meshes and other components. An empty pattern keeps everything. It does not have the path/material selection controls of Scene Graph Filter. Its ports are **Scene In** and **Scene Out**.

## Flattened Scene Filter

Place this process **after Scene Preprocessor**. It accepts **Geometry In** and emits **Geometry Out**, selecting flattened draws by equality or inequality of tag, material index, blend, depth-write, cull mode or topology. Set the integer **Match** for those modes. The format-ID modes instead compare the **Format ID** string. Use two branches to separate render passes without re-importing an asset.

The Scene Preprocessor merges the regular draws of a scene into one geometry. The tag, material index and format-ID modes select individual draws inside it: each draw is judged on its own `per_draws` record (its material tag and its `material_index` slot), and the kept draws are drawn from a command list. An instanced draw carries the tag of its prototype's material. The other modes keep or drop whole geometries. Filters can be chained.

## Scene Selector

Select a subtree **By path**, **By name** or **By index**, using **Path / Name** or **Index**. Index addresses the root list, starting at zero. **Rebase** is either Preserve transform or Zero out. Preserve retains the selected node's local transform, not the transforms of removed ancestors; Zero out removes its own transform for later placement with Transform 3D or Scene Group.

## Scene Switch

Select one of **Scene 0–3** using **Index** (`0–3`) and forward it to **Scene Out**. This switches entire scene contributions; it does not blend them. Use Camera Switch for weighted camera transitions.

## Scene Group

Combine **Scene 0–3** under a named group and apply **Position**, **Rotation** and **Scale** to it. **Name** makes the group addressable by path. Nest groups for larger compositions. This is useful for moving a model and its associated lights together.

## Scene Duplicator

Duplicate a hierarchy with **Pattern** Grid, Ring or Line. Set **Count**, **Spacing**, **Radius** and, for grids, **Grid cols** (`0` selects an approximately square grid). Copies receive indexed names for later path selection.

This duplicates scene nodes on the CPU while sharing material, animation and skeleton resources. Use it for individually addressable groups of objects. Use **Instancer** for large GPU-instanced populations, not thousands of duplicated hierarchies; see [[Instancing and materials]].

## Configure Primitive

Change active/visible flags on nodes selected by the **Paths** list. **Mode** offers Set active, Set inactive, Set visible, Set invisible, Active + visible and Inactive + invisible. Invisible leaves remain composed but are not drawn. Inactive subtrees are skipped during flattening. The process preserves the nodes so flags can be changed again without reloading the asset.

## Create Collection

Attach a named collection to **Scene In** and emit **Scene Out**. Set **Name**, a list of **Paths**, and optional **Tags**. A collection records membership and tags; it is not the same operation as moving nodes under a Scene Group or merging their mesh buffers.

## Tag As Format

Set **Format ID** on the incoming scene for downstream format-based routing. An empty value leaves the incoming designation alone. This labels the representation; it does not convert arbitrary mesh bytes into a splat format. Use with Flattened Scene Filter's format-ID modes when different representations require different rendering branches.

See [[Environments and cubemaps]] for **Scene Resource Route**, [[Geometry and buffer utilities]] for resource injection/extraction, and [[3D scene pipeline]] for the overall workflow.
