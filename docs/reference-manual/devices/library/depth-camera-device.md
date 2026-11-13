---
layout: default
title: Depth cameras
description: "Color, infrared, metric depth, 3D positions, meshes, point clouds, calibration and IMU data from Orbbec, Kinect, Azure Kinect, Intel RealSense and Luxonis OAK cameras"
parent: Devices
grand_parent: Reference
permalink: /devices/depth-camera-device.html
---

# Depth cameras

The **Depth Camera Input** device streams color, infrared, depth images and point clouds from depth cameras into ossia score,
along with their inertial sensors and settings. It is available in the desktop builds since **3.9.0**.

## Supported cameras

| Camera | Linux | Windows | macOS |
|---|---|---|---|
| Orbbec Femto Mega / Mega i / Bolt | yes | yes | color and infrared only¹ |
| Orbbec Gemini 330 / 335 / 336 / 345, Gemini 2, Astra 2, DaBai | yes | yes | yes |
| Kinect v2 (Xbox One) | yes | yes | yes |
| Kinect v1 (Xbox 360) | yes | yes | yes |
| Azure Kinect DK | yes | yes | no² |
| Intel RealSense D400 / D500 / L500 / SR300 | yes | yes | yes |
| Luxonis OAK-D, OAK-1 and OAK-4, including PoE models | yes | yes | yes |
| Oak3DVision Oak CDK / QCDK (time-of-flight) | yes | no³ | Intel Macs only³ |

¹ The Femto Mega and Bolt compute depth with an Orbbec depth engine that is not available for macOS. The Gemini and Astra cameras compute depth on the device and are not affected.<br/>
² Microsoft never released an Azure Kinect SDK for macOS.<br/>
³ The vendor only ships prebuilt binaries for Linux, Intel macOS and 32-bit Windows.

Orbbec Femto Mega cameras and Luxonis OAK PoE cameras also work over Ethernet.

## Installation

The device itself ships with ossia score. The camera drivers come as a single **Depth cameras** package to install from score's
[package manager]({{ site.baseurl }}/package-manager.html), then restart score.

### Linux: install the udev rules

The cameras are accessed over raw USB. Without the matching udev rules, the camera is not accessible and score reports no camera,
exactly as if nothing was plugged in. The package contains the rules for all supported cameras:

```sh
sudo cp ~/Documents/ossia/score/packages/depth-camera/udev/*.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules && sudo udevadm trigger
```

Then unplug and replug the camera.

### Azure Kinect: install Microsoft's SDK

