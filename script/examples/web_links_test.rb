# frozen_string_literal: true

require "minitest/autorun"
require "jekyll"
require "nokogiri"
require "json"
require "open3"
require "tmpdir"
require "fileutils"
require "uri"
require "yaml"
require_relative "../../_plugins/score_examples"

class ExampleWebLinksTest < Minitest::Test
  PROJECT_INFO_UUID = "aac1402f-6851-4a1a-ab50-5f213acd1262"
  INCLUDE = File.expand_path("../../_includes/try-on-web.html", __dir__)

  def setup
    @root = Dir.mktmpdir("score web links ")
    FileUtils.mkdir_p(File.join(@root, "_includes"))
    FileUtils.cp(INCLUDE, File.join(@root, "_includes/try-on-web.html"))
  end

  def teardown
    FileUtils.remove_entry(@root)
  end

  def test_platform_whitelist_controls_rendered_links
    cases = [
      ["web", true],
      ["LiNuX WeB", true],
      ["windows macos linux", false],
      ["webassembly", false],
      ["desktop-web", false],
      ["web\tlinux", false],
      [" \t ", false],
      ["  WEB  linux  ", true],
      ["", true],
      ["   ", true],
      [nil, true],
      [["linux"], true],
      [42, true],
    ]
    cases.each_with_index do |(platforms, _), index|
      asset = "/examples/platform-#{index}.score"
      add_score(asset, [{ "uuid" => PROJECT_INFO_UUID, "Platforms" => platforms }])
      add_page("platform-#{index}", asset)
    end
    build_site
    cases.each_with_index do |(platforms, eligible), index|
      expected = eligible ? ["https://ossia.io/score-web/?open=/score-docs/assets/scores/examples/platform-#{index}.score"] : []
      assert_equal expected, links("platform-#{index}"), "Platforms: #{platforms.inspect}"
    end
  end

  def test_legacy_and_missing_platform_metadata_remain_unrestricted
    add_score("/examples/legacy.score", [])
    add_score("/examples/missing.score", [{ "uuid" => PROJECT_INFO_UUID }])
    %w[legacy missing].each { |name| add_page(name, "/examples/#{name}.score") }
    build_site
    %w[legacy missing].each do |name|
      assert_equal ["https://ossia.io/score-web/?open=/score-docs/assets/scores/examples/#{name}.score"], links(name)
    end
  end

  def test_archive_metadata_takes_precedence_over_loose_copy
    { "allowed" => ["web", "linux"], "excluded" => ["linux", "web"] }.each do |name, (packed, loose)|
      asset = "/examples/#{name}"
      add_score("#{asset}.score", [{ "uuid" => PROJECT_INFO_UUID, "Platforms" => loose }])
      staging = File.join(@root, "_staging/#{name}")
      FileUtils.mkdir_p(File.join(staging, "project"))
      File.write(File.join(staging, "project/main.score"), JSON.generate("Plugins" => [{ "uuid" => PROJECT_INFO_UUID, "Platforms" => packed }]))
      _, err, status = Open3.capture3("zip", "-q", File.join(@root, "assets/scores#{asset}.zip"), "project/main.score", chdir: staging)
      assert status.success?, err
      add_page(name, "#{asset}.zip")
    end
    build_site
    assert_equal ["https://ossia.io/score-web/?open=/score-docs/assets/scores/examples/allowed.zip"], links("allowed")
    assert_equal [], links("excluded")
  end

  def test_all_pages_sharing_an_asset_lose_the_link_when_web_is_disabled
    asset = "/examples/shared.score"
    add_score(asset, [{ "uuid" => PROJECT_INFO_UUID, "Platforms" => "web" }])
    %w[first second].each { |name| add_page(name, asset) }
    site = build_site
    expected = ["https://ossia.io/score-web/?open=/score-docs/assets/scores/examples/shared.score"]
    %w[first second].each { |name| assert_equal expected, links(name) }

    add_score(asset, [{ "uuid" => PROJECT_INFO_UUID, "Platforms" => "linux" }])
    site.process
    %w[first second].each { |name| assert_equal [], links(name) }
  end

  def test_launch_url_preserves_reserved_characters_and_public_origin
    asset = "/examples/gain + & # %.score"
    add_score(asset, [{ "uuid" => PROJECT_INFO_UUID, "Platforms" => "web" }])
    add_page("escaped", asset)
    build_site
    hrefs = links("escaped")
    assert_equal 1, hrefs.size
    url = URI.parse(hrefs.first)
    assert_equal "https://ossia.io/score-web/", "#{url.scheme}://#{url.host}#{url.path}"
    assert_equal({ "open" => "/score-docs/assets/scores#{asset}" }, URI.decode_www_form(url.query).to_h)
    assert_nil url.fragment
  end

  private

  def add_score(asset, plugins)
    path = File.join(@root, "assets/scores#{asset}")
    FileUtils.mkdir_p(File.dirname(path))
    File.write(path, JSON.generate("Plugins" => plugins))
  end

  def add_page(name, asset)
    File.write(File.join(@root, "#{name}.md"), "#{YAML.dump('score' => asset)}---\n{% include try-on-web.html %}\n")
  end

  def build_site
    site = Jekyll::Site.new(Jekyll.configuration(
      "source" => @root, "destination" => File.join(@root, "_site"),
      "url" => "http://127.0.0.1:4321", "baseurl" => "/preview",
      "theme" => nil, "plugins" => [], "quiet" => true
    ))
    site.process
    site
  end

  def links(name)
    Nokogiri::HTML(File.read(File.join(@root, "_site/#{name}.html"))).css("a").map { |link| link["href"] }
  end
end
