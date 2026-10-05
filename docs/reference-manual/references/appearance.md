---
layout: default

title: Appearance and skins
description: "Customize score's colours, fonts, palette and interface scale"

parent: Reference

permalink: /reference/appearance.html
---

# Appearance and skins

The live skin editor is in **Preferences → User interface → Skin**. A skin changes the editor's appearance, not the colours of your video output.

## Choose and combine skins

Select a preset in **Skin**, or use **Browse...** to open a skin JSON file. Files in the user library's `Skins/` directory also appear in the list.

- **Apply colours** takes the selected skin's drawing colours and widget palette.
- **Apply fonts** takes its font settings.

These switches control loading a preset, not whether manual edits are enabled. For example, choose a colour scheme with only **Apply colours** enabled, then choose a compact font skin with only **Apply fonts** enabled. A colour-only skin has no custom fonts to supply; leave **Apply fonts** off when preserving your typography.

### Readability and accessibility

| Need | Starting points |
| --- | --- |
| A light interface | **Catppuccin Latte**, **Solarized Light** |
| A dark interface | **Default**, **Dracula**, **Nord**, **Tokyo Night**, **Gruvbox Dark** |
| Colour-vision differences | **Protanopia**, **Deuteranopia**, **Tritanopia**, or **Color Blind** |
| Greyscale figures | **IEEE**, whose role colours are neutral greys |
| More room on a small screen | **Small Screen**, **Default 11px**, **Default 12px**, or the **Galmuri** variants |
| Pixel-font typography | **Cozette**, **Departure Mono**, **Ark Pixel**, or **Galmuri** variants |

The colour-vision presets are alternatives to try, not a guarantee of accessibility for every viewer or display. For higher contrast, adjust foreground and background roles together and check selected, disabled and playing states. There is no separate preset named “High Contrast” in the current built-in list. Small-screen presets deliberately reduce text sizes; they are not a substitute for larger text when readability is the priority.

## Edit colours and the widget palette

In **Colours**, select a role and change the colour wheel or **Hex** value. Roles distinguish interface elements rather than assigning one colour to everything: for example, `Background1` and `Background2` are separate from accents such as `Base1`. Other roles cover ports, cables, waveforms and execution feedback.

A skin file can also contain a `palette` object for standard widgets: Qt role names such as `Window`, `WindowText`, `Base`, `Text`, `Button`, `ButtonText`, `Highlight`, `HighlightedText`, `Link` and `LinkVisited`. Optional `inactive` and `disabled` objects specialize those states. This palette is loaded with **Apply colours**; it is not a separate palette editor in the Skin tab. When loading colours, unspecified roles return to built-in values instead of leaking through from the previous skin.

## Edit fonts by role

In **Fonts**, choose a role, then adjust **Family**, **Style**, **Size** (pixels), **Hinting** and **Antialias**. The editable **Preview** lets you try your own text.

| Role | Purpose |
| --- | --- |
| `application` | General widget text and the sizing of many standard widgets |
| `sans`, `sansSmall`, `mono`, `monoSmall` | Shared proportional and monospace drawing fonts |
| `title`, `sectionTitle` | Headings |
| `slider`, `ruler` | Control labels and ruler text |
| `code` | Code-editor text |
| `timecode` | Time display |
| `bold10`, `bold12`, `medium7`, `medium8`, `medium10`, `medium12` | Additional shared drawing roles; the name is not a locked size |

**Hinting** is per role: **Default**, **None**, **Vertical**, or **Full**. Full snaps glyphs to the pixel grid for crisp small text; Vertical preserves the designed horizontal spacing; None leaves outlines unhinted. There is no longer a separate global `FontHinting` preference. Rendering still depends on the font and platform.

For recognized pixel fonts, the editor displays **Pixel font: sharp at … px**. Prefer those grid multiples and try disabling **Antialias** rather than assuming any size will look sharp. A font named in an imported skin need not be installed on another machine; use available families and inspect the preview there.

## Live changes, saving and reset

Edits update the running interface and are saved automatically in application preferences. The effective combination of colours and fonts survives a restart, including edits not exported to a file. **Save as...** exports the current skin as JSON so it can be shared or backed up; this is separate from automatic preference storage.

There is no dedicated reset button in the editor. To restore the built-in appearance, enable both **Apply colours** and **Apply fonts**, then select **Default**. If Default is already selected, first select another preset and then return to Default so the skin is reloaded. To reset just colours or just fonts, enable only that part before switching. Export a copy first if you want to retain your edits.

## Interface scale and vector drawing

In **User interface → Interface**, **Graphical Zoom** scales the interface from 100% to 200%. Builds without live scaling support label it **Graphical Zoom (needs restart)**. This is different from changing a font role or zooming the score's timeline.

Two startup options control drawing of interface graphics where supported:

- `--vector-gui`: use vector rendering where possible, trading speed for cleaner zoomed graphics.
- `--no-vector-gui`: use prerendered pixmaps where possible, trading zoom quality for speed.

These are command-line options, not Skin-tab controls, and are separate from the video renderer's **Graphics API** setting. See [Score preferences]({{ site.baseurl }}/reference/preferences.html) for interface refresh and rendering controls.
