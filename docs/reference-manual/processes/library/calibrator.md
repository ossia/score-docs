---
layout: default

title: Calibrator
description: ""

parent: Processes
grand_parent: Reference

permalink: /processes/calibrator.html
---
# Calibrator

![Calibrator]({{ site.img }}/reference/processes/calibrator.png "Calibrator")

This process allows to calibrate an input signal to extract the "significant" part of the signal, when 
it is impossible to define an accurate range of values at the time the score is being authored: for instance, consider 
a temperature sensor. Its range as defined in the [[Device explorer]] could be between -30°C and 70°C. However, the daily variations 
could be sometimes around 15°, sometimes around 25°... with most of the range being unused.

The Calibrator object outputs values between 0 and 1, by computing over time the actual minimum and maximum of the input values and scaling between those.
In addition, it allows to access a few statistics on the input signal.

The effective range can further be adjusted and shaped.

To get its output, simply connect to the "Scaled" output.

In this example, the input of the calibrator is connected to the "temperature" sensor, which has a range of 0-100°.
But if the inputs of the process only vary between 10° and 30° while the installation is runnning, the scaled output will be 0 for 10° and 1 for 30°.

![Calibrator]({{ site.img }}/reference/processes/calibrator-example.gif "Calibrator")