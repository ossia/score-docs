---
layout: default
title: Depth cameras
description: "Color, infrared, depth, point clouds and IMU data from Orbbec, Kinect, Azure Kinect, Intel RealSense and Luxonis OAK cameras"
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
| `ir` | texture | Infrared image (on a time-of-flight camera, the amplitude image). |
| `depth` | texture | 16-bit depth image. |
| `pointcloud` | geometry | Connect it to a 3D process, such as a model display or any geometry input. |
| `imu/accel`, `imu/gyro`, `imu/temperature` | vec3f / float | Inertial sensors, when the camera has them and the **Accelerometer / gyroscope** option is enabled. |

Point cloud positions are in metres, right-handed, with +X to the right, +Y down and +Z forward. Accelerations are in m/s² (including gravity) and angular velocities in rad/s.

Textures can be processed with [shaders]({{ site.baseurl }}/processes/shaders.html) and the computer vision objects, and the point cloud can be used in [3D scenes]({{ site.baseurl }}/in-depth/3d-scene-pipeline.html).

## Camera settings

The settings that each camera's SDK allows to change appear under a `controls` node, grouped by what they affect: for instance
`controls/color/exposure`, `controls/depth/laser_power` or `controls/sensors/temperature`. They are ordinary parameters with their real type and range:
they can be automated, mapped or controlled over OSC. Read-only values (temperatures, measured exposure) are under `sensors/`, and rarely needed actions
such as rebooting the camera are under `advanced/`.

On Luxonis OAK-D Pro cameras, `depth/laser_power` turns on the dot projector, which is off by default and needed to measure depth on plain surfaces.

## Alignment, resolution and frame rate

**Alignment** brings the depth and color images into the same frame of reference, and decides the resolution of the point cloud:

- **Color to depth** (default): the point cloud has the depth resolution. This is usually the right choice for point clouds.
- **Depth to color**: the point cloud has the color resolution, which is much heavier (about five times more points than measured on a Femto Mega). Use it when you need pixel-aligned color and depth images.
- **None**: no alignment. A colored point cloud requires an alignment other than None.

Choosing an explicit color resolution is the simplest way to reduce the cost of a *depth to color* point cloud.

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

More details are in the [add-on's README](https://github.com/ossia/score-addon-orbbec#readme).
