---
layout: default
title: StreamDiffusion
description: "LibreDiffusion image generation, engine export and runtime setup"
parent: Processes
grand_parent: Reference
permalink: /processes/streamdiffusion.html
---

# StreamDiffusion

StreamDiffusion generates images from text or transforms incoming textures. It is the process provided by the [LibreDiffusion add-on](https://github.com/ossia/score-addon-librediffusion), in the AI/Generative category. The [LibreDiffusion runtime](https://github.com/jcelerier/librediffusion) runs the models with CUDA and TensorRT.

## Requirements

Generation requires Linux or Windows, an NVIDIA GPU and driver compatible with the CUDA runtime, the LibreDiffusion shared library, and exported TensorRT engines. The engine's GPU architecture, TensorRT version, precision and dimensions must match the machine running score. Python is used to export engines, not to generate images in score.

The engine instructions below use LibreDiffusion revision `b966e96213c7c8bc905d6799953daaec1b9c7ff4`, used by the score integration described here:

| Component | Version or requirement |
|---|---|
| Python for engine export | 3.12, with dependencies managed by `uv` |
| TensorRT | Standard TensorRT 11.0.0.114 for CUDA 13; not TensorRT-RTX |
| CUDA toolchain | CUDA 13.2, as used by the upstream runtime build |
| PyTorch / torchvision | CUDA 13.2 wheels, at least 2.12.0 / 0.27.0, selected by the project's `pyproject.toml` |
| Diffusers | The project's `jcelerier/diffusers` `kvo-cache-0.38` fork; `uv` also installs its IP-Adapter fork |
| Runtime library | `liblibrediffusion.so` on Linux or `librediffusion.dll` on Windows, plus its CUDA and TensorRT shared-library dependencies |

Use the dependencies from the same LibreDiffusion revision for export and playback. Newer upstream revisions can pin a different TensorRT version; for example, the current upstream `pyproject.toml` pins 11.2.1.2. By default, TensorRT engines require the version that built them.

## Build and load the runtime

score loads LibreDiffusion dynamically. Building the score add-on does not build or install the CUDA runtime library.

For a Linux source build, install CMake 3.23 or later, Ninja, a C++23 compiler, Rust/Cargo, Boost 1.83 or later, the CUDA toolkit and the matching TensorRT SDK. The upstream Linux CI uses GCC 13 and Boost 1.86. Set `TRT_ROOT` to the extracted TensorRT SDK directory, containing `include` and `lib`:

```bash
git clone --recursive https://github.com/jcelerier/librediffusion.git
cd librediffusion
git checkout b966e96213c7c8bc905d6799953daaec1b9c7ff4
git submodule update --init --recursive

export TRT_ROOT="$HOME/TensorRT-11.0.0.114"
export PATH="/usr/local/cuda/bin:$PATH"
export CUDACXX=/usr/local/cuda/bin/nvcc

cmake -S . -B build -G Ninja \
  -DCMAKE_BUILD_TYPE=Release \
  -DTENSORRT_RTX=OFF \
  -DTENSORRT_INCLUDE_DIR="$TRT_ROOT/include" \
  -DTENSORRT_LIB_DIR="$TRT_ROOT/lib"
cmake --build build --target librediffusion --parallel
```

If Boost is outside the compiler's include path, add `-DBOOST_INCLUDE_DIR=/path/to/boost`. The build produces `build/liblibrediffusion.so` and includes kernels for the CUDA architectures supported by the toolkit.

The runtime links to TensorRT (`libnvinfer`), CUDA NPP (`libnppig`), cuRAND (`libcurand`) and their dependencies. Make those libraries and LibreDiffusion visible to the dynamic loader before starting score:

```bash
export LD_LIBRARY_PATH="$PWD/build:$TRT_ROOT/lib:/usr/local/cuda/lib64${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
ldd build/liblibrediffusion.so
ossia-score
```

`ldd` should resolve every dependency. Keep the NVIDIA driver installed on the host. On Windows, put `librediffusion.dll` beside `ossia-score.exe` or in a directory on `PATH`, and add the matching TensorRT and CUDA DLL directories to `PATH` before starting score. The [upstream build workflow](https://github.com/jcelerier/librediffusion/blob/main/.github/workflows/ci.yml) contains the runtime's platform build recipes; it is separate from the score application build.

### Runtime distribution

The score add-on and the LibreDiffusion runtime are separate binaries. The current score build rules include the add-on on Windows and Linux but do not install `liblibrediffusion.so` or `librediffusion.dll`. The [upstream LibreDiffusion release workflow](https://github.com/jcelerier/librediffusion/blob/main/.github/workflows/ci.yml) is configured to bundle the library and Python export tools in platform ZIP files on a version tag. The published [v1.0.0 release](https://github.com/jcelerier/librediffusion/releases/tag/v1.0.0) currently has no binary assets. Use a matching source build until a runtime bundle is published.

## Build model engines

From the LibreDiffusion checkout above, install the export environment and convert a model:

```bash
uv sync --python 3.12
uv run python train-lora.py \
  --type sd15 --model stabilityai/sd-turbo \
  --min-batch 1 --max-batch 1 --opt-batch 1 \
  --min-resolution 512 --max-resolution 512 \
  --opt-width 512 --opt-height 512 \
  --output engines/sd-turbo
```

Despite its name, `train-lora.py` exports pretrained models to TensorRT; this command does not train a LoRA. It downloads the model, exports intermediate ONNX files and builds the engine directory. For restricted Hugging Face models, accept the model's terms and authenticate with `uv run hf auth login` first.

For SDXL Turbo at 1024 × 1024:

```bash
uv run python train-lora.py \
  --type sdxl --model stabilityai/sdxl-turbo \
  --min-batch 1 --max-batch 1 --opt-batch 1 \
  --min-resolution 1024 --max-resolution 1024 \
  --opt-width 1024 --opt-height 1024 \
  --output engines/sdxl-turbo
```

Keep the complete output directory, including `bundle.json`. SD bundles contain `unet.engine`, `vae_encoder.engine`, `vae_decoder.engine` and `clip.engine`; SDXL also needs `clip2.engine`. Select this directory in score's Engines control, not the original checkpoint or the intermediate ONNX directory.

The commands above make fixed-resolution, batch-one engines for one-step playback. For multi-step models, export a batch profile large enough for the selected denoising configuration. Set the minimum, maximum and optimum resolution and batch flags explicitly. Non-square exports also accept `--min-width`, `--max-width`, `--min-height` and `--max-height`.

By default, engines target the build GPU. `--hw-compat ampere_plus` requests hardware compatibility across supported Ampere-and-newer GPUs. `--version-compat` embeds a lean runtime for loading on newer TensorRT versions; leave `--exclude-lean-runtime` off, since the LibreDiffusion loader does not supply an external lean runtime. These options trade some performance and file size for portability.

### Models and workflows

| Export | Workflow in score |
|---|---|
| `--type sd15 --model stabilityai/sd-turbo` | `SDTURBO_TXT2IMG` or `SDTURBO_IMG2IMG` |
| `--type sd15` with an SD-family model, such as LCM DreamShaper | `SD_TXT2IMG` or `SD_IMG2IMG` |
| `--type sdxl` with SDXL Turbo, or an accelerated SDXL model | `SDXL_TXT2IMG` or `SDXL_IMG2IMG` |
| SD-family export with `--controlnet REPO` | `SD_TXT2IMG_CONTROLNET` or `SD_IMG2IMG_CONTROLNET` |
| SDXL export with `--controlnet REPO` | `SDXL_TXT2IMG_CONTROLNET` or `SDXL_IMG2IMG_CONTROLNET` |
| SD1.5 export with `--ipadapter CHECKPOINT` and image-encoder engines | `SD_TXT2IMG_IPADAPTER` or `SD_IMG2IMG_IPADAPTER` |
| SD1.5 export with `--v2v` or `--v2v-inject` | `V2V_TXT2IMG` or `V2V_IMG2IMG` |
| `--type img2img-turbo --model edge_to_image` | `IMG2IMG_TURBO` |
| `--type klein --model /path/to/FLUX.2-klein-4B` | `FLUX2_KLEIN_TXT2IMG`, `FLUX2_KLEIN_IMG2IMG` or `FLUX2_KLEIN_INPAINT` |

The [upstream recipes](https://github.com/jcelerier/librediffusion#engine-build-recipes-validated) cover LCM, Hyper-SD, SDXL-Lightning, Segmind-VegaRT, SDXS and LoRA exports. score uses built-in scheduler tables: LCM DreamShaper for the SD/V2V workflows, SD-turbo for SDTURBO and SDXL-turbo for SDXL. Select timestep indices and batch profiles appropriate to the model rather than assuming every exported checkpoint uses the same settings.

### LoRA and conditioning

Add `-l REPO`, `-l "REPO|file.safetensors"` or a local LoRA path to an SD/SDXL export. Repeat `-l` to combine LoRAs. Ordinary LoRAs are fused into the exported weights. The `:runtime` suffix, for example `-l "/path/to/style.safetensors:runtime"`, exports an adjustable LoRA; score's LoRA scale applies to all its runtime LoRA slots. Runtime LoRA export cannot be combined with `--fp8`.

For ControlNet, add `--controlnet REPO`. This builds `controlnet.engine` and a matching control-aware UNet. The ControlNet architecture must match the base model; SDXS, for example, needs its native sketch ControlNet rather than a standard SD1.5 ControlNet. Feed the expected edge, depth or pose map into Control / Style; preprocessing happens upstream of this process.

For IP-Adapter, first download `h94/IP-Adapter` to the Hugging Face cache with `uv run hf download h94/IP-Adapter`. Export the SD1.5 model with `--ipadapter` pointing to its `models/ip-adapter_sd15.bin`. Then add the image-conditioning engines to the same bundle:

```bash
uv run python tools/export_ipadapter_image_encoder.py \
  --type sd15 --out engines/sd15-ipadapter
```

Use the same checkpoint for both exports. The extra files are `clip_image_encoder.engine` and `ip_image_proj.engine`. Connect a style image to Control / Style. The exporter also has an SDXL IP-Adapter path, but the score process currently exposes only the SD1.5 IP-Adapter workflows.

### IMG2IMG_TURBO and FLUX.2-klein

`IMG2IMG_TURBO` uses GaParmar's one-step image-translation models with a skip-connected VAE. It is distinct from `SDTURBO_IMG2IMG`. Export with `--type img2img-turbo`, a pretrained name such as `edge_to_image` or a local `.pkl`, and the required fixed resolution. The exporter supplies the UNet, both VAE engines and CLIP.

For FLUX.2-klein, download the complete model first and pass its local directory:

```bash
uv run hf download black-forest-labs/FLUX.2-klein-4B --local-dir models/FLUX.2-klein-4B
uv run python train-lora.py \
  --type klein --model models/FLUX.2-klein-4B \
  --klein-quality both --output engines/klein
```

The Klein export script builds the transformer, Qwen text encoder and VAE engines, and stages tokenizer and normalization files. Keep the whole bundle: `transformer_bf16.plan`, `transformer_fp8_calib.plan`, `qwen3_encoder_bf16.plan`, `vae_encoder_bf16.plan`, `vae_decoder_bf16.plan`, `tokenizer.json`, `bn_mean.bin` and `bn_std.bin`. `--klein-quality quality` skips the FP8 transformer export. Select the corresponding Klein quality in score. The exporter also builds `rife_ifnet_fp16.plan` for output-frame interpolation.

## First connection in score

1. Add StreamDiffusion from AI/Generative.
2. Select the Workflow for the exported model and set Engines to the complete engine directory.
3. For the SD-turbo example above, set Resolution to 512 × 512 and Timesteps to `15`. For the SDXL Turbo example, use 1024 × 1024 and one timestep, such as `15`.
4. Enter Prompt +. For image-to-image, connect an image, video or shader texture to In.
5. Connect Out to a graphics output or another texture process, then play the interval.

## Ports

| Port | Use |
|---|---|
| In | Source texture for image-to-image workflows. |
| Control / Style | ControlNet map, IP-Adapter style image, or FLUX.2-klein inpainting mask. |
| Embedding | Float-array text embedding override for `IMG2IMG_TURBO`. |
| Trigger | Exposed impulse input; currently does not gate generation. |
| Out | Generated texture. |

FLUX.2-klein inpainting regenerates white mask areas and retains black areas. For `IMG2IMG_TURBO`, an Embedding array of the engine's required size takes precedence over Prompt +. Otherwise `clip.engine` encodes the prompt. Image dimensions and embedding length are read from the engine.

## Generation controls

| Control | Meaning |
|---|---|
| Prompt + / Prompt - | Positive and negative prompt text. Negative prompts are used by the SD guidance modes; SD-turbo and SDXL disable classifier-free guidance in this integration. |
| Seed | Random seed. |
| Guidance / Guidance type | SD guidance strength and mode: None, Self, Full or Initialize. |
| Timesteps | Scheduler indices for SD-family workflows, or FlowMatch sigma values for Klein. |
| Resolution | Requested width and height, within the exported engine profile. `IMG2IMG_TURBO` uses the engine's dimensions. |
| Add noise / Denoising batch | Noise and denoising-batch configuration for the SD pipeline. |
| Delta | Guidance-related delta parameter for the SD pipeline. |
| Feed prev. input / Feed prev. output | Blend weights for previous frames in the ordinary image-to-image input path. |
| ControlNet scale / IP-Adapter scale | Conditioning strength for the corresponding workflow. |
| LoRA scale | Strength of LoRAs exported with runtime scaling. |
| Klein quality | Quality selects the BF16 transformer; Speed selects the calibrated FP8 transformer. |
| Interpolation exp | RIFE frame interpolation: 0 disables it; 1, 2 and 3 request 2×, 4× and 8× output frames. Requires the RIFE engine on a supported execution path. |
| Async | Run diffusion on a worker for plain SD/SD-turbo/SDXL and Klein workflows. ControlNet and IP-Adapter remain synchronous. |
| Async pacing | Smooth presents queued frames in order, Fresh favors recent frames with a blended transition, and LowLatency presents the latest available frame. |
| Manual mode | Currently does not gate generation; Trigger and Manual mode do not provide one-image-per-trigger operation. |

When both feedback weights are nonzero, previous-input blending takes precedence; previous-output blending is limited to the remaining weight. The rest comes from the current input.

### Timesteps

For SD-family workflows, enter comma- or whitespace-separated scheduler indices, such as `15, 25`. These select two entries from a 50-entry table, not a scalar step count. Indices are bounded to 0–49. An empty or unparseable list prevents setup. SD-turbo uses only the first entry; multi-step SD/SDXL configurations need matching engine batch profiles.

FLUX.2-klein instead accepts comma-separated FlowMatch sigma values in `(0, 1]`, ordered from high to low. An unusable sigma list, including the SD default `15, 25`, selects the model's natural schedule. `IMG2IMG_TURBO` uses its one-step translation path rather than this scheduler control.

## Troubleshooting

For an empty or unchanged output, check runtime availability, engine/workflow compatibility, supported dimensions, the scheduler field and required input textures or embeddings before changing prompts. Model-loading and generation failures are reported by the runtime; a texture cable alone cannot supply the missing engines. Start without feedback or asynchronous interpolation to isolate the basic model/input/output path.
