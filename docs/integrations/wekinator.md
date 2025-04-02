---
layout: default

title: "Integrating with Wekinator"
description: "Integrating with Wekinator"

nav_order: 2
parent: Integrations

permalink: /integrations/wekinator.html
---

# Integrating with Wekinator

[Wekinator](http://www.wekinator.org/) is a free and open-source software that allows you to use machine learning to build new musical instruments, gestural controllers, computer vision systems, and more. This guide explains how to integrate ossia score with Wekinator for interactive machine learning applications.

## Setup

1. Download and install Wekinator from [the official website](http://www.wekinator.org/downloads/)

3. Create OSC devices in score to communicate with Wekinator

2. Launch Wekinator and configure it to listen for OSC inputs, and/or output OSC messages

## Basic Configuration

### Setting up 

In Wekinator, set the input port (default is 6448) and start listening. More on this [here](http://www.wekinator.org/detailed-instructions/#Wekinator8217s_default_OSC_messages)

![Wekinator port settings]({{ site.img }}/integrations/wekinator/wekinator-input-ports.png "Wekinator port settings") 

In score, add a new [OSC device](https://ossia.io/score-docs/devices/osc-device.html) with the following settings:
   - Name: a descriptive label of your choice (e.g., "wekinator")
   - Device host: 127.0.0.1 or localhost
   - Output port (device listening port): 6448
   - Input port (score listening port): 9997 

![OSC Device]({{ site.img }}/integrations/wekinator/score_osc_device.png "OSC Device Configuration")

## Sending data to Wekinator

To send input features to Wekinator for training, we will use the OSC address format that Wekinator expects:
   - For input features: `/wek/inputs`
   - Followed by an array of floating-point values 

![Wekinator input field]({{ site.img }}/integrations/wekinator/wekinator-inputs-field.png "Wekinator input field")

In the 
- Right click on your OSC device, add a child `wek` of type container
- Right click on the container and add a child called `inputs`. Set the data type here to list (AKA an array)

Now you've configured your OSC message an the address of `/wek/inputs` and parameters. 

Set the output address of your process to the OSC device, and press play!

![Sending to Wekinator]({{ site.img }}/integrations/wekinator/process-output.png "Sending data to Wekinator") 

Check whether your data is being sent from score, you should see the data in the device explorer 

![Device Explorer]({{ site.img }}/integrations/wekinator/device-explorer.png "Device Explorer") 

and received in Wekinator, green means it's receiving data.

![OSC coming in]({{ site.img }}/integrations/wekinator/wekinator-osc.png "OSC coming in")


## Receiving outputs from Wekinator

1. Configure Wekinator's output OSC messages (by default, `/wek/outputs`)

![Wekinator port settings]({{ site.img }}/integrations/wekinator/wekinator-output-ports.png "Wekinator port settings") 

<!-- 2. In your score, create OSC output device for Wekinator's output messages:   
## Example: Training a gesture recognizer

1. Set up Wekinator to receive pose recognition data from ossia score
2. Train Wekinator with different gestures
3. Use Wekinator's output to trigger events in score 

Add example score / link from AI

-->

## Troubleshooting

- Verify port numbers match between ossia score and Wekinator
- Check that message format matches Wekinator's expectations
- Make sure you're not using that port in another application!