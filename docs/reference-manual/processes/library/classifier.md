---
layout: default

title: Classifier
description: "Machine learning classification based on RapidLib"

parent: Processes
grand_parent: Reference

permalink: /processes/classifier.html
---
# Classifier

![Classifier]({{ site.img }}/reference/processes/classifier.png "Machine Learning Classifier")

The Classifier process provides real-time machine learning classification capabilities using RapidLib algorithms. It's similar to tools such as Wekinator but integrated directly into *score*'s processing pipeline.

It is very close to the [[Regressor]] process: the difference is that [[Regressor]] interpolates while [[Classifier]] outputs the exact input value that was set during training.

## Overview

The Classifier enables:
- Real-time pattern recognition
- Gesture classification
- Sensor data categorization
- Multi-class decision making
- Adaptive learning during performance

Perfect for:
- Interactive installations
- Gesture-controlled instruments
- Sensor-based interactions
- Adaptive audio/visual systems

## Inputs

| Port | Type | Description |
|------|------|-------------|
| Features | Float Array | Input feature vector |
| Record | Impulse | Record training example |
| Train | Impulse | Train the model |
| Reset | Impulse | Clear all training data |
| Target | Float inlets | Target values for recording |

## Outputs

| Port | Type | Description |
|------|------|-------------|
| Prediction | Float | Predicted output |


## Inputs

| Port | Type | Description |
|------|------|-------------|
| Features | Float Array | Input feature vector |
| Record | Impulse | Record training example |
| Train | Impulse | Train the model |
| Reset | Impulse | Clear all training data |
| Target | Float inlets | Target values for recording |

## Outputs

| Port | Type | Description |
|------|------|-------------|
| Prediction | Float | Predicted output values |


## Usage Workflow

### 1. Define Mapping

Decide what you want to map:
-  Inputs : Sensor values, analysis data, control positions
-  Outputs : Audio parameters, visual controls, device values

### 2. Data Collection

For each training point:
1. Set inputs to desired state
2. Set **Target** to desired outputs
3. Trigger **Record**
4. Repeat across your mapping space

### 3. Training and Use

```
Training Phase:
[Input State] → [Set Target] → [Record] → [Collect Examples] → [Train]

Runtime Phase:
[Live Input] → [Regressor] → [Smooth Output] → [Parameter Control]
```

## Example Applications

### Gesture Recognition

Recognize hand gestures from accelerometer data:

```
[Accelerometer] → [Feature Extraction] → [Classifier] → [Gesture Type]
                        ↓                                      ↓
                 [X, Y, Z, Magnitude]                   [Visual Response]
```

Training process:
1. Perform "wave" gesture, record as Class 1 (input knob at value 0)
2. Perform "circle" gesture, record as Class 2 (input knob at value 0.5)
3. Perform "tap" gesture, record as Class 3 (input knob at value 1.0)
4. Train the model
5. Real-time gesture recognition

### Audio Classification

Classify different types of sounds:

```
[Audio Input] → [FFT] → [Spectral Features] → [Classifier] → [Sound Type]
                              ↓                                    ↓
                  [Centroid, Rolloff, ZCR]               [Trigger Actions]
```

### Movement Classification

Classify dancer movements from video analysis:

```
[Camera] → [Pose Detection] → [Movement Features] → [Classifier] → [Dance Style]
                                     ↓                                    ↓
                          [Joint Velocities, Angles]            [Music Selection]
```

## Feature Engineering

Good features are crucial for classification performance:

### Common Feature Types

**Time Domain**:
- Mean, standard deviation
- Min, max values
- Zero crossing rate
- Peak locations

**Frequency Domain**:
- Spectral centroid
- Spectral rolloff
- MFCC coefficients
- Energy in bands

**Motion Features**:
- Velocity, acceleration
- Jerk (rate of acceleration change)
- Angular velocity
- Trajectory curvature

### Feature Extraction Example

```
[Raw Sensor] → [Sliding Window] → [Statistics] → [Features]
                      ↓                 ↓
               [Buffer 100ms]    [Mean, Std, Peak]
```

## Training Best Practices

### Data Collection
1.  Diverse Examples : Collect varied examples for each class
2.  Balanced Dataset : Similar number of examples per class
3.  Representative Data : Examples should cover expected variations
4.  Clean Data : Remove obvious errors and outliers

### Class Design
1.  Distinct Classes : Make sure classes are meaningfully different
2.  Consistent Labeling : Be consistent with class definitions
3.  Sufficient Examples : At least 10-20 examples per class
4.  Test Data : Keep some examples for testing

### Performance Monitoring
- Check confidence scores
- Monitor misclassification patterns
- Retrain with additional data if needed

## Integration Examples

### Interactive Music

```
[Gesture Input] → [Classifier] → [Music Style]
                                      ↓
                                 [Instrument Selection]
                                 [Scale Selection]
                                 [Rhythm Pattern]
```

### Adaptive Visuals

```
[Environmental Data] → [Classifier] → [Mood Classification]
                                             ↓
                                      [Color Palette]
                                      [Animation Speed]
                                      [Effect Selection]
```

### Smart Lighting

```
[Activity Sensors] → [Classifier] → [Activity Type]
                                          ↓
                                   [Lighting Scene]
                                   [Color Temperature]
                                   [Brightness Level]
```

## Related Processes

- [Regressor](/processes/regressor.html) - For continuous value prediction
- [Analysis](/processes/analysis.html) - Feature extraction from audio
- [Computer Vision Utilities](/processes/computer-vision-utilities.html) - Visual features
- [Array Utilities](/processes/array-utilities.html) - Feature preprocessing


## Try it!

Try it by downloading this [simple example!]({{ site.scores }}/reference/processes/classifier.score)