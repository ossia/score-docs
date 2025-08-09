---
layout: default

title: My First Interactive Scene
description: "Step-by-step tutorial to create your first interactive score"

parent: Quick Start
nav_order: 10

permalink: /quick-start/my-first-interactive-scene.html
---

# My First Interactive Scene

In this tutorial, you will create a simple interactive scene where a video plays in a continuous loop, and you can instantly change the video's color using a key on your MIDI keyboard. This tutorial will introduce you to the core concepts of ossia score while creating something immediately impressive.

By the end of this tutorial, you will understand:
- How to work with the timeline
- How to add and control media processes
- How to set up device communication
- How to create mappings between controls and parameters

## What You'll Need

- A video file (MP4, MOV, or similar)
- A MIDI controller or keyboard (or you can use the computer keyboard)
- About 20 minutes

## Step 1: Setting Up Your Project (5 minutes)

### Create a New Project

1. **Launch ossia score** and select "New Project"
2. **Save your project** immediately (`Ctrl+S` / `Cmd+S`) as "MyFirstScene.ossia"

### Understanding the Interface

You'll see these key panels:
- **[[Device explorer]]** (left): Shows available devices and their parameters
- **Timeline** (center): Where you'll build your score
- **[[Inspector]]** (right): Shows properties of selected objects

## Step 2: Adding Your Video (5 minutes)

### Import Video File

1. **Drag and drop** your video file directly into the timeline
2. *score* automatically creates a **[[Video]]** process
3. The video appears as an interval in the timeline

![Video Import]({{ site.img }}/quick-start/first-scene/01-video-import.png)

### Make It Loop

1. **Select the video interval** by clicking on it
2. In the **[[Inspector]]** (right panel), find "Loop" settings
3. **Enable looping** to make the video play continuously
4. **Press the spacebar** to start playback

**🎉 First Success!** Your video should now be playing in a loop.

## Step 3: Adding Color Control (5 minutes)

Now let's add the ability to change the video's color.

### Add an ISF Shader

1. **Right-click** on the video process
2. Select **"Add process after"**
3. In the process library, navigate to **Graphics > ISF Shaders**
4. Choose **"Color Controls"** (or similar color adjustment shader)

### Connect Video to Shader

The shader should automatically connect to your video, but if not:
1. **Drag** from the video's output port to the shader's input port
2. You'll see a cable connecting them

![Shader Connection]({{ site.img }}/quick-start/first-scene/02-shader-connection.png)

**💡 Concept Check:** You've just created a processing chain! Video flows through the color shader before being displayed.

## Step 4: Setting Up MIDI Control (5 minutes)

Now let's set up your MIDI controller to control the color.

### Add a MIDI Device

1. **Connect your MIDI controller** to your computer
2. In the **[[Device explorer]]**, right-click and select **"Add device"**
3. Choose **"[[MIDI]]"** from the protocol list
4. Select your MIDI controller from the device list
5. Give it a name like "MyController"
6. Click **"Add"**

### Learn a MIDI Control

1. **Expand your MIDI device** in the Device Explorer
2. **Right-click** on your device and select **"Learn"**
3. **Press a key** on your MIDI controller
4. You'll see new addresses appear for the key you pressed

![MIDI Learning]({{ site.img }}/quick-start/first-scene/03-midi-learn.png)

## Step 5: Creating the Magic - Mapping! (5 minutes)

This is where everything comes together. You'll map your MIDI key to the shader's hue parameter.

### Find the Shader Parameters

1. **Select the Color Controls shader** in your timeline
2. Look at the **Inspector** - you'll see parameters like:
   - Hue
   - Saturation  
   - Brightness
   - Contrast

### Create the Mapping

1. In the **Device Explorer**, find your MIDI key (e.g., `MyController/key/60/velocity`)
2. **Drag this address** into the timeline to create an automation
3. **Connect the automation** to the shader's **Hue** parameter

Alternative method (easier):
1. **Right-click** on the shader's Hue parameter
2. Select **"Add automation"**
3. In the automation's **Inspector**, set the address to your MIDI key

![Mapping Connection]({{ site.img }}/quick-start/first-scene/04-mapping.png)

## Step 6: The Big Moment - Test It! (2 minutes)

1. **Press play** on your score (spacebar)
2. **Press the MIDI key** you mapped

**🎉 Amazing!** The video color should change when you press your key!

### Fine-tuning

- **Adjust the mapping range**: In the automation's Inspector, you can set how much the hue changes
- **Try other parameters**: Map different keys to Saturation, Brightness, etc.
- **Experiment**: Try different shaders for different effects

## Understanding What You've Built

Let's recap the flow you created:

```
[Video File] → [Color Shader] → [Display]
                     ↑
[MIDI Key] → [Automation/Mapping]
```

This demonstrates ossia score's core concept: **everything is connected through addresses and mappings**.

## Next Steps

Congratulations! You've successfully built your first interactive scene. You now understand:

✅ **Timelines**: How to organize processes in time  
✅ **Processes**: Video playback and effects  
✅ **Devices**: MIDI input communication  
✅ **Mappings**: Connecting controls to parameters  
✅ **The Address System**: How everything communicates  

### Expand Your Scene

Try these ideas:
- **Add more controls**: Map different keys to different parameters
- **Add audio**: Import an audio file and sync it with the video
- **Add more effects**: Try different ISF shaders
- **Use sensors**: Replace MIDI with webcam, Arduino, or other inputs

### Continue Learning

- **[Working with Audio](working-with-audio.html)**: Add sound to your scenes
- **[Working with Devices](working-with-devices.html)**: Connect more hardware
- **[States and Automations](states-and-automations-in-practice.html)**: Advanced control techniques
- **[Common Practices](../common-practices/common-practices.html)**: Professional workflows

## Troubleshooting

### Video Doesn't Play
- Check video format compatibility
- Try a different video file
- Ensure video codec is supported

### MIDI Not Working
- Verify MIDI device is connected
- Check MIDI device appears in system
- Try learning the control again

### Mapping Not Responding
- Verify the automation is connected
- Check mapping ranges in Inspector
- Test MIDI input in Device Explorer

### No Color Change
- Ensure shader is connected to video
- Check Hue parameter mapping
- Verify MIDI values are being received

## What You've Learned

This tutorial introduced you to ossia score's fundamental workflow:
1. **Import media** (video, audio, etc.)
2. **Process it** with effects and generators
3. **Connect external controls** (MIDI, sensors, etc.)
4. **Map controls to parameters** for interactivity
5. **Play and perform** your interactive scene

This same pattern scales from simple scenes to complex installations and performances. Welcome to the world of interactive scoring!

---

*💡 **Pro Tip**: Save presets of your favorite effect combinations. You can reuse them in future projects by dragging from the Library panel.*

*🎵 **Community**: Share your first interactive scene on the [ossia Discord](https://discord.gg/8Hzm4UduaS) - we'd love to see what you create!*