---
layout: default

title: Troubleshooting
description: "What to do when score does not work"

nav_order: 8
has_children: false

permalink: /troubleshooting.html

---

# Troubleshooting score issues

## score just crashed
Please send us a detailed bug report of what you were doing at the moment of the crash,
along with any crashlog, in either the forum, the chat or the <a href="https://github.com/ossia/score/issues">Github issues (preferably)</a>.
Thanks !

## score crashes immediately on first start-up on Windows
Check that you do not have the JACK2 ASIO driver installed. It is known to cause <a href="https://github.com/jackaudio/jack2/issues/275">crashes on startup on Windows</a> for many software. You can check the following registry key in the Windows registry editor: <b>HKEY_LOCAL_MACHINE\SOFTWARE\ASIO</b>.


## score crashes immediately on first start-up on Linux
If you get an error from the terminal which looks like:

```
The program 'ossia-score' received an X Window System error.
This probably reflects a bug in the program.
The error was 'BadMatch (invalid parameter attributes)'.
(Details: serial 363 error_code 8 request_code 154 minor_code 34)
(Note to programmers: normally, X errors are reported asynchronously;
that is, you will receive the error a while after causing it.
To debug your program, run it with the --sync command line
option to change this behavior. You can then get a meaningful
backtrace from your debugger if you break on the gdk_x_error() function.) 
```

Then this is likely an OpenGL driver issue. Try running score with the `--no-opengl` command-line flag.

## The playback does not start
Most of the time, this is due to incorrect sound settings.

Go to the [settings]({{ site.baseurl}}/reference/preferences.html#audio) and check that you have a valid sound card set.

## The score runs but there is no sound
Most of the time, this is due to incorrect sound settings. Check that you are not using the Dummy driver which does not uses the soundcard.

Go to the [settings]({{ site.baseurl}}/reference/preferences.html#audio) and check that the correct sound-card is selected for audio output (for instance, it happens that the sound card chosen is the HDMI output of the computer monitor, which may not have loudspeakers).

## Playback seems to hang at random times on Linux
This is due to a <a href="https://portaudio.music.columbia.narkive.com/3V9hsUak/pa-linux-alsa-c-3636-assertion-failed-with-hack-fix">PortAudio bug</a>.

Use the JACK backend instead.

## Some VST plug-ins and virtual cameras do not work on Mac
You are likely encountering <a href="https://stackoverflow.com/questions/61114738/are-macos-virtual-webcams-inherently-incompatible-with-10-14s-hardened-runtime">security-related macOS issues</a>. 

As a workaround, you can follow the steps given in the above link to remove the code signing of the score binary, which will in turn make macOS allow score to open virtual webcams and any audio plug-ins.

## The minimap is hard to use on Mac
You are likely encountering <a href="https://stackoverflow.com/questions/61843481/macos-simulated-mouse-event-only-works-when-launching-binary-not-application-b">this macOS issue</a>.

A possible solution if score cannot be added to the Accessibility settings panel, is to remove the file `/Library/Application Support/com.apple.TCC/TCC.db`
and then reboot, according to <a href="https://discussions.apple.com/thread/250066606">this link</a>.

As a workaround, you can try to open score by right-clicking on Score.app, selection "Open contents", navigating to "Score.app/Contents/MacOS" and running the "score" binary from there.

## I don't receive OSC / DMX / ... messages

Check that your operating system does not have a firewall running.
For instance, in some Linux distributions such as CachyOS, default configurations of firewalls block incoming UDP messages fairly indiscriminately.
