---
layout: default

title: Stream Deck Device
description: "Elgato Stream Deck and Mirabox / Ajazz Stream Dock keypads"

parent: Devices
grand_parent: Reference

permalink: /devices/streamdeck-device.html
---
# Stream Deck Device

![Stream Deck editor]({{ site.img }}/reference/devices/streamdeck/editor.png "The Stream Deck editor")

Lays out pages of keys on an Elgato Stream Deck, or on a Mirabox / Ajazz Stream Dock, and connects them to the score. A key can show text, colours, an image or a part of a texture. Pressing it can run actions, and its look can follow values of the score.

score talks to the deck directly. Elgato's software is not needed, and it must not be running at the same time.

## Requirements

- The **Stream Deck** add-on, from the package manager in the settings.
- On Linux, read and write access to the deck's `/dev/hidraw*` node. For instance, in `/etc/udev/rules.d/70-streamdeck.rules`, one line per vendor id from the [table of models](#models):

  ```
  SUBSYSTEM=="hidraw", ATTRS{idVendor}=="0fd9", TAG+="uaccess"
  ```

  Then run `sudo udevadm control --reload-rules && sudo udevadm trigger`, and plug the deck in again.

## Device setup

1. In the **Device Explorer**, click **+** and choose **Hardware ▸ Stream Deck**.
2. Pick the deck from the list. The **Any** entries, such as **Any Stream Deck XL**, lay out a deck that is not plugged in: score uses the first deck of that model that gets connected.
3. **Mode**: **Buttons** runs the layout made in the editor. **Remote control** shows score's transport and the controls of the selected process; see [Remote control mode](#remote-control-mode).

The device exists whether or not the deck is plugged in. The layout runs either way, and the deck picks it up when it is connected, or connected again.

## The editor

Open it with **Windows ▸ Stream Deck…** (Ctrl+Shift+J), or with **Edit the layout…** in the context menu of the device in the Device Explorer.

- **Pages**, on the left. The selected page is the one on the deck. Selecting a page shows it on the deck, and the list follows when the deck changes page. Double-click a page to rename it.
- **The deck**, in the middle. Click a key to edit it. Drag a key to move it, with Ctrl to copy it. Drop an address from the Device Explorer on a key to control it, or an image file to show it. Right-click a key for presets: copy and paste, triggers, transport, pages.
- **The key**, on the right: its look, actions and feedbacks.
- **Try it** turns clicks into presses on the deck's current page. The mouse wheel turns the dials.

Every change can be undone, and applies to the running deck immediately.

### Look

Text, background and text colours, text size and position, and an image. The look can change while the key is pressed, or while it is on for a toggle key.

Parts of the text written `${…}` are JavaScript, evaluated continuously:

```
Level
${Number(Device.read("osc:/level")).toFixed(2)}
```

### Actions

Actions run when the key is pressed and when it is released. For a **toggle** key, they run when it is switched on and off. Each action can be delayed. **Hold for** makes the key wait before running anything, for keys that must not be hit by accident.

