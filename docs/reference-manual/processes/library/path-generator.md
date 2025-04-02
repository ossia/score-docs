---
layout: default

title: Path Generator
description: "Automate 2D X-Y parameters with a predefined path"

parent: Processes
grand_parent: Reference

permalink: /processes/2Dspline.html
---

# Path Generator (X-Y automation)

<img title="" src="file:///home/hacklab_01/.config/marktext/images/2025-04-01-11-10-39-image.png" alt="" width="682">

The path generator is a process that allows you to control 2D positions in time, by choosing predefined paths and moving cursors in the user interface. 



# Modifying Points

- Points can be dragged with the mouse.
  
  ![01042025104118RECmp4 videotogif output image](https://s2.ezgif.com/tmp/ezgif-2d6193817b94a5.gif)

- To create a new point, click on an empty space.
  
  ![01042025104118RECmp4 videotogif output image](https://s2.ezgif.com/tmp/ezgif-26db959c9d1d5b.gif)

- To delete a point, right-click on it.
  
  ![01042025104118RECmp4 videotogif output image](https://s2.ezgif.com/tmp/ezgif-2f0985c0a52098.gif)
  
  

# Parameters

- **Speed :** The speed of the movement can be modified by adjusting the speed parameter. Points move faster or slower depending on the parameter.  
  
  **NOTE :** Speed at 1 = movement takes 15 seconds to complete (one treatment cycle)
  
  

- **Ping Pong :** The PingPong option generates a continuous back-and-forth movement, avoiding a reset to the initial position. Instead of starting from the beginning, the animation naturally returns to the starting point.
  
  

- **Path :** Path selection is made in this parameter. For the moment, straight line, circle and spiral paths are available. The linear path allows you to move in a straight line between the start point (green) and the end point (red). The circle path allows circular movement around the center point (green), depending on the radius defined in another parameter.  The red cursor is useless in this case. The spiral path works in the same way as the circle, but generates a spiral movement.
  
  

- **Radius :** The Radius parameter defines the X and Y radii of the circle or spiral to be followed. For a spiral, it corresponds to the final radius. 
  
  **NOTE :** This parameter does not apply to the linear path.