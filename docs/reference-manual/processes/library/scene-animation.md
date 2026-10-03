---
layout: default
title: Scene animation
description: "Animate native scenes, transform objects and drive skeletons"
parent: Processes
grand_parent: Reference
permalink: /processes/scene-animation.html
---

# Scene animation

These processes take **Scene In** and emit **Scene Out**. Apply them before [[Scene Preprocessor]] so their transforms and skeleton changes reach the renderer. Imported animation or a rig must actually be present in the asset; a static mesh does not acquire a skeleton from these processes.

## Animation Player

Samples animation channels imported by [[Asset Loader]], including glTF and FBX node animation, and updates the scene and matching skeleton joints.

| Control | Use |
|---|---|
| Time | Animation sample time in seconds; connect automation or a time-generating process for explicit playback. |
| Speed | Playback rate used by the process's automatic advancement mode; negative values permit reverse advancement. |
| Loop | Wrap sample time around the clip duration. |
| Clip index | Zero-based animation component index. `-1` samples all components; useful when channels affect disjoint nodes. |

For timeline synchronization, **drive Time explicitly**. In the current implementation, changed Time values are followed directly; with Speed `0` or `1`, Time remains the sample position. If Time stays unchanged and Speed is neither `0` nor `1`, the internal clock advances by Speed × `1/60` second per processing call. That mode is not a transport-synchronized clock. Sampling all clips is also not a weighted crossfade between competing animations.

```text
Asset Loader → Animation Player → Inverse Kinematics (2-bone)
             → Scene Preprocessor → Render Pipeline
```

## Transform 3D

Apply **Position**, Euler **Rotation** in degrees and per-axis **Scale** to a scene. Use it to place imported assets or an extracted subtree without rewriting mesh vertices. For a group of separately wired scenes, Scene Group provides its own transform controls; see [[Scene tools]].

## Inverse Kinematics (2-bone)

Solve a three-joint chain (root → middle → end) toward a target. **End joint name** identifies the end of the chain; its two parents define the bones. **Target** is the desired world-space position, **Pole vector** controls the bend plane and **Weight** blends the correction (`0–1`).

The solver uses the first skeleton in the scene and preserves other scene data. It is a two-bone reach solver, not a whole-body IK system. Check the imported joint names and hierarchy, and place it after Animation Player if the IK correction should override an animated pose.

## Humanoid Retarget

Drive a rigged scene from live body observations. Connect a scene plus **Keypoints** or **Trackers**, then select **Source**: Off, BlazePose, COCO-17, RTMPose Whole or 6DOF Trackers. Choose a matching **Target rig** preset: Mixamo, VRM or Unreal Mannequin.

- **Confidence** rejects low-confidence keypoints.
- **Capture rest pose** calibrates the source pose against the rig's rest pose.
- **Root motion** enables hip translation; **Root scale** adjusts its magnitude.

The process maps supported joints on the first skeleton; it is not an arbitrary rig-name remapper. Off, missing pose data or a scene without a skeleton leave the scene unchanged. Pose sources require their own compatible producer and, where applicable, optional add-ons. This page does not imply a camera/model inference dependency is bundled with the 3D process.
