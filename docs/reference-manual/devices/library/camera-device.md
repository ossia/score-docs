---
layout: default

title: Camera device
description: "Using a camera as source for visuals in ossia score"

nav_order: 16
parent: Devices
grand_parent: Reference

permalink: /devices/camera-device.html
---

## Usage
Score supports using camera inputs in its VFX graph.

## Example
- Brancher la caméra
- Faire Add Device > Camera
- La caméra devrait apparaître dans la liste.
- Ajouter un shader, par exemple Video.fs (Presets/GLSL_shaders in the user library)
- Ajouter un device Window pour avoir un endroit ou lire la vidéo.
- Dans le shader mettre l'entrée à la camera, la sortie à la window.
- Faire play :-)

## Informations techniques
## Utiliser les API système sous windows & mac
Rien de spécial ?

## Utiliser V4L2 sous linux
The v4l2loopback kernel module allows for a lot of useful things.

### Exemple Linux de grabbing d'écran

```bash
$ sudo modprobe v4l2loopback
$ ffmpeg -f x11grab -framerate 60 -video_size 3840x2160 -i :0.0+0,0 -f v4l2 /dev/video0
```

### Exemple Linux de forwarding de vidéo
```bash
$ sudo modprobe v4l2loopback
$ while 1 ; do ffmpeg -re -i ./test.mp4 -f v4l2 /dev/video0 ; done
```
