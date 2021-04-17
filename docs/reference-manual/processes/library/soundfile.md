---
layout: default

title: Soundfiles
description: "Playing sound files in ossia score"

parent: Processes
grand_parent: Reference

permalink: /processes/soundfile.html
---


- Drag'n'drop depuis le système
- Drag'n'drop depuis la bibliothèque
- Les fichiers avec information de tempo sont mis en boucle & timestretch automatiquement
- 4 modes de timestretch:
  * Raw: pas de timestretch
  * Timestretch: timestretch normal, adapté aux instrus mélodiques
  * Timestretch (percussive): timestretch normal, adapté aux instrus percussifs
  * Repitch: change la hauteur

- Les fichiers .wav / .aiff à la même fréquence d'échantillonnage que celle de score sont lus depuis le disque
- Tous les autres fichiers sont convertis et stockés en RAM
  - Note : mentionner le ramdisk trick
- Formats supportés: tous ceux supportés par ffmpeg
  * https://www.ffmpeg.org/general.html#Audio-Codecs


- VST : scan dans la bibliothèque