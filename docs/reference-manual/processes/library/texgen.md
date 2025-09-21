---
layout: default

title: Texture generator
description: "Generating textures from C code"

parent: Processes
grand_parent: Reference

permalink: /processes/texgen.html
---

# C++ Texture generator

This process allows to [[Live coding|live-code]] a texture generator for live visuals.

It is ideal for retro pixel texture effects with a DOS or Amiga vibe.

The code is written in C++ (23). The function `score_rgba` will be called at every frame with 
the pixels of the texture to write into. The texture's data is retained across frames.

Be careful and save often: invalid memory accesses will make score crash as the C++ code is executed directly in-process! 

Since the rendering is done on CPU, it is important to be mindful of the texture size: 
adjust the size of the render target in which the Texgen object is rendering to a smaller fixed size if the rendering is too slow.

# Example
```cpp
extern "C"
void score_rgba(unsigned char* rgba, int width, int height, int t)
{
  int k = 0;
  for(int j = 0; j < height; j++)
  {
    for(int i = 0; i < width; i++)
    {
      rgba[k++] = 255 * t * k / (width * height);
      rgba[k++] = 255 * t * k / (width * height);
      rgba[k++] = 255 * t * k / (width * height);
      rgba[k++] = 255 * t * k / (width * height);
    }
  }
}
```

Here are some examples from the presets that are part of the user library: 

|:-------------------------:|:-------------------------:|
|<img width="256" alt="texgen 1" src="{{ site.img }}/reference/processes/texgen/a.png"> | <img width="256" alt="texgen 2" src="{{ site.img }}/reference/processes/texgen/a.png"> |
|<img width="256" alt="texgen 3" src="{{ site.img }}/reference/processes/texgen/c.png">  |  <img width="256" alt="texgen 4" src="{{ site.img }}/reference/processes/texgen/d.png"> |

## Try it!

Try it by downloading this [simple example!]({{ site.scores }}/reference/processes/texgen.score)