The Azure Kinect depth engine cannot be redistributed. Install the [Azure Kinect Sensor SDK](https://github.com/microsoft/Azure-Kinect-Sensor-SDK) system-wide,
or place `libk4a` and its `libk4a1.4/libdepthengine` subfolder in the package folder. If it is missing, score's log says so.

### USB 3

The Azure Kinect DK, the Kinect v2 and the RealSense D400 series need a USB 3 port. On USB 2, the Kinect v2 and Azure Kinect do not show their cameras at all,
and RealSense cameras fall back to very low frame rates. A USB-C cable does not guarantee a USB 3 port.

## Adding the device

In **Add device**, choose **Depth Camera Input** in the **Video In** category. Each installed camera family appears as its own category in the browser,
listing the cameras it can see; selecting one fills in its address. Leave the address empty to use the first camera found.

The address can also be typed, for instance to reach a camera by serial number or over the network:

```
orbbec:sn:CL8L1234ABC          Orbbec camera, by serial number
orbbec:net:192.168.0.12:8090   Femto Mega over Ethernet
freenect2:sn:012345678901      Kinect v2
freenect:index:0               Kinect v1
k4a:sn:000123456789            Azure Kinect
realsense:sn:040322070203      RealSense
```

If the requested camera is not present, the device does not connect rather than silently using another camera.

## Streams

The device has one node per enabled stream:

| Node | Type | Notes |
|---|---|---|
| `rgb` | texture | Color image. Not available on time-of-flight cameras without a color sensor. |
| `ir` | texture | Infrared image (on a time-of-flight camera, the amplitude image), as a 32-bit float texture from 0 to 1, scaled by `controls/render/ir_gain`. |
| `depth` | texture | Depth in metres along the camera's axis, as a 32-bit float (R32F) texture; 0 where the camera has no measurement. With **Depth output: Preview**, a grey image from 0 (black) to 4.5 m (white) instead. |
| `positions` | texture | Optional. One RGBA32F texel per depth pixel: the 3D position in metres in xyz, and 1 in w where the depth is valid. |
| `normals` | texture | Optional. The surface normal at each depth pixel, facing the camera. |
| `mesh` | geometry | Optional. The depth image as a triangle mesh computed on the GPU, with positions, normals and texture coordinates into the color image. Triangles across depth edges are removed. |
| `pointcloud` | geometry | The point cloud computed by the camera's SDK on the CPU. Connect it to a 3D process, such as a model display or any geometry input. |
| `imu/accel`, `imu/gyro`, `imu/temperature` | vec3f / float | Inertial sensors, when the camera has them and the **Accelerometer / gyroscope** option is enabled. |

Positions, the mesh and the point cloud are in metres, right-handed, with +X to the right, +Y down and +Z forward from the depth camera. Accelerations are in m/s² (including gravity) and angular velocities in rad/s.

The depth, positions, normals and mesh outputs are computed together on the GPU from each depth frame, whatever unit the camera uses, and only for the outputs that are connected. A stream that nothing uses is not computed at all: in particular, the CPU point cloud costs nothing while it is not connected.

A float texture keeps its precision only when the shader input it goes to is float too. Set the input's texture format to R32F (RGBA32F for positions), or declare the input `"STATIC": true` in the shader, which samples the device's texture directly.

The mesh needs compute shader support, available with every graphics API except OpenGL older than 4.3 (OpenGL ES older than 3.1).

Textures can be processed with [shaders]({{ site.baseurl }}/processes/shaders.html) and the computer vision objects, and the geometry outputs can be used in [3D scenes]({{ site.baseurl }}/in-depth/3d-scene-pipeline.html).

### Processing

The `controls/render` node holds processing that works the same on every camera:

| Control | Effect |
|---|---|
| `near`, `far` | Depth closer or farther than these distances, in metres, is treated as invalid. 0 means no limit. |
| `stage_box/enabled`, `stage_box/min`, `stage_box/max` | Only keep what lies inside a box, given in metres in the depth camera's frame. |
| `temporal` | Smooths depth over time: the weight of the previous frames, 0 for none. A change of more than 5 % is treated as movement and is not smoothed. |
| `edge_cull` | Mesh triangles whose longest edge is longer than this factor times their distance are removed. 0 keeps every triangle with three valid corners. |
| `topology` | Whether the mesh is drawn as `triangles` or `points`. |
| `ir_gain` | Infrared brightness. |

## Calibration and stream information

The device also publishes what the camera reports about itself, as read-only parameters that shaders and scripts can use:

| Address | Content |
|---|---|
| `info/model`, `info/serial`, `info/firmware`, `info/backend`, ... | The camera's identity. |
| `info/depth_unit_mm` | Millimetres per raw depth sample. |
| `info/depth_range` | The range the depth mode measures, in metres. |
| `calibration/depth/intrinsics` (also `color`, `ir`) | The focal lengths and principal point fx, fy, cx, cy, in pixels of the image as delivered. |
| `calibration/depth/width`, `height`, `distortion/model`, `distortion/coeffs` | The image size and lens distortion (coefficients k1 to k6, p1, p2). |
| `calibration/depth/projection` | A projection matrix for raw raster shaders, from the camera's frame to clip space, for the `render/near` and `render/far` planes. |
| `calibration/depth_to_color` | The transform from the depth camera to the color camera, as 16 numbers (a column-major 4×4 matrix, in metres), and as four vec4 rows `row0` to `row3` for shaders. |
| `calibration/depth_to_imu` | The same, to the inertial sensor. |
| `stats/depth/frames`, `dropped`, `fps`, `device_time_ms`, `host_time_ms`, `interval_ms` (also for the other streams) | Frame counts and timing. `device_time_ms` is updated at every frame. |

Pixel coordinates follow OpenCV: the center of pixel (u, v) is at (u, v). When depth is aligned to color, the depth image has the color camera's intrinsics.
When a camera does not report its calibration, `info/calibration_estimated` is true and a 60° field of view is assumed.

For depth that does not come from this device, such as a depth estimation model, the **Depth to positions** compute shader distributed with the add-on computes the same `positions` image from a depth image and intrinsics.

## Camera settings

The settings that each camera's SDK allows to change appear under a `controls` node, grouped by what they affect: for instance
`controls/color/exposure`, `controls/depth/laser_power` or `controls/sensors/temperature`. They are ordinary parameters with their real type, range and unit:
they can be automated, mapped or controlled over OSC.

- `filters/` holds the SDK's own depth filters, on the cameras that have them (Orbbec, RealSense, Luxonis OAK, Kinect v2): spatial and temporal smoothing, hole filling, decimation, thresholds...
- `device/preset` and `depth/mode` choose a camera preset or depth mode, on the cameras that have them. Changing the depth mode restarts the stream.
- Read-only values (temperatures) are under `sensors/`. While an automatic setting is on, such as auto exposure, the setting it controls is read-only.
- Rarely needed actions, such as rebooting the camera, are under `advanced/`.

Settings written to the camera are saved with the score and applied again when the device connects. `advanced/store_current_settings` saves all the
camera's current settings, including those changed in another program, and `advanced/reset_to_defaults` puts the camera back to its defaults and forgets
the saved settings.

On Luxonis OAK-D Pro cameras, `depth/laser_power` turns on the dot projector, which is off by default and needed to measure depth on plain surfaces.

## Alignment, resolution and frame rate

**Alignment** brings the depth and color images into the same frame of reference, and decides the resolution of the point cloud:

- **Color to depth** (default): the point cloud has the depth resolution. This is usually the right choice for point clouds.
- **Depth to color**: the point cloud has the color resolution, which is much heavier (about five times more points than measured on a Femto Mega). Use it when you need pixel-aligned color and depth images.
- **None**: no alignment. A colored point cloud requires an alignment other than None.

Choosing an explicit color resolution is the simplest way to reduce the cost of a *depth to color* point cloud. For cameras that report them, each stream
lists the resolutions and frame rates the camera supports.

## Troubleshooting

| Symptom | Likely cause |
|---|---|
| No camera at all in the browser | The Depth cameras package is not installed, or score was not restarted after installing it. |
| One camera family is missing | Its udev rules are not installed (Linux), or for Azure Kinect, the Microsoft SDK is missing. |
| Kinect v2 or Azure Kinect missing, RealSense very slow | The camera is on a USB 2 port. |
| Network Orbbec cameras do not appear | A firewall drops the broadcast replies of the cameras (UDP source port 3956), or the camera is on another subnet: type its address instead. |
| *Colored point cloud* is greyed out | Alignment is set to None. |
| No `controls` node | The camera's SDK offers no settings for this model. |

Set the environment variable `SCORE_DEPTHCAM_DEBUG=1` to log, every second, how many frames each point cloud receives.

More details are in the [add-on's README](https://github.com/ossia/score-addon-orbbec).
