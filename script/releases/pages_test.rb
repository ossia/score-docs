# frozen_string_literal: true

require "minitest/autorun"
require "jekyll"
require "nokogiri"
require "tmpdir"
require "fileutils"
require_relative "../../_plugins/releases"

class ReleasePagesTest < Minitest::Test
  def setup
    @root = Dir.mktmpdir("release-pages")
    FileUtils.mkdir_p(File.join(@root, "_layouts"))
    FileUtils.mkdir_p(File.join(@root, "_includes"))
    FileUtils.mkdir_p(File.join(@root, "_data"))
    File.write(File.join(@root, "_layouts/default.html"), "<main>{{ content }}</main>")
    FileUtils.cp(File.expand_path("../../_layouts/release.html", __dir__), File.join(@root, "_layouts/release.html"))
    File.write(File.join(@root, "_includes/secret.html"), "PRIVATE_CONTENT")
  end

  def teardown
    FileUtils.remove_entry(@root)
  end

  def release(html, tag: "v3.9.0", id: 1)
    { "id" => id, "tag_name" => tag, "slug" => tag, "name" => tag,
      "published_at" => "2026-10-15T20:33:28Z", "prerelease" => false,
      "html_url" => "https://github.com/ossia/score/releases/tag/#{tag}", "body_html" => html }
  end

  def build(records, baseurl: "")
    File.write(File.join(@root, "_data/releases.json"), JSON.generate(
      "schema_version" => 1, "repository" => "ossia/score", "releases" => records, "media" => {}
    ))
    site = Jekyll::Site.new(Jekyll.configuration(
      "source" => @root, "destination" => File.join(@root, "_site"), "config" => [],
      "plugins" => [], "quiet" => true, "permalink" => "pretty",
      "url" => "https://ossia.io", "baseurl" => baseurl, "title" => "NOT_EXECUTED"
    ))
    site.process
    site
  end

  def test_archive_urls_survive_pretty_permalinks_with_and_without_notes
    site = build([release("<p>New features</p>"), release("", tag: "0.3a0", id: 2)])
    latest = File.join(site.dest, "reference/changelog/v3.9.0.html")
    oldest = File.join(site.dest, "reference/changelog/0.3a0.html")
    assert File.file?(latest), "The URL used by the archive index must resolve to an HTML file"
    assert File.file?(oldest), "Releases without notes must still have a page"
  end

  def test_imported_templates_remain_literal_and_mirrored_media_use_production_baseurl
    literal = "{{ site.title }} {% include secret.html %} [[Changelog]]"
    html = "<p>#{literal}</p><a href='/assets/releases/photo.gif'><img src='/assets/releases/photo.gif' alt='Example'></a><video src='/assets/releases/movie.webm' controls></video>"
    site = build([release(html)], baseurl: "/score-docs")
    doc = Nokogiri::HTML(File.read(File.join(site.dest, "reference/changelog/v3.9.0.html")))
    assert_includes doc.at_css(".release-content").text, literal
    refute_includes doc.text, "PRIVATE_CONTENT"
    refute_includes doc.text, "NOT_EXECUTED"
    assert_equal "/score-docs/assets/releases/photo.gif", doc.at_css("img")["src"]
    assert_equal "/score-docs/assets/releases/photo.gif", doc.at_css(".release-content a")["href"]
    assert_equal "/score-docs/assets/releases/movie.webm", doc.at_css("video")["src"]
    assert_equal "/score-docs/reference/changelog.html", doc.at_css("article > p a")["href"]
  end

  def test_unmirrored_media_prevents_publication
    error = assert_raises(Jekyll::Errors::FatalException) do
      build([release('<img src="https://example.org/remote.png">')])
    end
    assert_includes error.message, "Unmirrored src"
  end
end
