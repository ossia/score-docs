---
layout: default

title: Changelog
description: "Release history and changelogs for ossia score"

nav_order: 100
parent: Reference

permalink: /reference/changelog.html
---

# Changelog

This page lists all releases of *ossia score* with links to detailed changelogs on GitHub.

For the current version, see [[What is score ?]]. To download the latest release, visit the [[Installation]] page.

## Documentation maintenance

These changes affect the documentation website, not a score application release:

- Expanded the graphics, scripting, device, audio, browser and project-management references.
- Updated feature descriptions to present released capabilities without development-build qualifiers, retaining platform, dependency and hardware requirements.
- Restored the scripting examples on [Scripting API examples]({{ site.baseurl }}/in-depth/scripting-api/examples.html), including port names, triggers and conditions, and linked the API reference pages together.
- Documented in-process FFmpeg/GStreamer streaming, corrected spatial-audio routing and controls, and clarified nested-interval transport and code-editor placement.
- Clarified the ossia and score SDKs, official Windows toolchains, SDK42's FFmpeg 9.0 dependency, and custom-application templates and CI actions.
- Added missing example pages and corrected archive links. Example pages distinguish native graphics from Qt Quick 3D and list their required media and packages.
- Aligned example categories with asset folders and removed local project snapshots and nested working copies from publication. Process and common-practice walkthroughs remain with their corresponding references.
- Extracted embedded project thumbnails for the example manifest and optional page illustrations. Walkthroughs select images explicitly in Markdown below their headings, preserving existing screenshots and videos rather than inserting a second preview automatically.
- Updated example instructions to open project ZIPs directly in score, without manual extraction.
- Added metadata-driven **Try this on web** links beside example downloads, using the downloaded project's own platform allow-list, including the document inside a ZIP. Eligibility follows score's case-insensitive `web` token and empty-means-all semantics.
- Disambiguated example and reference wiki links.
- Added LibreDiffusion runtime and engine-building instructions to the [StreamDiffusion reference]({{ site.baseurl }}/processes/streamdiffusion.html).
- Corrected 11 internal page links and removed 16 image references with no corresponding illustration. Existing relevant screenshots are retained.
- Removed the duplicate local copy of the wiki-link document manager. The pinned plugin supplies that implementation; the site's title matching and link diagnostics remain in its dedicated patch.
- Migrated the light, dark, custom and default stylesheets to Sass modules and namespaced built-ins, retaining the existing themes without suppressing compiler warnings.
- Integrated the native-process portions of [PR #87](https://github.com/ossia/score-docs/pull/87): seven geometry help destinations and Accumulator, LTC, XWax DVS, Synthimi and StreamDiffusion references. Existing overlapping manuals remain authoritative; preset catalogues and bundled navigation changes are deferred.
- Adapted [PR #92](https://github.com/ossia/score-docs/pull/92) project names, descriptions and documentation links into 82 current example documents without replacing their graphs or media. The metadata helper now preserves nested archive member paths; its regression test covers read-only inspection, metadata replacement, retained media and repeat runs.
- Integrated Puara references and the [PR #71](https://github.com/ossia/score-docs/pull/71) example into the [Leaky Integrator reference]({{ site.baseurl }}/processes/gestures.html#leaky-integrator). A synthetic runtime check exposed unstable Tilt output, so the [Roll](https://github.com/ossia/score-docs/pull/73) and [Tilt](https://github.com/ossia/score-docs/pull/74) tutorials remain deferred. The [Shake](https://github.com/ossia/score-docs/pull/76) reference records the ineffective threshold control and gravity behavior.
- Adapted [PR #53](https://github.com/ossia/score-docs/pull/53) into theme-aware search foregrounds, readable previews and parent titles, and explicit placeholder, hover and keyboard-selection colors.
- The incomplete [Wekinator guide](https://github.com/ossia/score-docs/pull/63) remains deferred; [PR #27](https://github.com/ossia/score-docs/pull/27) adds no substantive content beyond the existing interface overview.

---

## Version 3.x (Current)

The 3.x series introduced major features including GPU-based video processing, improved scripting, and enhanced audio capabilities.

### 3.8

| Version | Date | Changelog |
|---------|------|-----------|
| **v3.8.0** | February 2026 | [Release notes](https://github.com/ossia/score/releases/tag/v3.8.0) |

### 3.7

| Version | Date | Changelog |
|---------|------|-----------|
| v3.7.1 | September 2025 | [Release notes](https://github.com/ossia/score/releases/tag/v3.7.1) |
| v3.7.0 | September 2025 | [Release notes](https://github.com/ossia/score/releases/tag/v3.7.0) |

### 3.6

| Version | Date | Changelog |
|---------|------|-----------|
| v3.6.1 | August 2025 | [Release notes](https://github.com/ossia/score/releases/tag/v3.6.1) |
| v3.6.0 | August 2025 | [Release notes](https://github.com/ossia/score/releases/tag/v3.6.0) |

### 3.5

| Version | Date | Changelog |
|---------|------|-----------|
| v3.5.3 | July 2025 | [Release notes](https://github.com/ossia/score/releases/tag/v3.5.3) |
| v3.5.2 | May 2025 | [Release notes](https://github.com/ossia/score/releases/tag/v3.5.2) |
| v3.5.1 | April 2025 | [Release notes](https://github.com/ossia/score/releases/tag/v3.5.1) |
| v3.5.0 | April 2025 | [Release notes](https://github.com/ossia/score/releases/tag/v3.5.0) |

### 3.4

| Version | Date | Changelog |
|---------|------|-----------|
| v3.4.1 | January 2025 | [Release notes](https://github.com/ossia/score/releases/tag/v3.4.1) |
| v3.4.0 | January 2025 | [Release notes](https://github.com/ossia/score/releases/tag/v3.4.0) |

### 3.3

| Version | Date | Changelog |
|---------|------|-----------|
| v3.3.2 | November 2024 | [Release notes](https://github.com/ossia/score/releases/tag/v3.3.2) |
| v3.3.1 | November 2024 | [Release notes](https://github.com/ossia/score/releases/tag/v3.3.1) |
| v3.3.0 | November 2024 | [Release notes](https://github.com/ossia/score/releases/tag/v3.3.0) |

### 3.2

| Version | Date | Changelog |
|---------|------|-----------|
| v3.2.4 | July 2024 | [Release notes](https://github.com/ossia/score/releases/tag/v3.2.4) |
| v3.2.3 | July 2024 | [Release notes](https://github.com/ossia/score/releases/tag/v3.2.3) |
| v3.2.2 | June 2024 | [Release notes](https://github.com/ossia/score/releases/tag/v3.2.2) |
| v3.2.1 | June 2024 | [Release notes](https://github.com/ossia/score/releases/tag/v3.2.1) |
| v3.2.0 | May 2024 | [Release notes](https://github.com/ossia/score/releases/tag/v3.2.0) |

### 3.1

| Version | Date | Changelog |
|---------|------|-----------|
| v3.1.14 | April 2024 | [Release notes](https://github.com/ossia/score/releases/tag/v3.1.14) |
| v3.1.13 | February 2024 | [Release notes](https://github.com/ossia/score/releases/tag/v3.1.13) |
| v3.1.12 | October 2023 | [Release notes](https://github.com/ossia/score/releases/tag/v3.1.12) |
| v3.1.11 | June 2023 | [Release notes](https://github.com/ossia/score/releases/tag/v3.1.11) |
| v3.1.10 | May 2023 | [Release notes](https://github.com/ossia/score/releases/tag/v3.1.10) |
| v3.1.9 | April 2023 | [Release notes](https://github.com/ossia/score/releases/tag/v3.1.9) |
| v3.1.8 | March 2023 | [Release notes](https://github.com/ossia/score/releases/tag/v3.1.8) |
| v3.1.7 | February 2023 | [Release notes](https://github.com/ossia/score/releases/tag/v3.1.7) |
| v3.1.6 | January 2023 | [Release notes](https://github.com/ossia/score/releases/tag/v3.1.6) |
| v3.1.5 | November 2022 | [Release notes](https://github.com/ossia/score/releases/tag/v3.1.5) |
| v3.1.4 | November 2022 | [Release notes](https://github.com/ossia/score/releases/tag/v3.1.4) |
| v3.1.3 | September 2022 | [Release notes](https://github.com/ossia/score/releases/tag/v3.1.3) |
| v3.1.2 | September 2022 | [Release notes](https://github.com/ossia/score/releases/tag/v3.1.2) |
| v3.1.1 | August 2022 | [Release notes](https://github.com/ossia/score/releases/tag/v3.1.1) |
| v3.1.0 | July 2022 | [Release notes](https://github.com/ossia/score/releases/tag/v3.1.0) |

### 3.0

| Version | Date | Changelog |
|---------|------|-----------|
| v3.0.12 | July 2022 | [Release notes](https://github.com/ossia/score/releases/tag/v3.0.12) |
| v3.0.11 | June 2022 | [Release notes](https://github.com/ossia/score/releases/tag/v3.0.11) |
| v3.0.10 | June 2022 | [Release notes](https://github.com/ossia/score/releases/tag/v3.0.10) |
| v3.0.9 | May 2022 | [Release notes](https://github.com/ossia/score/releases/tag/v3.0.9) |
| v3.0.8 | April 2022 | [Release notes](https://github.com/ossia/score/releases/tag/v3.0.8) |
| v3.0.7 | April 2022 | [Release notes](https://github.com/ossia/score/releases/tag/v3.0.7) |
| v3.0.6 | March 2022 | [Release notes](https://github.com/ossia/score/releases/tag/v3.0.6) |
| v3.0.5 | March 2022 | [Release notes](https://github.com/ossia/score/releases/tag/v3.0.5) |
| v3.0.4 | February 2022 | [Release notes](https://github.com/ossia/score/releases/tag/v3.0.4) |
| v3.0.3 | February 2022 | [Release notes](https://github.com/ossia/score/releases/tag/v3.0.3) |
| v3.0.2 | February 2022 | [Release notes](https://github.com/ossia/score/releases/tag/v3.0.2) |
| v3.0.1 | January 2022 | [Release notes](https://github.com/ossia/score/releases/tag/v3.0.1) |
| **v3.0.0** | January 2022 | [Release notes](https://github.com/ossia/score/releases/tag/v3.0.0) |

<details>
<summary><strong>3.0.0 Pre-releases</strong> (click to expand)</summary>

| Version | Date | Changelog |
|---------|------|-----------|
| v3.0.0-rc7 | December 2021 | [Release notes](https://github.com/ossia/score/releases/tag/v3.0.0-rc7) |
| v3.0.0-rc6 | December 2021 | [Release notes](https://github.com/ossia/score/releases/tag/v3.0.0-rc6) |
| v3.0.0-rc5 | November 2021 | [Release notes](https://github.com/ossia/score/releases/tag/v3.0.0-rc5) |
| v3.0.0-rc4 | November 2021 | [Release notes](https://github.com/ossia/score/releases/tag/v3.0.0-rc4) |
| v3.0.0-rc3 | November 2021 | [Release notes](https://github.com/ossia/score/releases/tag/v3.0.0-rc3) |
| v3.0.0-rc2 | November 2021 | [Release notes](https://github.com/ossia/score/releases/tag/v3.0.0-rc2) |
| v3.0.0-rc1 | September 2021 | [Release notes](https://github.com/ossia/score/releases/tag/v3.0.0-rc1) |
| v3.0.0-b9 | September 2021 | [Release notes](https://github.com/ossia/score/releases/tag/v3.0.0-b9) |
| v3.0.0-b8 | September 2021 | [Release notes](https://github.com/ossia/score/releases/tag/v3.0.0-b8) |
| v3.0.0-b7 | September 2021 | [Release notes](https://github.com/ossia/score/releases/tag/v3.0.0-b7) |
| v3.0.0-b6 | September 2021 | [Release notes](https://github.com/ossia/score/releases/tag/v3.0.0-b6) |
| v3.0.0-b5 | September 2021 | [Release notes](https://github.com/ossia/score/releases/tag/v3.0.0-b5) |
| v3.0.0-b4 | August 2021 | [Release notes](https://github.com/ossia/score/releases/tag/v3.0.0-b4) |
| v3.0.0-b3 | August 2021 | [Release notes](https://github.com/ossia/score/releases/tag/v3.0.0-b3) |
| v3.0.0-b2 | August 2021 | [Release notes](https://github.com/ossia/score/releases/tag/v3.0.0-b2) |
| v3.0.0-b1 | August 2021 | [Release notes](https://github.com/ossia/score/releases/tag/v3.0.0-b1) |

</details>

---

## Version 2.x (Legacy)

The 2.x series focused on stability and workflow improvements.

| Version | Date | Changelog |
|---------|------|-----------|
| v2.5.1 | August 2019 | [Release notes](https://github.com/ossia/score/releases/tag/v2.5.1) |
| v2.5.0 | August 2019 | [Release notes](https://github.com/ossia/score/releases/tag/v2.5.0) |
| v2.4.1 | May 2019 | [Release notes](https://github.com/ossia/score/releases/tag/v2.4.1) |
| v2.4.0 | May 2019 | [Release notes](https://github.com/ossia/score/releases/tag/v2.4.0) |
| v2.3.1 | May 2019 | [Release notes](https://github.com/ossia/score/releases/tag/v2.3.1) |
| v2.2.3 | May 2019 | [Release notes](https://github.com/ossia/score/releases/tag/v2.2.3) |
| v2.2.2 | May 2019 | [Release notes](https://github.com/ossia/score/releases/tag/v2.2.2) |
| v2.2.1 | April 2019 | [Release notes](https://github.com/ossia/score/releases/tag/v2.2.1) |
| v2.2.0 | April 2019 | [Release notes](https://github.com/ossia/score/releases/tag/v2.2.0) |
| v2.1.3 | February 2019 | [Release notes](https://github.com/ossia/score/releases/tag/v2.1.3) |
| v2.1.2 | January 2019 | [Release notes](https://github.com/ossia/score/releases/tag/v2.1.2) |
| v2.1.1 | January 2019 | [Release notes](https://github.com/ossia/score/releases/tag/v2.1.1) |
| v2.1.0 | January 2019 | [Release notes](https://github.com/ossia/score/releases/tag/v2.1.0) |

<details>
<summary><strong>2.0.0 Pre-releases</strong> (click to expand)</summary>

| Version | Date | Changelog |
|---------|------|-----------|
| v2.0.0-a24 | October 2018 | [Release notes](https://github.com/ossia/score/releases/tag/v2.0.0-a24) |
| v2.0.0-a23 | September 2018 | [Release notes](https://github.com/ossia/score/releases/tag/v2.0.0-a23) |
| v2.0.0-a22 | September 2018 | [Release notes](https://github.com/ossia/score/releases/tag/v2.0.0-a22) |
| v2.0.0-a21 | September 2018 | [Release notes](https://github.com/ossia/score/releases/tag/v2.0.0-a21) |
| v2.0.0-a20 | September 2018 | [Release notes](https://github.com/ossia/score/releases/tag/v2.0.0-a20) |
| v2.0.0-a19 | September 2018 | [Release notes](https://github.com/ossia/score/releases/tag/v2.0.0-a19) |
| v2.0.0-a18 | September 2018 | [Release notes](https://github.com/ossia/score/releases/tag/v2.0.0-a18) |
| v2.0.0-a17 | September 2018 | [Release notes](https://github.com/ossia/score/releases/tag/v2.0.0-a17) |
| v2.0.0-a16 | September 2018 | [Release notes](https://github.com/ossia/score/releases/tag/v2.0.0-a16) |
| v2.0.0-a14 | September 2018 | [Release notes](https://github.com/ossia/score/releases/tag/v2.0.0-a14) |
| v2.0.0-a13 | September 2018 | [Release notes](https://github.com/ossia/score/releases/tag/v2.0.0-a13) |
| v2.0.0-a10 | August 2018 | [Release notes](https://github.com/ossia/score/releases/tag/v2.0.0-a10) |
| v2.0.0-a9 | July 2018 | [Release notes](https://github.com/ossia/score/releases/tag/v2.0.0-a9) |
| v2.0.0-a8 | July 2018 | [Release notes](https://github.com/ossia/score/releases/tag/v2.0.0-a8) |
| v2.0.0-a7 | July 2018 | [Release notes](https://github.com/ossia/score/releases/tag/v2.0.0-a7) |
| v2.0.0-a6 | June 2018 | [Release notes](https://github.com/ossia/score/releases/tag/v2.0.0-a6) |
| v2.0.0-a4 | June 2018 | [Release notes](https://github.com/ossia/score/releases/tag/v2.0.0-a4) |
| v2.0.0-a2 | April 2018 | [Release notes](https://github.com/ossia/score/releases/tag/v2.0.0-a2) |
| v2.0.0-a1 | April 2018 | [Release notes](https://github.com/ossia/score/releases/tag/v2.0.0-a1) |

</details>

---

## Version 1.x (Legacy)

The 1.x series was the first public release of *ossia score*.

<details>
<summary><strong>1.0.0 Releases</strong> (click to expand)</summary>

| Version | Date | Changelog |
|---------|------|-----------|
| v1.0.0-b39 | October 2017 | [Release notes](https://github.com/ossia/score/releases/tag/v1.0.0-b39) |
| v1.0.0-b38 | October 2017 | [Release notes](https://github.com/ossia/score/releases/tag/v1.0.0-b38) |
| v1.0.0-b37 | September 2017 | [Release notes](https://github.com/ossia/score/releases/tag/v1.0.0-b37) |
| v1.0.0-b36 | September 2017 | [Release notes](https://github.com/ossia/score/releases/tag/v1.0.0-b36) |
| v1.0.0-b35 | September 2017 | [Release notes](https://github.com/ossia/score/releases/tag/v1.0.0-b35) |
| v1.0.0-b34 | September 2017 | [Release notes](https://github.com/ossia/score/releases/tag/v1.0.0-b34) |
| v1.0.0-b33 | September 2017 | [Release notes](https://github.com/ossia/score/releases/tag/v1.0.0-b33) |
| v1.0.0-b32 | September 2017 | [Release notes](https://github.com/ossia/score/releases/tag/v1.0.0-b32) |
| v1.0.0-b31 | August 2017 | [Release notes](https://github.com/ossia/score/releases/tag/v1.0.0-b31) |
| v1.0.0-b30 | August 2017 | [Release notes](https://github.com/ossia/score/releases/tag/v1.0.0-b30) |
| v1.0.0-b29 | July 2017 | [Release notes](https://github.com/ossia/score/releases/tag/v1.0.0-b29) |
| v1.0.0-b28 | July 2017 | [Release notes](https://github.com/ossia/score/releases/tag/v1.0.0-b28) |
| v1.0.0-b27 | June 2017 | [Release notes](https://github.com/ossia/score/releases/tag/v1.0.0-b27) |
| v1.0.0-b23 | June 2017 | [Release notes](https://github.com/ossia/score/releases/tag/v1.0.0-b23) |
| v1.0.0-b22 | June 2017 | [Release notes](https://github.com/ossia/score/releases/tag/v1.0.0-b22) |
| v1.0.0-b20 | June 2017 | [Release notes](https://github.com/ossia/score/releases/tag/v1.0.0-b20) |
| v1.0.0-b17 | May 2017 | [Release notes](https://github.com/ossia/score/releases/tag/v1.0.0-b17) |
| v1.0.0-b16 | May 2017 | [Release notes](https://github.com/ossia/score/releases/tag/v1.0.0-b16) |
| v1.0.0-b15 | May 2017 | [Release notes](https://github.com/ossia/score/releases/tag/v1.0.0-b15) |
| v1.0.0-b14 | May 2017 | [Release notes](https://github.com/ossia/score/releases/tag/v1.0.0-b14) |
| v1.0.0-b12 | May 2017 | [Release notes](https://github.com/ossia/score/releases/tag/v1.0.0-b12) |
| v1.0.0-b11 | May 2017 | [Release notes](https://github.com/ossia/score/releases/tag/v1.0.0-b11) |
| v1.0.0-b10 | May 2017 | [Release notes](https://github.com/ossia/score/releases/tag/v1.0.0-b10) |
| v1.0.0-b9 | May 2017 | [Release notes](https://github.com/ossia/score/releases/tag/v1.0.0-b9) |
| v1.0.0-b7 | February 2017 | [Release notes](https://github.com/ossia/score/releases/tag/v1.0.0-b7) |
| v1.0.0-b6 | February 2017 | [Release notes](https://github.com/ossia/score/releases/tag/v1.0.0-b6) |
| v1.0.0-b4 | February 2017 | [Release notes](https://github.com/ossia/score/releases/tag/v1.0.0-b4) |
| v1.0.0-b3 | January 2017 | [Release notes](https://github.com/ossia/score/releases/tag/v1.0.0-b3) |
| v1.0.0-b2 | January 2017 | [Release notes](https://github.com/ossia/score/releases/tag/v1.0.0-b2) |
| v1.0.0-b1 | December 2016 | [Release notes](https://github.com/ossia/score/releases/tag/v1.0.0-b1) |

</details>

<details>
<summary><strong>1.0.0 Alpha releases</strong> (click to expand)</summary>

| Version | Date | Changelog |
|---------|------|-----------|
| v1.0.0-a78 | November 2016 | [Release notes](https://github.com/ossia/score/releases/tag/v1.0.0-a78) |
| v1.0.0-a77 | November 2016 | [Release notes](https://github.com/ossia/score/releases/tag/v1.0.0-a77) |
| v1.0.0-a76 | November 2016 | [Release notes](https://github.com/ossia/score/releases/tag/v1.0.0-a76) |
| v1.0.0-a75 | October 2016 | [Release notes](https://github.com/ossia/score/releases/tag/v1.0.0-a75) |
| v1.0.0-a74 | October 2016 | [Release notes](https://github.com/ossia/score/releases/tag/v1.0.0-a74) |
| v1.0.0-a73 | September 2016 | [Release notes](https://github.com/ossia/score/releases/tag/v1.0.0-a73) |
| v1.0.0-a72 | August 2016 | [Release notes](https://github.com/ossia/score/releases/tag/v1.0.0-a72) |
| v1.0.0-a70 | June 2016 | [Release notes](https://github.com/ossia/score/releases/tag/v1.0.0-a70) |
| v1.0.0-a69 | June 2016 | [Release notes](https://github.com/ossia/score/releases/tag/v1.0.0-a69) |
| v1.0.0-a68 | May 2016 | [Release notes](https://github.com/ossia/score/releases/tag/v1.0.0-a68) |
| v1.0.0-a67 | April 2016 | [Release notes](https://github.com/ossia/score/releases/tag/v1.0.0-a67) |
| v1.0.0-a66 | April 2016 | [Release notes](https://github.com/ossia/score/releases/tag/v1.0.0-a66) |
| v1.0.0-a65 | April 2016 | [Release notes](https://github.com/ossia/score/releases/tag/v1.0.0-a65) |

</details>

---

## Continuous builds

Automated builds from the main branch are available:

[Continuous builds](https://github.com/ossia/score/releases/tag/continuous) - Updated automatically from the main branch

---

## All Releases

View all releases on GitHub: [github.com/ossia/score/releases](https://github.com/ossia/score/releases)
