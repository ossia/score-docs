---
layout: default

title: Compute Shaders
description: "Using compute shaders in the ossia score graphics pipeline"

parent: Processes
grand_parent: Reference

permalink: /processes/compute-shaders.html
---

# CSF Shaders

![Shader]({{ site.img }}/reference/processes/compute-shader.gif "Shader Example")

The compute shader process allow you to add and [[Live coding|live-code]] your own shader to an image or video.
A shader is a visual effect or generator program, which is processed with the graphics card for maximum performance.

Compute shaders are written with a variation of the [Interactive Shader Format (ISF)](https://isf.video), using GLSL.
A lot of nice shaders are already provided as part of the [[library|user library]], courtesy of Vidvox.

They can be drag'n'dropped from the library, or from the explorer ; controls and inputs will be created automatically.

## Writing a compute shader

The rules are similar to ISF shaders, but the data types are different, and more precision is needed due to the advanced flexibility of the compute pipeline.

The main differences are: 

- We are in a compute shader: unlike vertex or fragment shaders, no input or output are predefined.
It is up to the user to define the resources that the shader is going to operate upon.

- The JSON header must contain the key: 

```json
"MODE": "COMPUTE_SHADER",
```

- The `"IMAGE"` type which creates a texture in ISF and VSA, creates an image in compute shaders. Use the `"TEXTURE"` type to create a sampled texture accessible with `textureLod(...)` instead of an image accessible with `imageLoad` and `imageStore`.
- It is possible to refer to the width and height of another image in the JSON header with the `$WIDTH_otherImageName` and `$HEIGHT_otherImageName` macros (and, like ISF, use them as part of normal math formulas and expressions).
- `"PASSES"` are mandatory as they define how the compute shader is going to be invoked. At least one pass is necessary.

The pass syntax is slightly different from the ISF one as it needs to bring data relevant to compute shaders:

* The shader's local size
* How many workgroups are used

For instance: assuming `outputImage` is 1020 x 770 pixels.

Then:

```json
{
    "LOCAL_SIZE": [16, 16, 1],
    "EXECUTION_MODEL":  { "TYPE": "MANUAL", "WORKGROUPS": [64, 1, 1] }
}
```

will translate to:

```
layout(local_size_x = 16, local_size_y = 16, local_size_z = 1​) in;  

void glDispatchCompute(64, 1, 1);
```

```json
{
    "LOCAL_SIZE": [16, 16, 1],
    "EXECUTION_MODEL": { "TYPE": "2D_IMAGE", "TARGET": "outputImage" }
}
```

will translate to:

```
layout(local_size_x = 16, local_size_y = 16, local_size_z = 1​) in;  

void glDispatchCompute((1020 + 16 - 1) / 16​, (770 + 16 - 1) / 16, 1); 

e.g.

void glDispatchCompute(64, 49, 1); 
```

which translates into (64 * 16) * (49 * 16) = 1024 * 784 invocations.

## Example

```c
/*{
  "DESCRIPTION": "Adjusts image brightness using compute shader",
  "CREDIT": "ossia score", 
  "ISFVSN": "2.0",
  "MODE": "COMPUTE_SHADER",
  "CATEGORIES": ["COLOR"],
  "RESOURCES": [
    {
      "NAME": "inputImage",
      "TYPE": "IMAGE",
      "ACCESS": "read_only",
      "FORMAT": "RGBA8"
    },
    {
      "NAME": "outputImage",
      "TYPE": "IMAGE", 
      "ACCESS": "write_only",
      "FORMAT": "RGBA8",
      "WIDTH": "$WIDTH_inputImage",
      "HEIGHT": "$HEIGHT_inputImage"
    },
    {
      "NAME": "brightness",
      "TYPE": "float",
      "LABEL": "Brightness",
      "DEFAULT": 1.0,
      "MIN": 0.0,
      "MAX": 2.0
    },
    {
      "NAME": "contrast", 
      "TYPE": "float",
      "LABEL": "Contrast",
      "DEFAULT": 1.0,
      "MIN": 0.0,
      "MAX": 2.0
    },
    {
      "NAME": "applyEffect",
      "TYPE": "bool",
      "LABEL": "Apply Effect",
      "DEFAULT": true
    }
  ],
  "PASSES": [{
    "LOCAL_SIZE": [16, 16, 1],
    "EXECUTION_MODEL": { "TYPE": "2D_IMAGE", "TARGET": "outputImage" }
  }]
}*/

void main() {
    ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
    
    vec4 color = imageLoad(inputImage, coord);
    
    if (applyEffect) {
        // Apply brightness and contrast
        color.rgb = (color.rgb - 0.5) * contrast + 0.5;
        color.rgb *= brightness;
        color.rgb = clamp(color.rgb, 0.0, 1.0);
    }
    
    imageStore(outputImage, coord, color);
}
```



## Related Processes

- [[ISF Shader]]: Classic fragment shaders.
- [[Model Display]]: To apply the shader onto a 3D surface.
- [[Pixel Utilities|Lightness Computer]]: To convert texture data into pixel arrays, for instance for [[LED design]].

## Try it!

Try it by downloading this [simple example]({{ site.scores }}/reference/processes/compute-shader.score)!
