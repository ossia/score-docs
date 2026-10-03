# frozen_string_literal: true

require "minitest/autorun"
require "json"
require "open3"
require "tmpdir"
require "fileutils"
require "digest"
require "rbconfig"

class ExampleMetadataTest < Minitest::Test
  SCRIPT = File.expand_path("metadata.rb", __dir__)
  PROJECT_INFO_UUID = "aac1402f-6851-4a1a-ab50-5f213acd1262"

  def test_prepare_updates_nested_score_without_flattening_or_changing_media
    Dir.mktmpdir("score metadata ") do |root|
      member = "nested project/example.score"
      media_member = "nested project/media/sound bytes.bin"
      media = "\x00\xff\x01media\x00".b
      info = { "uuid" => PROJECT_INFO_UUID, "Author" => "Original author",
               "Created" => "2025-01-01T00:00:00.000Z", "LastSaved" => "2025-02-01T00:00:00.000Z",
               "Thumbnail" => "preserved thumbnail", "AutomaticThumbnail" => false }
      document = { "Version" => 5, "Plugins" => [info],
                   "Document" => { "Media" => "media/sound bytes.bin", "Processes" => [1, 2, 3] } }
      staging = File.join(root, "staging")
      FileUtils.mkdir_p(File.dirname(File.join(staging, media_member)))
      File.write(File.join(staging, member), JSON.generate(document))
      File.binwrite(File.join(staging, media_member), media)

      archive = File.join(root, "assets/scores/examples/nested example.zip")
      FileUtils.mkdir_p(File.dirname(archive))
      command!("zip", "-q", archive, member, media_member, chdir: staging)
      entry = { "id" => "examples/nested example", "format" => "zip",
                "name" => "Nested example", "description" => "An example with media.",
                "page" => "https://ossia.io/score-docs/examples/nested.html" }
      FileUtils.mkdir_p(File.join(root, "_site/assets/scores"))
      File.write(File.join(root, "_site/assets/scores/index.json"), JSON.generate("examples" => [entry]))

      original_archive = Digest::SHA256.file(archive).hexdigest
      command!({ "SCORE_DOCS_ROOT" => root }, RbConfig.ruby, SCRIPT, "status")
      assert_equal original_archive, Digest::SHA256.file(archive).hexdigest, "status must not rewrite the archive"
      command!({ "SCORE_DOCS_ROOT" => root }, RbConfig.ruby, SCRIPT, "prepare")

      assert_equal [member, media_member].sort, command!("unzip", "-Z1", archive).lines.map(&:strip).sort
      assert_equal media, command!("unzip", "-p", archive, media_member).b
      rewritten = JSON.parse(command!("unzip", "-p", archive, member))
      assert_equal document.reject { |key, _| key == "Plugins" }, rewritten.reject { |key, _| key == "Plugins" }
      assert_equal [info.merge("Name" => entry["name"], "Description" => entry["description"], "Url" => entry["page"])], rewritten["Plugins"]

      prepared_archive = Digest::SHA256.file(archive).hexdigest
      command!({ "SCORE_DOCS_ROOT" => root }, RbConfig.ruby, SCRIPT, "prepare")
      assert_equal prepared_archive, Digest::SHA256.file(archive).hexdigest, "a second prepare must leave the archive unchanged"
    end
  end

  private

  def command!(*args, **options)
    out, err, status = Open3.capture3(*args, **options)
    assert status.success?, "#{args.inspect} failed: #{err}\n#{out}"
    out
  end
end
