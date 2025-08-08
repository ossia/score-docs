---
layout: default

title: HDF5 Support
description: "HDF5 data processing and visualization"

parent: Processes
grand_parent: Reference

permalink: /processes/hdf5.html
---
# HDF5 Data Processing

![HDF5 Support]({{ site.img }}/reference/processes/hdf5.png "HDF5 Support") 

HDF5 (Hierarchical Data Format version 5) is a powerful file format designed for storing and managing large datasets. Ossia score provides comprehensive HDF5 support through specialized processes that can read time series data, textures, and complex multi-dimensional datasets.

## Overview

The HDF5 addon enables ossia score to work with scientific datasets, sensor recordings, simulation outputs, and any hierarchically organized data. This makes score particularly powerful for data-driven art, scientific visualization, and large-scale interactive installations.

## HDF5 Reader (1D) {#1d-reader}

The 1D HDF5 Reader process extracts time series and scalar data from HDF5 files, making it ideal for sensor data playback and scientific dataset visualization.

### Parameters

#### HDF5 File
**Type**: File input  
**Extensions**: `*.h5`

Select the HDF5 file containing your datasets. The file is memory-mapped for efficient access to large datasets.

#### Path
**Type**: Text input  
**Default**: `/`

Specify the path to the dataset within the HDF5 file hierarchy. Uses standard HDF5 path syntax:
- `/` - Root group
- `/dataset_name` - Dataset in root
- `/group/subgroup/dataset` - Nested dataset path

#### Percentage
**Type**: Horizontal slider (0.0 - 1.0)  
**Default**: 0.0

Controls playback position through the dataset as a percentage of total length. This enables scrubbing through time series data.

### Output

#### Out
**Type**: ossia::value  
**Content**: Current data value at the specified percentage

Returns the data value at the current playback position. Automatically handles different data types (integers, floats, strings).

### Usage Examples

#### Sensor Data Playback
```
HDF5 Reader (/sensors/temperature) → Data Visualization
```

Read temperature sensor recordings and visualize them in real-time.

#### Scientific Dataset Analysis
```
HDF5 Reader (/experiment/results/trial_1) → Statistical Analysis → OSC Output
```

Extract experimental results and send to analysis software via OSC.

#### Environmental Monitoring
```
HDF5 Reader (/weather/wind_speed) → Conditional Logic → Wind Effect Trigger
```

Use weather data to trigger environmental effects in an installation.

## HDF5 Texture Reader {#texture-reader}

The HDF5 Texture Reader process extracts image and texture data from HDF5 files, enabling visualization of 2D datasets, medical imaging data, and generated imagery.

### Parameters

#### HDF5 File
**Type**: File input  
**Extensions**: `*.h5`

Select the HDF5 file containing texture/image datasets.

#### Path
**Type**: Text input  
**Default**: `/`

Path to the image dataset within the HDF5 file. The dataset should contain 2D or 3D arrays representing image data.

#### Percentage
**Type**: Horizontal slider (0.0 - 1.0)  
**Default**: 0.0

For image sequences or 3D volumes, controls which frame/slice to display.

### Output

#### Out
**Type**: RGBA Texture  
**Content**: Image data as GPU texture

Provides the extracted image as a GPU-ready texture for immediate use in visual processes.

### Usage Examples

#### Medical Imaging
```
HDF5 Texture Reader (/mri/brain_scan) → ISF Shader → 3D Visualization
```

Display MRI brain scans with custom visualization shaders.

#### Scientific Visualization
```
HDF5 Texture Reader (/simulation/heat_map) → Color Mapping → Display
```

Visualize simulation results as heat maps or false-color images.

#### Generative Art
```
HDF5 Texture Reader (/generated/patterns) → Texture Effects → Output
```

Use procedurally generated textures stored in HDF5 format.

## Technical Details

### HDF5 Features Supported

#### Data Types
- **Integers**: 8, 16, 32, 64-bit signed and unsigned
- **Floating Point**: 32 and 64-bit IEEE 754
- **Strings**: Variable and fixed-length strings
- **Arrays**: Multi-dimensional arrays of any supported type

#### File Structure
- **Groups**: Hierarchical organization like directories
- **Datasets**: Arrays of homogeneous data
- **Attributes**: Metadata attached to groups or datasets
- **Links**: References to other objects in the file

#### Performance Features
- **Memory Mapping**: Efficient access to large files
- **Chunking**: Optimized storage for partial reads
- **Compression**: Built-in compression support (gzip, szip, LZF)
- **Parallel Access**: Thread-safe reading from multiple processes

### Data Access Patterns

#### Time Series Access
For 1D time series data:
```
percentage = 0.0 → first sample
percentage = 0.5 → middle sample  
percentage = 1.0 → last sample
```

#### Image Sequence Access
For 3D image stacks:
```
percentage = 0.0 → first image
percentage = 0.5 → middle image
percentage = 1.0 → last image
```

#### Multi-dimensional Indexing
Use ossia's destination indexing syntax for complex datasets:
```
/dataset[0][5][2] → specific element access
/dataset[0:10][5] → slice access
```

## Integration Workflows

### Scientific Data Pipeline
```
Data Collection → HDF5 Export → HDF5 Reader → Analysis → Visualization
```

### Real-time Monitoring
```
Sensor Array → HDF5 Writer → HDF5 Reader → Dashboard → Alerts
```

### Artistic Interpretation
```
Scientific Data → HDF5 Reader → Data Sonification → Audio Output
Mathematical Model → HDF5 Texture Reader → Visual Art → Display
```

## Advanced Usage

### Dataset Exploration
Use HDF5 tools to explore file structure:
```bash
h5dump -n file.h5        # List all objects
h5ls -r file.h5          # Recursive listing
h5stat file.h5           # File statistics
```

### Custom Data Preparation
```python
import h5py
import numpy as np

# Create time series dataset
with h5py.File('timeseries.h5', 'w') as f:
    data = np.sin(np.linspace(0, 10*np.pi, 1000))
    f.create_dataset('/sensor/temperature', data=data)
    
# Create image sequence
with h5py.File('images.h5', 'w') as f:
    frames = np.random.rand(100, 480, 640, 3)  # 100 frames
    f.create_dataset('/animation/frames', data=frames)
```

### Performance Optimization
- **Chunking**: Store data in optimal chunk sizes for your access patterns
- **Compression**: Use appropriate compression for your data type
- **Memory**: Monitor RAM usage with very large datasets
- **Caching**: HDF5 automatically caches frequently accessed data

## Best Practices

### File Organization
- Use descriptive group and dataset names
- Include metadata as attributes
- Document units and data types
- Use consistent naming conventions

### Performance
- Choose appropriate chunk sizes (typically 10KB - 1MB)
- Enable compression for large datasets
- Use memory mapping for read-only access
- Profile access patterns for optimization

### Data Integrity
- Validate data ranges and types
- Include checksums when available
- Use HDF5's built-in error detection
- Backup important datasets

## Related Processes

- **Data Processing**: Statistical analysis of HDF5 datasets
- **Visualization**: Real-time plotting and graphing
- **Export**: Converting ossia data to HDF5 format
- **Network**: Streaming HDF5 data over protocols