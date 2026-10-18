# frozen_string_literal: true

require "json"
require "open3"

# Animated GIFs are re-encoded before they are published: a GIF of a screen
# recording is typically ten times the size of the same frames in AV1 or VP9.
#
# Short loops become animated AVIF, which is still an image: it drops into an
# <img> or a Markdown image unchanged. Longer recordings become silent WebM
# (VP9, which unlike AV1 video also plays on Apple devices without an AV1
# decoder), shown as a looping <video data-loop> that viewers can pause and
# that honours reduced motion.
module ScoreMedia
  class Error < StandardError; end

  # Animations at most this long are encoded as AVIF, longer ones as WebM.
  AVIF_MAX_SECONDS = 10
  # Changing these settings changes the files produced, not the ones already
  # published: those are only re-encoded from their GIF source.
  AVIF = %w[-c:v libaom-av1 -crf 32 -cpu-used 6 -row-mt 1 -pix_fmt yuv420p -f avif].freeze
  WEBM = %w[-c:v libvpx-vp9 -crf 36 -b:v 0 -row-mt 1 -deadline good -cpu-used 3 -pix_fmt yuv420p -an -f webm].freeze

  Result = Struct.new(:path, :extension, :content_type, :duration, keyword_init: true)

  # Probes a GIF: frame count and duration in seconds.
  def self.probe(path)
    out, err, status = Open3.capture3("ffprobe", "-v", "error", "-count_packets", "-select_streams", "v:0",
                                      "-show_entries", "stream=nb_read_packets:format=duration", "-of", "json", path)
    raise Error, "Cannot inspect #{path}: #{err.strip}" unless status.success?
    probe = JSON.parse(out)
    [probe.dig("streams", 0, "nb_read_packets").to_i, probe.dig("format", "duration").to_f]
  rescue Errno::ENOENT
    raise Error, "ffprobe (from FFmpeg) is required to convert GIFs"
  end

  # Encodes an animated GIF to `destination` (without extension) and returns the
  # file written, or nil when the GIF is a still image or would not shrink.
  def self.convert_gif(source, destination)
    frames, duration = probe(source)
    return nil if frames <= 1 || !duration.positive?

    avif = duration <= AVIF_MAX_SECONDS
    extension = avif ? "avif" : "webm"
    output = "#{destination}.#{extension}"
    _, err, status = Open3.capture3("ffmpeg", "-v", "error", "-y", "-i", source, *(avif ? AVIF : WEBM), output)
    raise Error, "Cannot convert #{source}: #{err.strip}" unless status.success?
    if File.size(output) >= File.size(source)
      File.delete(output)
      return nil
    end
    Result.new(path: output, extension: extension, duration: duration,
               content_type: avif ? "image/avif" : "video/webm")
  rescue Errno::ENOENT
    raise Error, "ffmpeg is required to convert GIFs"
  end
end
