# frozen_string_literal: true

# Publishes assets/scores/index.json: a machine-readable index of every score
# this site ships, which ossia score's start screen fetches to fill its Examples
# tab.
#
# The documents are the source of truth. Each .score carries a ProjectInfo block
# -- name, description, and a screenshot of the document view, written by score
# itself every time the file is saved -- so the manifest reports what the file
# says about itself rather than a second description maintained by hand.
#
# A documentation page joins its score to the entry by declaring the asset in
# `score:` front matter, which is also what the page's own download link is
# built from. Scores with no page yet are still listed, with "page": null.
#
# The embedded thumbnails are also written out as ordinary PNGs under
# assets/scores/thumbnails/, so a client can show a preview without first
# downloading a project archive that may be tens of megabytes.

require "json"
require "base64"
require "set"
require "shellwords"

module ScoreExamples
  # score::ProjectInfo::uuid_string
  PROJECT_INFO_UUID = "aac1402f-6851-4a1a-ab50-5f213acd1262"
  SCORES_DIR = "assets/scores"
  THUMBS_DIR = "assets/scores/thumbnails"
  MANIFEST = "assets/scores/index.json"
  # Bump only when a field is removed or its meaning changes; additions do not.
  VERSION = 1

  # A file built in memory rather than copied from the source tree, so that the
  # extracted thumbnails never have to be committed.
  class GeneratedFile < Jekyll::StaticFile
    def initialize(site, dir, name, bytes)
      super(site, site.source, dir, name)
      @bytes = bytes
    end

    def write(dest)
      path = destination(dest)
      FileUtils.mkdir_p(File.dirname(path))
      File.binwrite(path, @bytes)
      true
    end

    def modified?
      true
    end
  end

  class Generator < Jekyll::Generator
    safe false
    priority :low

    def generate(site)
      @site = site
      pages = pages_by_asset(site)

      entries = assets(site).filter_map { |path| entry(site, path, pages) }
      entries.sort_by! { |e| e["id"] }

      manifest = {
        "version" => VERSION,
        "generated" => site.time.utc.strftime("%Y-%m-%dT%H:%M:%SZ"),
        "site" => absolute(site, "/"),
        "examples" => entries,
      }

      page = Jekyll::PageWithoutAFile.new(site, site.source, File.dirname(MANIFEST),
                                          File.basename(MANIFEST))
      page.content = JSON.pretty_generate(manifest)
      page.data["layout"] = nil
      site.pages << page

      undocumented = entries.count { |e| e["page"].nil? }
      Jekyll.logger.info "score:", "#{entries.size} scores indexed " \
                                   "(#{entries.count { |e| e["image"] }} with a thumbnail, " \
                                   "#{undocumented} with no documentation page)"
    end

    private

    # A loose .score next to an archive of the same name is that archive's
    # document without its media: only the archive is worth publishing, which is
    # also the rule score applies when it scans a library folder.
    def assets(site)
      root = File.join(site.source, SCORES_DIR)
      all = Dir.glob(File.join(root, "**", "*.{score,zip}")).sort
      archives = all.select { |p| p.end_with?(".zip") }.map { |p| p.sub(/\.zip\z/, "") }.to_set
      all.reject { |p| p.end_with?(".score") && archives.include?(p.sub(/\.score\z/, "")) }
    end

    # asset path (as written in `score:` front matter) => the page declaring it.
    # A score may be referenced by several pages; the first in document order
    # wins, and the rest still link to it normally.
    def pages_by_asset(site)
      site.pages.each_with_object({}) do |p, acc|
        key = p.data["score"]
        acc[key] ||= p if key
      end
    end

    def entry(site, path, pages)
      rel = path.sub("#{site.source}/#{SCORES_DIR}", "") # "/examples/3d/sponza.score"
      id = rel.sub(%r{\A/}, "").sub(/\.[^.]+\z/, "")     # "examples/3d/sponza"
      info = project_info(path)
      page = pages[rel]

      section, group = id.split("/")
      group = nil if id.split("/").size < 3

      name = presence(info["Name"]) || presence(page&.data&.[]("title")) ||
             File.basename(id).tr("-_", " ")
      description = presence(info["Description"]) || presence(page&.data&.[]("description"))

      {
        "id" => id,
        "name" => name,
        "description" => description,
        "section" => section,
        "group" => group,
        "category" => presence(page&.data&.[]("parent")) || prettify(group || section),
        "page" => page ? absolute(site, page.url) : nil,
        "file" => absolute(site, "#{SCORES_DIR}#{rel}"),
        "format" => File.extname(path).delete("."),
        "size" => File.size(path),
        "author" => presence(info["Author"]),
        # Whitelist of platforms the document says it runs on, as its author
        # ticked them in Project Settings. Empty means everywhere, which is
        # what all but a handful of scores are.
        "platforms" => presence(info["Platforms"]).to_s.split,
        "image" => thumbnail(site, id, info["Thumbnail"]),
      }
    end

    # Writes the document's own screenshot out as a PNG and returns its URL.
    def thumbnail(site, id, base64)
      return nil if base64.to_s.empty?
      bytes = Base64.decode64(base64)
      return nil unless bytes.start_with?("\x89PNG\r\n\x1A\n".b)

      name = "#{id.tr("/", "-")}.png"
      site.static_files << GeneratedFile.new(site, "/#{THUMBS_DIR}", name, bytes)
      absolute(site, "#{THUMBS_DIR}/#{name}")
    end

    def project_info(path)
      json = path.end_with?(".zip") ? score_in_archive(path) : File.read(path)
      return {} unless json
      doc = JSON.parse(json)
      (doc["Plugins"] || []).find { |p| p.is_a?(Hash) && p["uuid"] == PROJECT_INFO_UUID } || {}
    rescue StandardError => e
      Jekyll.logger.warn "score:", "#{path}: #{e.message}"
      {}
    end

    # The archives are plain zips holding one .score beside its media; reading
    # the member out is a `unzip -p` rather than a gem this site would otherwise
    # not depend on.
    def score_in_archive(path)
      member = `unzip -Z1 #{path.shellescape} '*.score' 2>/dev/null`.lines.map(&:strip).first
      return nil unless member
      out = `unzip -p #{path.shellescape} #{member.shellescape} 2>/dev/null`
      out.empty? ? nil : out
    end

    def presence(value)
      s = value.to_s.strip
      s.empty? ? nil : s
    end

    def prettify(segment)
      return nil unless segment
      segment.tr("-_", " ").split.map(&:capitalize).join(" ")
    end

    def absolute(site, path)
      "#{site.config["url"]}#{site.config["baseurl"]}/#{path.sub(%r{\A/}, "")}"
    end
  end
end
