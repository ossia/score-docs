---
layout: default

title: Vertex Shader Art
description: "Using Vertex Shader Art in the ossia score graphics pipeline"

parent: Processes
grand_parent: Reference

permalink: /processes/vertex-shader-art.html
---

# Vertex Shader Art

![Vertex Shader Art]({{ site.img }}/reference/processes/vsa.gif "VSA shader")

The VSA shader process allow you to add and [[Live coding|live-code]] your own shader to an image or video.
A shader is a visual effect or generator program, which is processed with the graphics card for maximum performance.

They are based on the [Vertex Shader Art](https://www.vertexshaderart.com) spec.

Unlike traditional [[ISF Shader|ISF shaders]], VSA shaders operate on the vertex shader, while the fragment shader is unchanged.

The goal of a VSA shader is to indicate the position and the color of a given vertice; then, the shader will be invoked for each point specified, which is extremely fast even on small GPUs.

They can be drag'n'dropped from the library, or from the file explorer ; controls and inputs will be created automatically.

## Writing a VSA shader

VSA shaders are very similar to ISF shaders. 
The differences are: 

- We are in a vertex shader instead of a fragment shader: we operate on vertices, not on pixels.
- The JSON header must contain the key: 

```json
"MODE": "VERTEX_SHADER_ART",
```

- The goal of the shader is to write a value to the following variables: 

```glsl
gl_Position = vec4(...); // Position of the vertice
gl_PointSize = 1./pos.z; // If using point rendering, size of a given point
v_color = vec4(abs(ofs/max(length(ofs),1e-9))*.3+.7,1); // Color with which the vertice will be displayed
```

## Example


```c
/*{
  "DESCRIPTION": "point cloud vs spheres rmx",
  "CREDIT": "macro (ported from https://www.vertexshaderart.com/art/nKrw8457n4cFANsJu)",
  "ISFVSN": "2",
  "MODE": "VERTEX_SHADER_ART",
  "CATEGORIES": [
    "Geometry",
    "Math",
    "Animated",
    "Particles",
    "Nature"
  ],
  "POINT_COUNT": 99999,
  "PRIMITIVE_MODE": "POINTS",
  "LINE_SIZE": "NATIVE",
  "BACKGROUND_COLOR": [
    0,
    0,
    0,
    1
  ],
  "INPUTS": [],
  "METADATA": {
    "ORIGINAL_VIEWS": 50,
    "ORIGINAL_DATE": {
      "$date": 1510363843048
    }
  }
}*/

/*
   point cloud vs spheres by Kabuto

   Recreated this well-known demo effect. A bit tricky without being able to store history for points, so it's just computed again and again for each render pass
*/

#define RATE 7.0

vec3 posf2(float t, float i) {
 return vec3(
      sin(t+i*.18293) +
      sin(t*1.311+i) +
      sin(t*1.4+i*1.53) +
      sin(t*1.844+i*.76),
      sin(t+i*.74553+2.1) +
      sin(t*1.311+i*1.1311+2.1) +
      sin(t*1.4+i*1.353-2.1) +
      sin(t*1.84+i*.476-2.1),
      sin(t+i*1.5553-2.1) +
      sin(t*1.311+i*1.1-2.1) +
      sin(t*1.4+i*1.23+2.1) +
      sin(t*1.84+i*.36+2.1)
 )*0.1492;
}

vec3 posf0(float t) { return posf2(t,-1.)*RATE;}
vec3 posf(float t, float i) { return posf2(t*.3,i) + posf0(t);}
vec3 push(float t, float i, vec3 ofs, float lerpEnd) {
  vec3 pos = posf(t,i)+ofs;
  vec3 posf = fract(pos+0.5)-0.5;
  float l = length(posf)*2.;
  return (- posf + posf/l)*(1.-smoothstep(lerpEnd,1.,l));
}

void main() {
  // more or less random movement
  float t = time*.20;
  float i = vertexId+sin(vertexId)*100.0;

  vec3 pos = posf(t,i);
  vec3 ofs = vec3(0);
  for (float f = -10.; f < 0.; f++) {
   ofs += push(t+f*.105,i,ofs,2.-exp(-f*.1));
  }
  ofs += push(t,i,ofs,.999);

  pos -= posf0(t);

  pos += ofs;

  pos.yz *= mat2(.8,.6,-.6,.8);
  pos.xz *= mat2(.8,.6,-.6,.8);

  pos *= 1.;

  pos.z += .7;

  pos.xy *= .6/pos.z;

  gl_Position = vec4(pos.x, pos.y*resolution.x/resolution.y, pos.z*.1, 1);
  gl_PointSize = 1./pos.z;

  v_color = vec4(abs(ofs/max(length(ofs),1e-9))*.3+.7,1);
}
```

## Related Processes

- [[ISF Shader]]: Classic ISF fragment shaders.
- [[Compute Shader]]: Similar to ISF and VSA shaders but for compute instead of fragment shaders.
- [[Model Display]]: To apply the shader onto a 3D surface.
- [[Lightness Computer]]: To convert texture data into pixel arrays, for instance for [[LED design]].

## Try it!

Try it by downloading this [simple example]({{ site.scores }}/reference/processes/vertex-shader-art.score)!
Note that the example requires gzdoom to work.