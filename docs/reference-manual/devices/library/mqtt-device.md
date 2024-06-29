---
layout: default

title: MQTT device
description: "Using the MQTT protocol in ossia score"

parent: Devices
grand_parent: Reference

permalink: /devices/mqtt-device.html
---

![Device setup window]({{ site.img }}/reference/devices/mqtt-device.png "score device setup")

[MQTT](https://en.wikipedia.org/wiki/MQTT) is a communication protocol tailored for IoT based on the publish-subscribe mechanism.

It usually defaults to port 1883.

To use MQTT, one requires a MQTT broker and MQTT publishers / subscribers.
ossia score can both publish and subscribe to MQTT topics. 

Note that MQTT does not have a concept of automatic discovery: instead, one must use the "Learn" feature to discover
available MQTT topics, or create one manually just like in OSC devices.

## Example
To try MQTT, one can use [Mosquitto](https://mosquitto.org/).

In a terminal, start the MQTT broker with: 
```
$ mosquitto
```

In a second terminal, publish a message `hi` to a topic `/foo`:
```
$ mosquitto_pub -t /foo -m hi --repeat 1000000 --repeat-delay 1 -h 127.0.0.1
```

In a third terminal, listen to the messages sent to the topic `/bar`:
```
$ mosquitto_sub -t /bar
```

In ossia, connect to 127.0.0.1 with the MQTT protocol, use the "Learn" feature to discover `/foo`, and add a new child node to send messages to the `/bar` topic.

Important : many MQTT brokers are unable to handle loops, that is, one cannot both publish and subscribe to the same topic as is customary with e.g. OSC.

![MQTT example]({{ site.img }}/reference/devices/mqtt/example.png "MQTT example")