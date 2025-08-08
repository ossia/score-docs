---
layout: default

title: Regressor
description: "Machine learning regression based on RapidLib"

parent: Processes
grand_parent: Reference

permalink: /processes/regressor.html
---
# Regressor

![Regressor]({{ site.img }}/reference/processes/regressor.png "Machine Learning Regressor")

The Regressor process provides real-time machine learning regression capabilities using RapidLib algorithms. Unlike classification which predicts discrete classes, regression predicts continuous values - perfect for mapping complex sensor data to smooth control parameters.

## Overview

The Regressor enables:
- Multi-dimensional input to output mapping
- Smooth interpolation between training points
- Real-time continuous value prediction
- Non-linear relationship learning
- Adaptive parameter control

Perfect for:
- Gesture-to-sound mapping
- Environmental sensor control
- Complex motion tracking
- Adaptive audio/visual parameters
- Smooth interactive responses

## Inputs

| Port | Type | Description |
|------|------|-------------|
| Features | Float Array | Input feature vector |
| Record | Impulse | Record training example |
| Train | Impulse | Train the model |
| Reset | Impulse | Clear all training data |
| Target | Float Array | Target values for recording |

## Outputs

| Port | Type | Description |
|------|------|-------------|
| Prediction | Float Array | Predicted output values |
| Confidence | Float | Prediction reliability |
| Error | Float | Training error (if available) |
| Status | String | Current state |

## Parameters

| Parameter | Widget | Description | Default | Range |
|-----------|--------|-------------|---------|-------|
| Input Size | Integer | Number of input features | 2 | 1-20 |
| Output Size | Integer | Number of output values | 1 | 1-20 |
| Algorithm | Dropdown | ML algorithm | "Neural Network" | NN, Linear, Polynomial |
| Hidden Nodes | Integer | Neural network size | 10 | 5-100 |
| Auto Train | Toggle | Train after each recording | Off | On/Off |

## Regression Algorithms

### Neural Network
- Best for complex non-linear mappings
- Can learn arbitrary input-output relationships
- Requires sufficient training data
- Good generalization with proper training

### Linear Regression
- Simple linear relationships
- Fast training and prediction
- Good baseline algorithm
- Limited to linear mappings

### Polynomial Regression
- Non-linear but structured relationships
- Good for smooth curves
- Less data required than neural networks
- Can overfit with high-degree polynomials

## Usage Workflow

### 1. Define Mapping

Decide what you want to map:
- **Inputs**: Sensor values, analysis data, control positions
- **Outputs**: Audio parameters, visual controls, device values

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

### Gesture-to-Sound Mapping

Map hand position to audio parameters:

```
[Hand Tracker] → [X, Y Position] → [Regressor] → [Volume, Pitch, Filter]
                                                        ↓
                                                [Audio Synthesis]
```

Training process:
1. Move hand to top-left: Record [high volume, low pitch, open filter]
2. Move to bottom-right: Record [low volume, high pitch, closed filter]
3. Add more points to define the mapping space
4. Train the model for smooth interpolation

### Environmental Control

Map multiple sensors to lighting parameters:

```
[Temperature] → [Feature Vector] → [Regressor] → [Hue, Saturation, Brightness]
[Humidity]    →                                             ↓
[Light Level] →                                      [LED Controller]
[Occupancy]   →
```

### Expressive Instrument

Create nuanced musical control:

```
[Pressure Sensors] → [Regressor] → [Synthesis Parameters]
[Tilt Sensors]     →                      ↓
[Proximity]        →              [Multi-dimensional Control]
```

## Advanced Mapping Techniques

### Multi-dimensional Spaces

Create complex mappings with multiple inputs and outputs:

**Input Space**: `[x, y, pressure, tilt]`
**Output Space**: `[volume, pitch, timbre, reverb, delay]`

This creates a 4D → 5D mapping for rich expressive control.

### Temporal Features

Include time-based features:

```
[Current Values] → [Feature Vector] → [Regressor] → [Predicted Next Values]
[Rate of Change] →
[Acceleration]   →
[History Window] →
```

### Hierarchical Mapping

Use multiple regressors for different aspects:

```
[Gesture Data] → [Regressor 1] → [Musical Structure]
               → [Regressor 2] → [Timbral Control]  
               → [Regressor 3] → [Spatial Position]
```

## Training Strategies

### Sparse Training

