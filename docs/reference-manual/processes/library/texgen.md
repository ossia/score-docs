---
layout: default

title: Texture generator
description: "Generating textures from C code"

parent: Processes
grand_parent: Reference

permalink: /processes/texgen.html
---

# Texture generator

This process allows to [[Live coding|live-code]] a texture generator for live visuals.

The code is written in C++ (20). The function `score_rgba` will be called at every frame with 
the pixels of the texture to write into. The texture's data is retained across frames.

Be careful and save often: invalid memory accesses will make score crash ! 

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