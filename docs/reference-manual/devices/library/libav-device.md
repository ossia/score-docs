---
layout: default

title: Libav device
description: "Real-time video and audio recording/streaming"

parent: Devices
grand_parent: Reference

permalink: /devices/libav-device.html
---
# Libav device

![Libav device]({{ site.img }}/reference/devices/libav.png "Libav device")

Record and stream your *score* performances using the power of FFmpeg libraries. Capture both video from your graphics pipeline and audio from your sound system, then encode and output to files, network streams, or broadcast systems.

Perfect for documenting performances, live streaming installations, creating video content, or archiving interactive works.

## Setting up a Libav device  

1. **Add device** in the [[Device explorer]] and choose "Libav"
2. **Choose output destination** - file path, network URL, or streaming endpoint
3. **Configure video settings** - resolution, frame rate, and codec
4. **Set audio parameters** - sample rate, channels, and codec
5. **Start recording/streaming** - activate the device to begin capture

The device includes several built-in presets for common scenarios like UDP streaming, file recording, and professional broadcast streaming.

## Output destinations

### File recording
**Video files**: Record to `.mkv`, `.mp4`, `.mov` or other container formats for later playback or editing.

**Audio files**: Create `.wav`, `.flac`, or compressed audio files for audio-only documentation.

**High quality**: Use lossless codecs for archival purposes or lossy compression for smaller files.

### Network streaming
**UDP streaming**: Low-latency streaming over local networks using formats like MJPEG for real-time applications.

**SRT streaming**: Professional streaming protocol for reliable broadcast-quality transmission over the internet.

**Custom protocols**: Support for various network protocols supported by FFmpeg.

## Video capture capabilities

**Real-time encoding**: Capture video frames directly from *score*'s graphics pipeline during performance.

**Resolution control**: Set custom output resolution independent of your display settings.

**Frame rate**: Configure from low frame rates for data-light streaming up to high frame rates for smooth video.

**Multiple codecs**: Choose from H.264 for compatibility, H.265 for better compression, or MJPEG for low-latency streaming.

**Hardware acceleration**: Support for GPU-accelerated encoding where available (implementation ongoing).

## Audio recording features

**Multi-channel support**: Record stereo, surround, or custom channel configurations.

**Sample rate flexibility**: Record at standard rates (44.1kHz, 48kHz) or custom rates to match your project.

**Format options**: PCM for quality, AAC for compression, or other codecs supported by FFmpeg.

**Audio/video sync**: Automatic synchronization ensures audio and video stay aligned during recording.

## Built-in presets

The device comes with several ready-to-use configurations:

**"UDP MJPEG streaming"**: Low-latency video streaming perfect for local network monitoring or projection systems.

**"MKV H.264 recording"**: High-quality file recording suitable for documentation and post-production.

**"SRT streaming"**: Professional streaming setup for broadcast applications or remote monitoring.

**"WAV recording"**: Audio-only recording for sound documentation or later video synchronization.

## Advanced configuration

**Custom FFmpeg options**: Add FFmpeg command-line parameters for fine-tuned control over encoding.

**Buffer management**: Configure buffering to balance quality, latency, and network efficiency.

**Error handling**: Robust error handling ensures recording continues even if network connections are interrupted.

**Dynamic parameters**: Some encoding parameters can be adjusted during recording for adaptive quality.

## Integration with score

**Graphics pipeline capture**: Automatically captures rendered output from [[Video]] processes, 3D scenes, and other visual elements.

**Audio system integration**: Records the final audio output including all [[Audio Effects]], synthesizers, and mixed sources.

**Timeline synchronization**: Recording can be triggered from [[Scenario]] elements for automated documentation.

**Parameter control**: Use [[OSC]] or other protocols to control recording remotely during performances.

## Creative applications

**Performance documentation**: Create professional recordings of interactive performances for posterity or promotion.

**Live streaming**: Stream installations or concerts to remote audiences in real-time.

**Content creation**: Generate video content for social media, websites, or educational materials.

**Remote monitoring**: Stream performance data to remote locations for technical monitoring or collaboration.

**Multi-camera setups**: Use multiple Libav devices to record different aspects of complex installations.

## Technical considerations

**Processing load**: Real-time encoding requires significant CPU resources - test your setup before critical performances.

**Storage requirements**: High-quality video recording generates large files - ensure adequate storage space.

**Network bandwidth**: Streaming requires stable network connections with sufficient bandwidth for your chosen quality settings.

**Codec compatibility**: Consider your target audience's playback capabilities when choosing codecs.

## Professional streaming

**SRT protocol**: Provides error correction and adaptive bitrate for reliable internet streaming.

**Broadcast integration**: Compatible with professional broadcast systems and CDN providers.

**Quality control**: Real-time monitoring of encoding quality and network conditions.

**Redundancy**: Multiple simultaneous streams for backup and failover scenarios.

## Related devices

Libav device complements [[MIDI]] devices for complete performance capture, works with [[OSC]] for remote control, and integrates with all visual processes like [[Video]] and 3D systems for comprehensive recording capabilities.