Efficiently cover the input space:
1. **Corner Points**: Train at extremes first
2. **Grid Sampling**: Regular samples across space
3. **Important Regions**: More points where behavior changes rapidly
4. **Edge Cases**: Handle boundary conditions

### Iterative Refinement

Improve the mapping over time:
1. **Initial Training**: Basic mapping with key points
2. **Test and Evaluate**: Find areas needing improvement
3. **Targeted Collection**: Add examples where needed
4. **Retrain**: Update model with new data

### Quality Control

Ensure good training data:
- **Consistency**: Similar inputs should have similar outputs
- **Coverage**: Sample across the full input range
- **Smoothness**: Avoid sudden jumps in output values
- **Validation**: Test with holdout data

## Performance Optimization

### Real-time Considerations

For live performance:
- **Latency**: Neural networks add minimal latency
- **Update Rate**: Match prediction rate to control needs
- **Stability**: Ensure smooth outputs during rapid input changes

### Data Management

Efficient training:
- **Dataset Size**: More data generally improves quality
- **Memory Usage**: Large datasets consume more memory
- **Training Time**: Neural networks take longer to train
- **Model Storage**: Save trained models for reuse

## Integration Examples

### Interactive Art Installation

```
[Visitor Position] → [Regressor] → [Ambience Parameters]
[Movement Speed]   →                    ↓
[Group Size]       →              [Audio Layers]
[Time of Day]      →              [Visual Intensity]
                                  [Color Temperature]
```

### Adaptive Music System

```
[Audio Analysis] → [Regressor] → [Generative Parameters]
[User Behavior]  →                     ↓
[Context Data]   →              [Melody Complexity]
                                [Harmonic Density]
                                [Rhythmic Variation]
```

### Responsive Architecture

```
[Environmental Sensors] → [Regressor] → [Building Response]
[Occupancy Patterns]    →                     ↓
[Energy Usage]          →              [Lighting Levels]
[External Conditions]   →              [Ventilation Rate]
                                      [Space Configuration]
```

## Best Practices

### Data Collection
1. **Plan Your Space**: Map out input/output relationships beforehand
2. **Systematic Sampling**: Use structured approaches to cover space
3. **Test As You Go**: Validate mappings during collection
4. **Document Examples**: Keep notes on training points

### Model Selection
1. **Start Simple**: Try linear regression first
2. **Match Complexity**: Use neural networks for complex mappings
3. **Validate Performance**: Test on unseen data
4. **Consider Interpretability**: Linear models are easier to understand

### Live Performance
1. **Pre-train Models**: Don't train during performance
2. **Save/Load States**: Preserve successful mappings
3. **Backup Plans**: Have fallback controls
4. **Monitor Outputs**: Watch for unexpected behavior

## Troubleshooting

### Poor Predictions
- **Insufficient Data**: Add more training examples
- **Wrong Algorithm**: Try neural network for complex mappings
- **Inconsistent Training**: Check for contradictory examples
- **Feature Engineering**: Consider different input representations

### Unstable Outputs
- **Noisy Inputs**: Add input smoothing/filtering
- **Overfitting**: Reduce model complexity or add more data
- **Boundary Effects**: Train at input space boundaries
- **Scaling Issues**: Normalize inputs and outputs

### Performance Issues
- **Slow Prediction**: Use simpler algorithm or smaller network
- **Training Too Slow**: Reduce dataset size or network complexity
- **Memory Problems**: Limit training data size
- **Update Rate**: Reduce prediction frequency if needed

## Advanced Features

### Cross-Validation

Validate model performance:
1. Split data into training and testing sets
2. Train on training data
3. Evaluate on test data
4. Monitor generalization performance

### Model Comparison

Compare different approaches:
```
[Same Data] → [Neural Network] → [Performance Metrics]
           → [Linear Model]    →
           → [Polynomial]      →
```

### Ensemble Methods

Combine multiple regressors:
```
[Input] → [Regressor 1] → [Weighted Average] → [Final Prediction]
       → [Regressor 2] →
       → [Regressor 3] →
```

## Related Processes

- [Classifier](/processes/classifier.html) - For discrete category prediction
- [Interpolator](/processes/interpolator.html) - Simple linear interpolation
- [Mapping](/processes/mapping.html) - Basic parameter mapping
- [Analysis](/processes/analysis.html) - Feature extraction