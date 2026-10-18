---
layout: default

title: Texture generator
description: "Generating textures from C code"

parent: Processes
grand_parent: Reference

permalink: /processes/texgen.html
score: /reference/processes/texgen.score
---

<a id="texture-generator"></a>

# C++ Texture generator

This process allows to [[Live coding|live-code]] a texture generator for live visuals.

It is ideal for retro pixel texture effects with a DOS or Amiga vibe.

See the [C++ texture-generator callback reference]({{ site.baseurl }}/reference/languages/cpp.html#texture-generator-callback) for the `score_rgba` signature, pixel layout, frame counter and retained-buffer behavior, and the [runtime requirements]({{ site.baseurl }}/reference/languages/cpp.html#language-and-runtime-requirements) for compiler and SDK availability.

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

Try it by downloading this [simple example!]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}
