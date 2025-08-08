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

The Classifier process provides real-time machine learning classification capabilities using RapidLib algorithms. It's similar to tools like Wekinator but integrated directly into score's processing pipeline.

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
| Class | Integer | Class label for recording |

## Outputs

| Port | Type | Description |
|------|------|-------------|
| Classification | Integer | Predicted class label |
| Confidence | Float | Prediction confidence (0-1) |
| Probabilities | Float Array | Per-class probabilities |
| Status | String | Current state (recording/trained/etc.) |

## Parameters

| Parameter | Widget | Description | Default | Range |
|-----------|--------|-------------|---------|-------|
| Num Classes | Integer | Number of classification classes | 2 | 2-20 |
| Feature Size | Integer | Input feature vector size | 3 | 1-50 |
| Algorithm | Dropdown | ML algorithm | "kNN" | kNN, SVM, Neural Network |
| K Value | Integer | Neighbors (for kNN) | 3 | 1-20 |
| Auto Train | Toggle | Train after each recording | Off | On/Off |

## Machine Learning Algorithms

### k-Nearest Neighbors (kNN)
- Fast classification
- No training phase needed
- Good for gesture recognition
- Robust to noise

### Support Vector Machine (SVM)
- Better for complex boundaries
- Requires training phase
- Good generalization
- Works with fewer examples

### Neural Network
- Most flexible
- Requires more training data
- Can learn complex patterns
- May overfit with small datasets

## Usage Workflow

### 1. Setup Phase

Configure the classifier:
1. Set **Num Classes** (how many categories you want)
2. Set **Feature Size** (how many input values)
3. Choose **Algorithm** based on your needs

### 2. Training Phase

Collect training examples:

```
[Sensor Data] → [Feature Extraction] → [Classifier]
                                            ↑
                                     [Record Button]
                                     [Class Selector]
```

For each class:
1. Set the **Class** parameter to the class number
2. Generate representative sensor data
3. Trigger **Record** to capture training examples
4. Repeat for all classes

### 3. Training

Once you have examples for all classes:
1. Trigger **Train** to build the model
2. Wait for training to complete
3. Status will show "Trained"

### 4. Classification

Use the trained model:

```
[Live Sensor Data] → [Classifier] → [Classification Result]
                                  → [Confidence Level]
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
1. Perform "wave" gesture, record as Class 1
2. Perform "circle" gesture, record as Class 2  
3. Perform "tap" gesture, record as Class 3
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
1. **Diverse Examples**: Collect varied examples for each class
2. **Balanced Dataset**: Similar number of examples per class
3. **Representative Data**: Examples should cover expected variations
4. **Clean Data**: Remove obvious errors and outliers

### Class Design
1. **Distinct Classes**: Make sure classes are meaningfully different
2. **Consistent Labeling**: Be consistent with class definitions
3. **Sufficient Examples**: At least 10-20 examples per class
4. **Test Data**: Keep some examples for testing

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

## Troubleshooting

### Poor Classification
- **Check feature quality**: Are features discriminative?
- **Add more training data**: Especially for confused classes
- **Try different algorithm**: kNN vs SVM vs Neural Network
- **Adjust parameters**: K value for kNN, etc.

### Inconsistent Results
- **Normalize features**: Ensure similar scales
- **Check for overfitting**: Too many features vs examples
- **Validate training data**: Remove inconsistent examples
- **Consider feature selection**: Remove irrelevant features

### Performance Issues
- **Reduce feature size**: Use most important features only
- **Limit training data**: Keep reasonable dataset size
- **Choose faster algorithm**: kNN is usually fastest
- **Optimize update rate**: Don't classify faster than needed

## Advanced Techniques

### Cross-Validation

Test model performance:
1. Split training data into train/test sets
2. Train on training set
3. Test on test set
4. Monitor accuracy and confusion matrix

### Online Learning

Update the model during performance:
1. Continue recording new examples
2. Periodically retrain
3. Adapt to changing conditions
4. Handle concept drift

### Ensemble Methods

Combine multiple classifiers:
```
[Features] → [Classifier 1] → [Vote Combiner] → [Final Result]
          → [Classifier 2] →
          → [Classifier 3] →
```

## Related Processes

- [Regressor](/processes/regressor.html) - For continuous value prediction
- [Analysis](/processes/analysis.html) - Feature extraction from audio
- [Computer Vision Utilities](/processes/computer-vision-utilities.html) - Visual features
- [Array Utilities](/processes/array-utilities.html) - Feature preprocessing