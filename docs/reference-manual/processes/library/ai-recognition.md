---
layout: default

title: AI Recognition
description: "AI-based recognition tools"

parent: Processes
grand_parent: Reference

permalink: /processes/ai-recognition.html
---
# AI Recognition

![AI Recognition]({{ site.img }}/reference/processes/ai-recognition.png "AI Recognition") 

## How to run ONNX models in score

### 1. Drop an AI model [process](https://ossia.io/score-docs/processes.html) in your timeline

Let’s try with **BlazePose Detector**. It can read from a camera or image input texture, run the model, and output results in real-time.

![BlazePose Process]({{ site.img }}/reference/processes/ai-recognition/blazepose-process.png)

### 2. Download and load model

- BlazePose Fullbody ONNX from [Ailia](https://github.com/axinc-ai/ailia-models/tree/master/pose_estimation/blazepose)  
  [Download](https://storage.googleapis.com/ailia-models/blazepose-fullbody/pose_landmark_full.onnx)

- Yolov8 Pose: [Download](https://huggingface.co/Xenova/yolov8-pose-onnx/resolve/main/yolov8n-pose.onnx?download=true)

- RTMPose: [Download](https://download.openmmlab.com/mmpose/v1/projects/rtmposev1/onnx_sdk/rtmpose-s_simcc-body7_pt-body7-halpe26_700e-256x192-7f134165_20230605.zip)
### 3. Add an Input camera device (or video)

Choose a camera

![Camera input]({{ site.img }}/reference/processes/ai-recognition/input-camera.png)

Alternatively, drag & drop a [video](https://ossia.io/score-docs/quick-start/working-with-video.html) file into score, and connect it to the AI model process.

### 4. Add a "Window" device for output

Adjust the output window size to match your model's output.

![Output window]({{ site.img }}/reference/processes/ai-recognition/output-window.png)

### 5. Play

Add a [trigger](https://ossia.io/score-docs/common-practices/3-out-of-time.html) if you want the process to loop continuously.

![Trigger example]({{ site.img }}/reference/processes/ai-recognition/trigger-play.png)

### 6. Extract keypoints

Each AI model outputs keypoints in a specific format.  
For BlazePose, refer to the [official documentation](https://ai.google.dev/edge/mediapipe/solutions/vision/pose_landmarker#pose_landmarker_model):

![BlazePose Keypoints]({{ site.img }}/reference/processes/ai-recognition/blazepose-keypoints.png)

To extract keypoints like wrist or nose, use the [Object Filter](https://ossia.io/score-docs/processes/object-filter.html) process to filter these fields.

- Left wrist = `.keypoints[15].position[]`
- Right wrist = `.keypoints[16].position[]`
- Nose = `.keypoints[0].position[]`

For other models like [RTMPose](https://github.com/open-mmlab/mmpose/tree/main/projects/rtmpose#26-keypoints), here is the 26-keypoint layout:

![RTMPose keypoints]({{ site.img }}/reference/processes/ai-recognition/rtmpose-keypoints.png)

### 7. Use keypoints

Once keypoints are extracted, you can connect them to any parameter in score for interactive control.

![Use keypoints example]({{ site.img }}/reference/processes/ai-recognition/parameter-mapping.png)

[Download score]({{ site.scores }}/reference/processes/ai-recognition.score)

#### Send to Wekinator (OSC)

You can also send keypoints over OSC to external tools like [Wekinator](http://www.wekinator.org/) for gesture recognition or AI-based interaction.

1. Use an **Object Filter** to extract:
   - left wrist, right wrist, nose (x, y, z) with the following formula : 
   ```
   [ .keypoints[15].position[0]]
   ```

2. Combine them into a 9-value OSC message using the [Array Combinor](https://ossia.io/score-docs/processes/array-utilities.html) process

3. Send the OSC message to `wekinator:/wek/inputs`

![OSC to Wekinator]({{ site.img }}/reference/processes/ai-recognition/output-to-wekinator.png)

This can be used to trigger visuals, audio, shaders, and other cool things!
