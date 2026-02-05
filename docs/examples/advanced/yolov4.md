---
layout: default

title: Machine learning (YOLOv4)
description: "An example showing object detection with YOLOv4 machine learning"

parent: Advanced
grand_parent: Examples

permalink: /examples/advanced/yolov4.html
---

# Machine Learning (YOLOv4)

This example demonstrates using machine learning for object detection in ossia score.

## Overview

ossia score can integrate machine learning models for computer vision tasks. This example uses YOLOv4 for real-time object detection.

## YOLO object detection

YOLO (You Only Look Once) is a real-time object detection system:
- Detects multiple object classes
- Returns bounding boxes and confidence
- Runs at video framerates

## Detected object data

The detector outputs:
- Object class (person, car, dog, etc.)
- Bounding box coordinates
- Confidence score
- Frame timestamp

## Object filter

The Object Filter process lets you:
- Select specific classes to track
- Filter by confidence threshold
- Extract positions for control

## Creative applications

ML in ossia score enables:
- Interactive installations (respond to people)
- Automated visuals (react to content)
- Data visualization (show what's detected)
- Experimental art (ML as creative tool)

## Requirements

TODO: Document ML model requirements and setup.

## Try it

If you have the required ML models installed, open this example with a camera connected to see real-time object detection!

[Download this example]({{ site.scores }}/examples/advanced/yolov4.score)

## Learn more

- [[AI Recognition]] - ONNX model inference for pose detection and more
- [[Classifier]] - Machine learning classification with RapidLib
- [[Regressor]] - Machine learning regression
- [[Camera device]] - Camera input configuration
- [[Object filter]] - Filtering detected objects
