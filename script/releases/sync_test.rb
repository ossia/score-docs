# frozen_string_literal: true

require "minitest/autorun"
require "tmpdir"
require_relative "../../lib/score_releases"

class ReleaseSyncTest < Minitest::Test
  PNG = "\x89PNG\r\n\x1a\nfixture".b

  def setup
    @root = Dir.mktmpdir("score-release-test")
    @cache = Dir.mktmpdir("score-release-cache")
    @calls = []
    @responses = {}
    @fetcher = lambda do |url, path|
      @calls << url
      response = @responses.fetch(url) { raise ScoreReleases::Error, "HTTP 404" }
      File.binwrite(path, response[0])
      response[1]
    end
  end

  def teardown
    FileUtils.remove_entry(@root)
    FileUtils.remove_entry(@cache)
  end

  def importer(**options)
    ScoreReleases::Importer.new(root: @root, cache_dir: @cache, fetcher: @fetcher, **options)
  end

  def video_bytes(audio: false, duration: 0.2)
    path = File.join(@root, "clip-#{audio}-#{duration}.mp4")
    command = ["ffmpeg", "-v", "error", "-f", "lavfi", "-i", "color=c=black:s=16x16:r=10:d=#{duration}"]
    command += ["-f", "lavfi", "-i", "sine=frequency=440:duration=#{duration}", "-c:a", "aac"] if audio
    _, error, status = Open3.capture3(*command, "-c:v", "mpeg4", "-y", path)
    raise error unless status.success?
    File.binread(path)
  end

  def release(html = "", **attributes)
    { "id" => 10, "tag_name" => "v1.0", "name" => "First", "body" => "original {{ text }} [[link]]", "body_html" => html,
      "published_at" => "2024-01-01T00:00:00Z", "updated_at" => "2024-01-02T00:00:00Z", "html_url" => "https://github.com/ossia/score/releases/tag/v1.0" }.merge(attributes.transform_keys(&:to_s))
  end

  def test_relative_links_and_fullsize_images_are_resolved_without_mirroring_installers
    base = "https://github.com/ossia/score/blob/v1.0/"
    @responses[base + "small.png"] = [PNG, "image/png"]
    @responses[base + "full.png"] = [PNG + "full", "image/png"]
    data = importer.sync([[release('<a href="full.png"><img src="small.png" alt="Preview"></a><a href="docs/guide.md">Guide</a><a href="/ossia/score/releases/download/v1.0/setup.exe">Install</a>')]])
    doc = Nokogiri::HTML.fragment(data["releases"][0]["body_html"])
    assert_equal data["media"][base + "full.png"]["path"], doc.at_css("a")["href"]
    assert_equal "Preview", doc.at_css("img")["alt"]
    assert_equal base + "docs/guide.md", doc.css("a")[1]["href"]
    assert_equal "https://github.com/ossia/score/releases/download/v1.0/setup.exe", doc.css("a")[2]["href"]
    assert_equal [base + "small.png", base + "full.png"], @calls
  end

  def test_extensionless_video_and_poster_become_local_players_and_signed_urls_are_stable
    url = "https://github.com/user-attachments/assets/12345678-1234-1234-1234-123456789abc"
    signed = "https://private-user-images.githubusercontent.com/1/2-12345678-1234-1234-1234-123456789abc.mp4?jwt=expired"
    @responses[url] = [video_bytes, "application/octet-stream"]
    @responses["https://example.org/poster"] = [PNG, "image/png"]
    data = importer.sync([release("<details open><summary>Clip</summary><video src='#{signed}' poster='https://example.org/poster' autoplay></video></details>")])
    doc = Nokogiri::HTML.fragment(data["releases"][0]["body_html"])
    assert_equal "video/mp4", data["media"][url]["content_type"]
    assert_match(/\.mp4\z/, doc.at_css("video")["src"])
    assert_equal "none", doc.at_css("video")["preload"]
    assert doc.at_css("video").key?("controls")
    refute doc.at_css("video").key?("autoplay")
    assert_equal "Clip", doc.at_css("summary").text
    assert importer.check
  end

  def test_only_short_silent_videos_loop_including_all_alternative_sources
    clips = [["silent", false, 0.2], ["boundary", false, 60], ["long", false, 60.1], ["audio", true, 0.2]]
    clips.each do |name, audio, duration|
      @responses["https://example.org/#{name}"] = [video_bytes(audio: audio, duration: duration), "video/mp4"]
    end
    html = clips.map { |name, _, _| "<video src='https://example.org/#{name}'></video>" }.join
    html += "<video data-release-loop><source src='https://example.org/silent'><source src='https://example.org/audio'></video>"
    records = [release(html)]
    data = importer.sync(records)
    videos = Nokogiri::HTML.fragment(data["releases"][0]["body_html"]).css("video")
    assert_equal [true, true, false, false, false], videos.map { |video| video.key?("data-release-loop") }
    assert_equal [false, false, false, true], clips.map { |name, _, _| data["media"]["https://example.org/#{name}"]["has_audio"] }
    assert_equal data, importer.sync(records)
  end

  def test_sanitization_keeps_passive_formatting_and_does_not_interpret_source_text
    data = importer.sync([release('<script>alert(1)</script><svg onload="alert(1)"></svg><p onclick="alert(1)">{{ text }} [[link]] <a href="javascript:alert(1)">bad</a></p><table><tr><td>cell</td></tr></table>')])
    html = data["releases"][0]["body_html"]
    doc = Nokogiri::HTML.fragment(html)
    assert_nil doc.at_css("script, svg, [onclick]")
    assert_nil doc.at_css("a")["href"]
    assert_equal "cell", doc.at_css("td").text
    assert_includes doc.text, "{{ text }} [[link]]"
  end

  def test_idempotence_content_deduplication_and_offline_integrity
    %w[one two].each { |name| @responses["https://example.org/#{name}"] = [PNG, "image/png"] }
    records = [release('<img src="https://example.org/one"><img src="https://example.org/two">')]
    data = importer.sync(records)
    assert_equal 1, data["media"].values.map { |m| m["path"] }.uniq.length
    path = File.join(@root, "_data/releases.json")
    original = File.binread(path)
    timestamp = File.mtime(path)
    importer.sync(records)
    assert_equal original, File.binread(path)
    assert_equal timestamp, File.mtime(path)
    assert_equal 2, @calls.length
    assert_equal data, importer.check
    File.binwrite(File.join(@root, data["media"].values.first["path"].delete_prefix("/")), "corrupt")
    assert_raises(ScoreReleases::Error) { importer.check }
  end

  def test_failure_keeps_snapshot_and_cached_downloads_allow_recovery
    importer.sync([release])
    snapshot = File.binread(File.join(@root, "_data/releases.json"))
    @responses["https://example.org/good"] = [PNG, "image/png"]
    records = [release('<img src="https://example.org/good"><img src="https://example.org/missing">')]
    error = assert_raises(ScoreReleases::Error) { importer.sync(records) }
    assert_includes error.message, "https://example.org/missing"
    assert_equal snapshot, File.binread(File.join(@root, "_data/releases.json"))
    @responses["https://example.org/missing"] = [PNG, "image/png"]
    importer.sync(records)
    assert_equal 1, @calls.count("https://example.org/good")
    assert importer.check
  end

  def test_camo_fallback_keeps_original_provenance_and_rejects_html
    canonical = "https://example.org/logo.png"
    camo = "https://camo.githubusercontent.com/retained-image"
    @responses[canonical] = ["<!doctype html><html>Parked</html>", "text/html"]
    @responses[camo] = [PNG, "image/png"]
    data = importer.sync([release("<img src='#{camo}' data-canonical-src='#{canonical}'>")])
    assert_equal camo, data["media"][canonical]["fetched_from"]
    assert_equal [canonical, camo], @calls
  end

  def test_empty_notes_prereleases_and_continuous_are_kept_but_drafts_are_not
    records = [release(nil, body: nil), release("", id: 11, tag_name: "continuous", prerelease: true), release("", id: 12, tag_name: "draft", draft: true)]
    data = importer.sync([records])
    assert_equal %w[continuous v1.0], data["releases"].map { |r| r["tag_name"] }
    assert_equal "", data["releases"].last["body_html"]
    assert_equal true, data["releases"].first["prerelease"]
  end
end
