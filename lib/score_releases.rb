# frozen_string_literal: true

require "json"
require "nokogiri"
require "uri"
require "open3"
require "digest"
require "tmpdir"
require "fileutils"
require "tempfile"
require "timeout"

module ScoreReleases
  REPOSITORY = "ossia/score"
  class Error < StandardError; end

  # The original domain is parked and neither GitHub's cache nor the Internet
  # Archive retains this image. Its omission was approved for the release archive.
  OMITTED_MEDIA = ["http://i-score.org/wp-content/uploads/2017/09/score-logo64.png"].freeze

  # Only passive HTML is retained. Imported HTML is never a Liquid template.
  TAGS = %w[p br hr h1 h2 h3 h4 h5 h6 ul ol li dl dt dd blockquote pre code tt strong b em i del s strike sub sup a img video audio source track picture details summary table thead tbody tfoot tr th td div span kbd samp var abbr].freeze
  DROP = %w[script style iframe object embed svg math form input button textarea select template link meta base].freeze
  ATTRIBUTES = %w[href src poster alt title width height colspan rowspan start reversed open datetime kind srclang label type controls preload loading decoding].freeze
  TYPES = { "image/png" => "png", "image/jpeg" => "jpg", "image/gif" => "gif", "image/webp" => "webp", "image/svg+xml" => "svg", "image/avif" => "avif", "image/x-icon" => "ico", "video/mp4" => "mp4", "video/webm" => "webm", "video/quicktime" => "mov", "audio/mpeg" => "mp3", "audio/mp4" => "m4a", "audio/ogg" => "ogg", "video/ogg" => "ogv", "audio/wav" => "wav", "audio/x-wav" => "wav", "audio/flac" => "flac", "text/vtt" => "vtt" }.freeze

  def self.absolute(value, base)
    return nil if value.nil? || value.to_s.strip.empty?
    uri = URI.join(base, value.to_s.strip)
    return nil unless %w[http https].include?(uri.scheme) && uri.host && !uri.userinfo
    uri.to_s
  rescue URI::InvalidURIError
    nil
  end

  def self.canonical(url)
    uri = URI(url)
    if uri.host == "private-user-images.githubusercontent.com" && (uuid = uri.path[/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/i])
      "https://github.com/user-attachments/assets/#{uuid}"
    else
      url
    end
  end

  class Importer
    attr_reader :root

    def initialize(root:, refresh_media: false, cache_dir: File.join(Dir.tmpdir, "score-release-media"), fetcher: nil)
      @root = File.expand_path(root)
      @refresh = refresh_media
      @cache = cache_dir
      @fetcher = fetcher || method(:download)
      @snapshot = File.join(@root, "_data/releases.json")
      @previous = File.file?(@snapshot) ? JSON.parse(File.read(@snapshot)) : {}
      @media = {}
      @staged = {}
      @video_info = {}
    end

    def sync(raw)
      records = raw.flatten.reject { |release| release["draft"] }
      ids = records.map { |r| r.fetch("id") }
      raise Error, "Duplicate release IDs in source" unless ids.uniq == ids
      releases = records.sort_by { |r| [r["published_at"].to_s, r.fetch("id")] }.reverse.map do |release|
        tag = release.fetch("tag_name")
        slug = tag.gsub(/[^a-zA-Z0-9._-]/, "-").sub(/\A\.+/, "")
        slug = "release-#{release.fetch('id')}" if slug.empty?
        html = release["body_html"]
        raise Error, "#{tag}: body_html missing; fetch with Accept: application/vnd.github.full+json" if html.nil? && !release["body"].to_s.empty?
        result = %w[id tag_name name published_at updated_at prerelease html_url].to_h { |key| [key, release[key]] }
        result.merge("slug" => slug, "body" => release["body"].to_s, "body_html" => render(html.to_s, release), "prerelease" => !!release["prerelease"])
      rescue Error => e
        raise Error, "Release #{tag}: #{e.message}"
      end
      collisions = releases.group_by { |r| r["slug"].downcase }.values.select { |group| group.length > 1 }
      collisions.each { |group| group.each { |r| r["slug"] += "-#{r['id']}" } }
      snapshot = { "schema_version" => 1, "repository" => REPOSITORY, "releases" => releases, "media" => @media.sort.to_h }
      publish(snapshot)
      snapshot
    end

    def render(html, release)
      base = "https://github.com/#{REPOSITORY}/blob/#{URI::DEFAULT_PARSER.escape(release.fetch('tag_name'), /[^a-zA-Z0-9._~-]/)}/"
      doc = Nokogiri::HTML.fragment(html)
      doc.css(DROP.join(",")).remove
      doc.css("img").each do |node|
        source = ScoreReleases.absolute(node["data-canonical-src"] || node["data-src"] || node["src"], base)
        next unless OMITTED_MEDIA.include?(source)
        parent = node.parent
        node.remove
        parent.remove if parent.name == "a" && parent.children.empty?
      end
      doc.css("*").to_a.reverse_each { |node| node.replace(node.children) unless TAGS.include?(node.name) }
      image_links = doc.css("a[href]").select do |node|
        href = ScoreReleases.absolute(node["href"], base)
        href && image_link?(node, href, base)
      end
      # Discover before stripping attributes: canonical and lazy URLs carry original provenance.
      doc.css("img, video, audio, source, track").each do |node|
        original = node["data-canonical-src"] || node["data-src"] || node["src"]
        if original && !original.empty?
          node["src"] = mirror(original, base, alternate: node["src"])
        end
        node["poster"] = mirror(node["poster"], base) if node["poster"]
        # srcset candidates are mirrored even though the archive uses a single local source.
        srcset = node["srcset"] || node["data-srcset"]
        if srcset
          paths = srcset.split(",").map { |candidate| mirror(candidate.strip.split(/\s+/).first, base) }
          node["src"] ||= paths.first unless node.name == "source" && node.parent.name == "video"
        end
      end
      doc.css("a[href]").each do |node|
        href = ScoreReleases.absolute(node["href"], base)
        if href && image_links.include?(node)
          node["href"] = mirror(href, base)
        elsif href
          node["href"] = href
        elsif node["href"].start_with?("mailto:") && !node["href"].match?(/[\r\n]/)
          # Email links are passive and remain useful.
        else
          node.remove_attribute("href")
        end
      end
      doc.css("video, audio").each do |node|
        node["controls"] = "controls"
        node["preload"] = "none"
      end
      doc.css("*").each do |node|
        node.attribute_nodes.each { |attribute| node.remove_attribute(attribute.name) unless ATTRIBUTES.include?(attribute.name) }
        # Resource-bearing attributes are only meaningful on these explicitly processed elements.
        node.remove_attribute("src") unless %w[img video audio source track].include?(node.name)
        node.remove_attribute("poster") unless node.name == "video"
        node.remove_attribute("href") unless node.name == "a"
      end
      doc.css("video").each do |node|
        sources = [node["src"], *node.css("source[src]").map { |source| source["src"] }].compact
        if !sources.empty? && sources.all? { |source| (info = @video_info[source]) && !info["has_audio"] && info["duration"] <= 60 }
          # Native controls remain usable without JavaScript; enhancement respects reduced motion.
          node["data-release-loop"] = ""
        end
      end
      doc.to_html
    end

    def image_link?(node, href, base)
      return false unless node.at_css("img")
      image = node.at_css("img")
      uri = URI(href)
      href == ScoreReleases.absolute(image["data-canonical-src"] || image["data-src"] || image["src"], base) ||
        uri.path.match?(/\.(png|jpe?g|gif|webp|svg|avif|bmp|ico)\z/i) ||
        %w[user-images.githubusercontent.com private-user-images.githubusercontent.com camo.githubusercontent.com].include?(uri.host) ||
        (uri.host == "github.com" && uri.path.start_with?("/user-attachments/assets/"))
    end

    def mirror(value, base, alternate: nil)
      url = ScoreReleases.absolute(value, base)
      raise Error, "Unsupported embedded media URL #{value.inspect}" unless url
      url = ScoreReleases.canonical(url)
      return @media[url]["path"] if @media.key?(url)
      previous = @previous.fetch("media", {})[url]
      if !@refresh && valid_file?(previous)
        @media[url] = previous
        record_video(previous, File.join(root, previous["path"].delete_prefix("/")))
        return previous["path"]
      end
      FileUtils.mkdir_p(@cache)
      key = Digest::SHA256.hexdigest(url)
      metadata_path = File.join(@cache, "#{key}.json")
      bytes_path = File.join(@cache, "#{key}.media")
      cached = JSON.parse(File.read(metadata_path)) if !@refresh && File.file?(metadata_path)
      if cached && File.file?(bytes_path) && Digest::SHA256.file(bytes_path).hexdigest == cached["sha256"] && File.size(bytes_path) == cached["bytes"]
        metadata = cached
      else
        sources = [url, ScoreReleases.absolute(alternate, base)].compact.uniq
        errors = []
        metadata = nil
        sources.each do |source|
          begin
            Tempfile.create(["release-media", ".download"], @cache) do |file|
              type = @fetcher.call(source, file.path).to_s.split(";").first.to_s.downcase
              type, extension = identify(file.path, type)
              sha = Digest::SHA256.file(file.path).hexdigest
              metadata = { "path" => "/assets/releases/#{sha}.#{extension}", "sha256" => sha, "content_type" => type, "bytes" => File.size(file.path) }
              metadata["fetched_from"] = source if source != url
              FileUtils.cp(file.path, bytes_path)
            end
            File.write(metadata_path, JSON.pretty_generate(metadata) + "\n")
            break
          rescue Error => e
            errors << "#{source}: #{e.message}"
          end
        end
        raise Error, "Cannot mirror media (snapshot unchanged):\n#{errors.join("\n")}\nRestore source availability and rerun; cached successful downloads are retained in #{@cache}." unless metadata
      end
      record_video(metadata, bytes_path)
      @staged[metadata["path"]] = bytes_path
      @media[url] = metadata
      metadata["path"]
    end

    def record_video(metadata, path)
      return unless metadata.fetch("content_type").start_with?("video/")
      info = @video_info[metadata.fetch("path")] ||= begin
        out, err, status = Open3.capture3("ffprobe", "-v", "error", "-show_entries", "stream=codec_type:format=duration", "-of", "json", path)
        raise Error, "Cannot inspect video #{path}: #{err.strip}" unless status.success?
        probe = JSON.parse(out)
        duration = Float(probe.fetch("format").fetch("duration"))
        raise Error, "Invalid video duration: #{path}" unless duration.finite? && duration.positive?
        { "has_audio" => probe.fetch("streams").any? { |stream| stream["codec_type"] == "audio" }, "duration" => duration }
      end
      metadata.merge!(info)
    rescue Errno::ENOENT
      raise Error, "ffprobe (from FFmpeg) is required to inspect release videos"
    rescue JSON::ParserError, KeyError, ArgumentError, TypeError => e
      raise Error, "Cannot inspect video #{path}: #{e.message}"
    end

    def identify(path, type)
      head = File.binread(path, 1024)
      raise Error, "Empty media response" if head.empty?
      sniffed = if head.start_with?("\x89PNG\r\n\x1a\n".b) then "image/png"
                elsif head.start_with?("\xff\xd8\xff".b) then "image/jpeg"
                elsif head.start_with?("GIF87a", "GIF89a") then "image/gif"
                elsif head.start_with?("RIFF") && head[8, 4] == "WEBP" then "image/webp"
                elsif head.start_with?("RIFF") && head[8, 4] == "WAVE" then "audio/wav"
                elsif head.start_with?("\x1a\x45\xdf\xa3".b) then "video/webm"
                elsif head[4, 4] == "ftyp" then head[8, 4].to_s.match?(/avif|avis/) ? "image/avif" : (type == "audio/mp4" ? type : "video/mp4")
                elsif head.start_with?("OggS") then type == "video/ogg" ? type : "audio/ogg"
                elsif head.start_with?("fLaC") then "audio/flac"
                elsif head.start_with?("ID3") then "audio/mpeg"
                elsif head.lstrip.start_with?("<svg", "<?xml") && head.include?("<svg") then "image/svg+xml"
                end
      raise Error, "Expected media, received HTML (#{type})" if head.match?(/<!doctype\s+html|<html[\s>]/i)
      type = sniffed || type
      extension = TYPES[type]
      raise Error, "Unsupported media content type #{type.inspect}" unless extension
      [type, extension]
    end

    def download(url, destination)
      out, err, status = Open3.capture3("curl", "--disable", "--fail", "--silent", "--show-error", "--location", "--max-redirs", "8", "--connect-timeout", "20", "--max-time", "300", "--proto", "=http,https", "--proto-redir", "=http,https", "--user-agent", "score-docs-release-archive", "--output", destination, "--write-out", "%{content_type}", url)
      raise Error, "HTTP download failed: #{err.strip}" unless status.success?
      out
    rescue Errno::ENOENT
      raise Error, "curl is required to download release media"
    end

    def valid_file?(metadata)
      return false unless metadata && metadata["path"].to_s.match?(%r{\A/assets/releases/[0-9a-f]{64}\.[a-z0-9]+\z})
      path = File.join(root, metadata["path"].delete_prefix("/"))
      File.file?(path) && File.size(path) == metadata["bytes"] && Digest::SHA256.file(path).hexdigest == metadata["sha256"]
    end

    def check
      data = JSON.parse(File.read(@snapshot))
      raise Error, "Unsupported release snapshot" unless data["schema_version"] == 1 && data["repository"] == REPOSITORY
      data.fetch("media").each { |url, metadata| raise Error, "Missing or corrupt media: #{url} => #{metadata['path']}" unless valid_file?(metadata) }
      paths = data.fetch("media").values.map { |metadata| metadata["path"] }
      data.fetch("releases").each do |release|
        doc = Nokogiri::HTML.fragment(release.fetch("body_html"))
        doc.css("[src], [poster]").each do |node|
          %w[src poster].each do |attribute|
            next unless node[attribute]
            raise Error, "Unrecorded media in #{release['tag_name']}: #{node[attribute]}" unless paths.include?(node[attribute])
          end
        end
        doc.css("a[href^='/assets/releases/']").each do |node|
          raise Error, "Unrecorded linked media: #{node['href']}" unless paths.include?(node["href"])
        end
      end
      data
    rescue Errno::ENOENT => e
      raise Error, e.message
    end

    def publish(snapshot)
      # Assets are immutable and installed first; the single snapshot rename is the commit point.
      @staged.each do |relative, source|
        destination = File.join(root, relative.delete_prefix("/"))
        next if File.file?(destination) && Digest::SHA256.file(destination).hexdigest == File.basename(destination).split(".").first
        FileUtils.mkdir_p(File.dirname(destination))
        Tempfile.create(".release-", File.dirname(destination)) do |file|
          FileUtils.cp(source, file.path)
          File.chmod(0o644, file.path)
          File.rename(file.path, destination)
        end
      end
      content = JSON.pretty_generate(snapshot) + "\n"
      return if File.file?(@snapshot) && File.binread(@snapshot) == content
      FileUtils.mkdir_p(File.dirname(@snapshot))
      Tempfile.create(".releases-", File.dirname(@snapshot)) do |file|
        file.write(content)
        file.flush
        file.fsync
        File.chmod(0o644, file.path)
        File.rename(file.path, @snapshot)
      end
    end
  end

  def self.fetch_releases
    out, err, status = Timeout.timeout(300) do
      Open3.capture3("gh", "api", "--paginate", "--slurp", "-H", "Accept: application/vnd.github.full+json", "repos/#{REPOSITORY}/releases?per_page=100")
    end
    raise Error, "gh api failed: #{err.strip}" unless status.success?
    JSON.parse(out)
  rescue Errno::ENOENT
    raise Error, "gh CLI is required; install it and authenticate with gh auth login"
  rescue Timeout::Error
    raise Error, "gh api exceeded 300 seconds"
  end
end
