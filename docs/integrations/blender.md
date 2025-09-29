---
layout: default

title: Integrating with Blender
description: "Integrating with Blender"

nav_order: 1
parent: Integrations

permalink: /integrations/blender.html
---

# Integrating with Blender

It is possible to control most properties of a Blender project's nodal system through the NodeOSC addon, available from here: [https://github.com/maybites/blender.NodeOSC](https://github.com/maybites/blender.NodeOSC).

## Setup

1. Download the NodeOSC add-on's last version (this has been tested with version 2.4.0)

2. Install it in blender: Edit > Preferences> Add-ons > Install (top-right button) and enable it by checking its checkmark:


![Install]({{ site.img }}/integrations/blender/install.png "Install")

3. Check that it is activated in the drop-down here: 

![Enable]({{ site.img }}/integrations/blender/enable.png "Enable")

## Usage
The complete documentation of NodeOSC is available [at this link](https://github.com/maybites/blender.NodeOSC/wiki).

If you simply aim to control a node setting through OSC, here is how you can do it:

1. Open your material in the Nodes editor of Blender:

![Material 1]({{ site.img }}/integrations/blender/nodes1.png "Enable")

2. Select the parameter you aim to control over OSC, right-click on it and select "Copy full data path".

![Material 2]({{ site.img }}/integrations/blender/nodes2.png "Enable")

3. In the NodeOSC panel (if it is hidden, enable it through the little arrow on the left of the object tree), select "Create new message handler": 

![Material 3]({{ site.img }}/integrations/blender/nodes3.png "Enable")

4. Paste the data path you copied in the "datapath" field.

![Material 4]({{ site.img }}/integrations/blender/nodes4.png "Enable")

5. Set the OSC address you want in the first field and toggle "Start".

![Material 5]({{ site.img }}/integrations/blender/nodes5.png "Enable")

6. From score, you can now send OSC messages to this address: first add a matching OSC device: 

![Score 1]({{ site.img }}/integrations/blender/conf.png "Enable")

7. Then add a matching OSC address:

![Score 2]({{ site.img }}/integrations/blender/osc.png "Enable")


And from now on, changes to `blender:/lightness` in score will apply in teal-time to Blender!