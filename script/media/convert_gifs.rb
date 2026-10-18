#!/usr/bin/env ruby
# frozen_string_literal: true

# Replaces the animated GIFs that documentation pages embed from
# assets/images/ with AVIF or WebM (see lib/score_media.rb) and rewrites the
# pages that reference them. A short loop keeps its Markdown image, with only
# the extension changed; a longer one becomes a looping <video data-loop>.
#
#   ruby script/media/convert_gifs.rb [--jobs N] [assets/images/....gif ...]
#
# Without arguments every GIF referenced from docs/ or index.md is converted.
# GIFs that are still images, or that would not shrink, are left as they are.

require "optparse"
require "etc"
require_relative "../../lib/score_media"

ROOT = File.expand_path("../..", __dir__)
IMG = "{{ site.img }}"
IMAGES = "assets/images"

jobs = [Etc.nprocessors / 2, 1].max
OptionParser.new do |opts|
  opts.banner = "Usage: ruby script/media/convert_gifs.rb [--jobs N] [GIF ...]"
  opts.on("--jobs N", Integer, "Parallel encodes (default #{jobs})") { |n| jobs = n }
end.parse!

Dir.chdir(ROOT)
pages = Dir["docs/**/*.md"] + ["index.md"]
texts = pages.to_h { |p| [p, File.read(p)] }
referenced = texts.values.flat_map { |t| t.scan(/#{Regexp.escape(IMG)}(\/[^)"'\s]+\.gif)/).flatten }.uniq
gifs = ARGV.empty? ? referenced.map { |r| "#{IMAGES}#{r}" } : ARGV
gifs = gifs.select { |g| File.file?(g) }.uniq

queue = Queue.new
gifs.each { |g| queue << g }
results = {}
lock = Mutex.new
Array.new(jobs) do
  Thread.new do
    while (gif = (queue.pop(true) rescue nil))
      result = ScoreMedia.convert_gif(gif, gif.delete_suffix(".gif"))
      lock.synchronize do
        results[gif] = result
        puts result ? "#{gif} -> .#{result.extension} (#{File.size(gif) / 1024}K -> #{File.size(result.path) / 1024}K)" : "#{gif}: kept"
      end
    end
  end
end.each(&:join)

def attribute(name, value)
  value.to_s.empty? ? "" : %( #{name}="#{value.gsub('"', "&quot;")}")
end

def video(src, alt, title, width = nil)
  %(<video src="#{src}" data-loop controls muted loop playsinline preload="metadata") +
    attribute("width", width) + attribute("aria-label", alt) + attribute("title", title) + "></video>"
end

results.each do |gif, result|
  next unless result
  url = "#{IMG}#{gif.delete_prefix(IMAGES)}"
  target = "#{url.delete_suffix(".gif")}.#{result.extension}"
  leftover = false
  texts.each_key do |page|
    text = texts[page]
    next unless text.include?(url)
    if result.extension == "avif"
      text = text.gsub(url, target)
    else
      src = Regexp.escape(url)
      text = text.gsub(/!\[([^\]]*)\]\(#{src}(?:\s+"([^"]*)")?\)/) { video(target, $1, $2) }
      text = text.gsub(/<img\b[^>]*\bsrc="#{src}"[^>]*>/) do |tag|
        video(target, tag[/\balt="([^"]*)"/, 1], tag[/\btitle="([^"]*)"/, 1], tag[/\bwidth="([^"]*)"/, 1])
      end
      if text.include?(url)
        warn "#{page}: unconverted reference to #{url}; keeping the GIF"
        leftover = true
      end
    end
    texts[page] = text
  end
  File.delete(gif) unless leftover
end

texts.each { |page, text| File.write(page, text) if text != File.read(page) }
