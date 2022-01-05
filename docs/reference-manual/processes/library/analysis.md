---
layout: default

title: Analysis
description: "Analysis processes"

parent: Processes
grand_parent: Reference

permalink: /processes/analysis.html
---

# Analysis processes

Real-time music information retrieval (MIR) processes are available, thanks to the Gist library.
They allow to easily build audio-reactive visuals, by extracting meaningful parameters from a live 
or pre-recorded audio signal.

Here is a video example of their usage:

<div class="videoWrapper">
<iframe src="https://player.vimeo.com/video/659142817?h=d98d5c8721" width="640" height="360" frameborder="0" allow="autoplay; fullscreen; picture-in-picture" allowfullscreen></iframe>
</div>

## Envelope

![Envelope]({{ site.img }}/reference/processes/analysis-envelope.png "Envelope example")

These processes allow to extract the volume of an audio signal.

## Onset detection

![Onset]({{ site.img }}/reference/processes/analysis-onsets.png "Onset detection example")

These processes allow to detect hits and impacts and are useful for beat detection.
The first outlet outputs the detection signal. 
The second outlet outputs an impulse when an onset is detected.

## Pitch detection

![Pitch]({{ site.img }}/reference/processes/analysis-pitch.png "Pitch detection example")

These processes allow to estimate the pitch of a monophonic signal (between 150 and 1500 Hz). 

## Spectral parameters

![Spectral parameters]({{ site.img }}/reference/processes/analysis-spectral.png "Spectral parameters example")

These processes allow to extract parameters related to the spectrum and the timbre of an audio signal.

## Spectrum extraction

![Spectrum extraction]({{ site.img }}/reference/processes/analysis-spectral2.png "Spectrum extraction example")

These processes convert the input audio signal in an "audio" signal containing the spectra, and are mainly useful for further processing
in custom processes.
