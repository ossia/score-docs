---
layout: default

title: Package manager
description: "Managing additional content packages"

parent: In depth

permalink: /package-manager.html
---

# Package manager

The package manager installs shared content and optional extensions into the library.
Open **Packages** in the application settings, then select **Available packages**.
Select a package, read its description and external project link, and install it.
**Local packages** lists installed packages and provides update and uninstall actions.
**Filter by kind** shows the kinds present in the selected tab, not a fixed list of
features guaranteed to exist in every build.

Availability depends on the score build, operating system, architecture and package catalogue.

## Package types

| Kind | Purpose |
|---|---|
| Library/content packages | Presets, scripts, shaders, media and other reusable files. These do not necessarily add a new native process. |
| `addon` | Source add-ons compiled and registered by score's runtime C++ compiler. |
| `nodes` | Node-source packages installed through the add-on path; require a compatible node loader. |
| `sdk` | Headers and runtime-compilation support matching the running score release and architecture. Not needed just to use ordinary media or presets. |
| `support` | Native libraries needed by other extensions. Installing support files alone does not create a process or device. |
| `ai-models` | Model data for compatible machine-learning processes; the process add-on and its inference runtime are separate requirements. |

## Installation folders

The **Library** settings select the library root. In a normal ossia score installation
it defaults to `<Documents>/ossia/score`; the actual Documents folder is supplied by
the operating system. Builds with another application or organization name may use
a different root.

| Location relative to the root | Contents |
|---|---|
| `packages/<raw_name>/` | Installed content or add-on package, using its catalogue identifier rather than its display name. |
| `packages/default/` | Downloaded default user library. |
| `packages/user/` | Personal content; includes `medias`, `presets`, `devices` and `cues`. |
| `sdk/<score-version>/` | SDK archive for the running release, with its directory layout preserved. |
| `support/<raw_name>/` | Support-package native libraries. |

The system library browses `packages`, not `sdk` or `support`. Keep personal changes
in `packages/user` rather than editing a downloaded package that an update can replace.
Uninstall removes that package's directory; SDK removal removes the SDK directory.

## Manual installation

1. Obtain the package from its trusted project or catalogue link.
2. Extract content into its own directory under `packages`. Avoid an extra archive
   wrapper: a runtime source add-on must have `addon.json` directly inside
   `packages/<package>/`, with `"kind": "addon"`.
3. Preserve the package's subfolders and metadata. Content packages use `package.json`
   for package-manager identification; arbitrary files can be browsed without becoming
   managed packages.
4. Place native support libraries under `support/<package>/`, not alongside presets.
   A manually extracted SDK must retain the matching release layout under `sdk`.
5. Allow the library scan to finish. Restart score if manually installed content is
   not discovered, and after changing support libraries.

Do not treat a prebuilt plug-in binary as interchangeable with a runtime source
package. Use the distributor's instructions for binaries built against a particular
score version and platform.

## Runtime add-ons and native dependencies

Runtime compilation requires a score build with the JIT C++ plug-in and a compatible
SDK. The package manager downloads the SDK matching the running release and architecture when a corresponding SDK archive is published.
Add-on installation starts compilation where supported. Check the message console
for compilation or loading errors if no new process appears.

Support libraries are discovered when library settings initialize at startup.
Windows adds directories containing `.dll` files to its DLL search path. Linux loads
`.so` / `.so.*` files and macOS loads `.dylib` files so add-ons can resolve their native
dependencies. Missing dependencies can still leave a library unloadable; installation
does not fix incompatible architectures, absent drivers or licensing restrictions.
Only install native code from sources you trust.

## Updates, rescans and automation

Package updates can be announced in the **Process library**, with an **Update** link
opening **Packages**. Updating a package and replacing an existing process in a score
are different operations: see the [library panel]({{ site.baseurl }}/panels/library.html)
for the process inspector's source-update action.

Library scans discover supported files asynchronously. They are not a native-library
reload mechanism. Restart after replacing native dependencies or unloading add-ons.

Package downloading is implemented independently of the settings window, so application
scripts can request downloads without opening the main UI. The scripting `Library`
API exposes `installedPackages()`, `refreshAvailablePackages()`, `availablePackages()`
and `installPackage(uuid)`. Refresh is asynchronous: a list read immediately afterwards
may still be empty. Use a UUID from the available catalogue, not a package display name.
`installPackage` uses the content-package installer; it is not the settings page's
special SDK installer. These APIs require a build with the package-manager plug-in
and do not guarantee a successful runtime compilation.

See [Add-ons]({{ site.baseurl }}/reference/add-ons.html) for extension-specific requirements
and [Presets]({{ site.baseurl }}/presets.html) for saving reusable process settings.
