---
layout: default
title:  "How to control score using OSCQuery ?"

parent: FAQ

permalink: /score/faq/controlling-score-with-oscquery.html
category: "site-score"

description: "How to control score using OSCQuery ?"

tag: "Controls"
visible: true
---

While *score* can synchronise and automate your media softwares and hardware, it can also be remote controlled, should you need to control your scenario execution using some hyper advanced next generation AI software, a custom sensor interface or whatever fits your needs.

# Using score OSCQuery device

score exposes its scenario execution parameters through OSCQuery protocol so they can be monitored and controlled locally or from any device on the network. For example, using score's own Device explorer, you will see when browsing available OSCQuery devices the score application and its address and port. 

![score OSCQuery device](/assets/images/faq/controlling-score-with-oscquery/score_oscquery_device.png "score OSCQuery device")

Exposed parameters include:

- `exit`: Close current scenario
- `play`: Play score's current scenario
- `reconnect`: Reconnect a device
- `reinit`: Stop score execution and recall init state
- `running`: Report whether score is playing
- `stop`: Stop scenario execution
- `transport`: Set scenario main playhead at a particular point (in ms.)

Below is a simple Max patcher provided in [ossia-max package](http://ossia.io/site-libossia/download.html#max-binding) illustrating remote control of score's transport.

![Remote transport](/assets/images/faq/controlling-score-with-oscquery/remote_transport.png "Remote transport")
