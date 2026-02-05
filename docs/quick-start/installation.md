---
layout: default

title: Installation
description: "How to download and install ossia score"

parent: Quick start
nav_order: -1

permalink: /quick-start/installation.html
---

# Installing *score*

*ossia score* is available for Windows, macOS, Linux including embedded ARM systems, and FreeBSD. This page covers how to download and install *score* on your system.

## System Requirements

**Minimum specifications:**
- 64-bit operating system
- 800 MHz CPU
- 512 MB RAM
- GPU supporting OpenGL 3.2, Vulkan, Direct3D 11, or Metal

For video processing and complex scenarios, a more powerful system is recommended.

---

## Windows

### Direct Download

Download the installer directly:

[Download ossia score for Windows](https://ossia.io/score/download.html){:target="_blank"}.

**Requirements:**
- Windows 10 or Windows 11
- For the OSCQuery feature, install [Bonjour Print Services](https://support.apple.com/kb/DL999){:target="_blank"}

### Alternative Installation Methods

**WinGet:**
```
winget install ossia.score
```

**MSYS2:**
```
pacman -S mingw-w64-x86_64-ossia-score
```

---

## macOS

### Direct Download

[Download ossia score for macOS](https://ossia.io/score/download.html){:target="_blank"}.

Choose the appropriate version for your Mac:

- **Apple Silicon (M1/M2/M3):** works on any M1 or more recent Mac.
- **Intel:** Download `ossia.score-X.X.X-macOS-Intel.dmg`: Requires macOS 10.15 (Catalina) or later

### Installation Steps

1. Download the `.dmg` file for your Mac
2. Open the downloaded file
3. Drag *score* to your Applications folder

### Homebrew

```
brew install --cask ossia-score
```

> On macOS, some VST plug-ins and virtual cameras may require additional permissions. See [[Troubleshooting]] for details.

---

## Linux (x86_64)

### AppImage (Recommended)

[Download ossia score for Linux](https://ossia.io/score/download.html){:target="_blank"}.

AppImages work on most Linux distributions without installation:

1. Download the AppImage.
2. Make it executable: either through your desktop environment (right-click -> properties -> permissions -> "Allow executing file as program" on KDE Plasma for instance), or through command-line.

   ```bash
   chmod +x ossia.score-*.AppImage
   ```

3. Run it:
   ```bash
   ./ossia.score-*.AppImage
   ```

[Download from GitHub Releases](https://github.com/ossia/score/releases/latest){:target="_blank"}

### Flatpak

*score* is available on Flathub:

```bash
flatpak install flathub io.ossia.score
```

Then run with:
```bash
flatpak run io.ossia.score
```

### Arch Linux (AUR)

```bash
yay -S ossia-score
```

Or using another AUR helper of your choice.

### Nix

*score* is available in nixpkgs:

```bash
nix-shell -p ossia-score
```

### FreeBSD

Available through the ports system.

> **Audio on Linux:** For best performance, use the JACK or PipeWire audio backend. See [[Troubleshooting]] if you experience audio issues.

---

## Raspberry Pi, Linux AArch64 and Embedded Systems

[Download ossia score for Raspberry Pi](https://ossia.io/score/download.html){:target="_blank"}.

*score* supports ARM-based systems including Raspberry Pi:

- Download the **AArch64 AppImage** from the download page
- Flatpak is also available for ARM systems
- If you use Asahi Linux, this release is also what you want to use.

For headless or embedded deployments, see the [[Embedded]] documentation.

---

## Building from Source

For developers who want to build *score* from source:

- Source archives (`.tar.xz`) are available on the [releases page](https://github.com/ossia/score/releases){:target="_blank"}
- See the [[Building from source]] documentation for detailed instructions

---

## Verifying Your Installation

After installation, launch *score*. You should see the main window with:

- The `Device explorer` panel on the left
- The scenario editor in the center
- The `Object inspector` on the right

If *score* doesn't start or you encounter issues, check the [[Troubleshooting]] page.

## Next Steps

Now that *score* is installed, continue with the Quick Start guide:

- [[What is score ?]] - Understand the core concepts
- [[Interface overview]] - Learn your way around the interface
- [[Working with devices]] - Connect to external software and hardware
