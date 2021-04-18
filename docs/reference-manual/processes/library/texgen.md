---
layout: default

title: Texture generator
description: "Generating textures from C code"

parent: Processes
grand_parent: Reference

permalink: /processes/texgen.html
---


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