| Action | |
|---|---|
| Trigger | Writes to `deck:/actions/<name>`. See [Triggers and inputs](#triggers-and-inputs). |
| Send | Sends a value to an address. |
| Toggle | Inverts a boolean address. |
| Step | Adds to a number, within its range. |
| Go to page, Next page, Previous page | Changes the page shown on the deck. |
| Script | Runs JavaScript. See [Scripts](#scripts). |

### Feedbacks

A feedback changes the look of the key while a condition holds: an address is on or off, equal to, above or below a value, or a script is true. The address is one of the score, or an input of the deck. When several feedbacks hold, the last one wins.

### Dials

On the Stream Deck + and the Mirabox N3 / N4: an address the dial turns, its step, actions when it is pressed, and the text of its segment of the strip.

### Video pages

On a **Video page**, the keys show their part of the texture sent to the device: connect a video or shader process to the device's root address. The keys still run their actions. The texture's size is shown in the device's settings.

## Triggers and inputs

Rather than pointing a key at a fixed address, a key can expose addresses of its own in the deck's tree, to be mapped along the score. A key can then do different things at different points of the score.

- A **Trigger** action writes to `deck:/actions/<name>`. As an **Impulse**, each press sends an impulse. As **On / off**, each press switches a boolean, and the key looks pressed while it is on.
- A feedback on a **Deck input** reads `deck:/feedbacks/<name>`: map any value to it.

The name defaults to the page and the key, such as `Show/key3`.

## Scripts

Scripts are JavaScript, in the same engine as the console and `--script`: `Device.read()`, `Device.write()`, `Score`, `Util` are available. They also get `deck`, this deck, and `key`, the number of the key from 1.

| `deck` | |
|---|---|
| `page()`, `pageName()`, `pageCount()` | The page on the deck, from 1. |
| `setPage(n)`, `nextPage()`, `previousPage()` | Changes it. |
| `brightness()`, `setBrightness(percent)` | |

- A **Script** action is a function body: `Device.write("osc:/light", 1);`
- A **Script** feedback is an expression: `Device.read("osc:/level") > 0.5`
- In the text of a key: `${deck.pageName()}`.

Text and feedback scripts run continuously and cannot change the page or the brightness. A script that fails shows ⚠ on its key, and its error in the editor. Like the console, scripts see the devices of the document in front.

## Remote control mode

The bottom row is the transport: play, stop, previous and next bank, and the time when there are five columns or more. The other keys and the dials show the controls of the selected process. A press toggles a boolean, fires an impulse or adds 10 % to a number. A dial step moves its control by 1 %.

## Available controls

| Address | Type | |
|---|---|---|
| `deck:/` | texture | Shown on the keys of video pages |
| `deck:/page` | int | The page on the deck, from 1 |
| `deck:/key/N/pressed` | bool | Key N, whatever the page; writing it presses the key |
| `deck:/pages/P/key/N/pressed` | bool | Key N, while page P is shown |
| `deck:/pages/P/key/N/color`, `text`, `text_color`, `image` | | Change a key at run time; an empty text or a transparent colour goes back to the layout |
| `deck:/actions/<name>` | impulse, bool | Written by triggers |
| `deck:/feedbacks/<name>` | bool, float | Read by feedbacks |
| `deck:/brightness` | int, 0 to 100 | |
| `deck:/encoder/N/pressed`, `turn`, `position` | | Dials |
| `deck:/touch/tap`, `long_press`, `swipe` | | Touch strip, in pixels |
| `deck:/touch_key/N/pressed` | bool | Keys without a display |
| `deck:/info/model`, `serial`, `firmware` | string | |

## Models

| Model | USB id | |
|---|---|---|
| Stream Deck MK.2 | `0fd9:0080` | tested |
| Stream Deck MK.2 (scissor keys), (v2), MK.2 modules | `0fd9:00a5`, `006d`, `00b9`, `00e4` | |
| Stream Deck XL, XL (v2), XL module | `0fd9:006c`, `008f`, `00ba` | |
| Stream Deck + | `0fd9:0084` | |
| Stream Deck Neo | `0fd9:009a` | the info screen is not used |
| Stream Deck Mini, Mini (v2), Discord edition, Mini module | `0fd9:0063`, `0090`, `00b3`, `00b8` | |
| Stream Deck Pedal | `0fd9:0086` | |
| Ajazz AKP153 / AKP153E / AKP153R, Mirabox 293S | `5548:6674`, `0300:1010`, `0300:1020`, `5548:6670` | presses only |
| Mirabox Stream Dock 293, Redragon SS-550 | `5500:1001`, `0200:1000` | presses only |
| Mirabox Stream Dock 293 V3 | `6603:1005`, `6603:1006` | |
| Mirabox N3, Ajazz AKP03 / AKP03R, Soomfon SE, Redragon SS-551 | `6603:1002`, `6603:1003`, `0300:1001`, `0300:1003`, `0300:3003`, `1500:3001`, `0200:2000` | side buttons are `touch_key` |
| Mirabox N4, Ajazz AKP05 / AKP05E, Soomfon CN003, Redragon SS-552 | `6602:1001`, `6603:1007`, `0300:3006`, `0300:3004`, `1500:3002`, `0200:3001` | |

Only the MK.2 has been tested so far. The other models follow the reference implementations. "Presses only": these decks do not report releases, so a release follows each press immediately.

Not supported: the original 2017 Stream Deck, the Stream Deck + XL and Studio, the Ulanzi D200, and the Loupedeck / Razer Stream Controller.
