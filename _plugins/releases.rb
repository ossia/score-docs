# frozen_string_literal: true

require "nokogiri"
require "set"

module ScoreReleases
  class Generator < Jekyll::Generator
    safe false
    priority :low

    def generate(site)
      snapshot = site.data["releases"]
      unless snapshot.is_a?(Hash) && snapshot["schema_version"] == 1 &&
             snapshot["repository"] == "ossia/score" && snapshot["releases"].is_a?(Array)
        fail_build("Missing or unsupported _data/releases.json; run the release importer before building.")
      end

      slugs = Set.new
      releases = snapshot.fetch("releases").sort_by do |release|
        [release.fetch("published_at").to_s, release.fetch("id").to_i]
      end.reverse
      entries = releases.map do |release|
        slug = release.fetch("slug")
        unless slug.match?(/\A[A-Za-z0-9][A-Za-z0-9._-]*\z/) && slugs.add?(slug)
          fail_build("Invalid or duplicate release slug: #{slug.inspect}")
        end
        entry = release.merge(
          "url" => "/reference/changelog/#{slug}.html",
          "development" => release.fetch("tag_name") == "continuous"
        )
        title = release["name"].to_s.strip
        title = release.fetch("tag_name") if title.empty?
        page = Jekyll::PageWithoutAFile.new(site, site.source, "reference/changelog", "#{slug}.html")
        # Imported Markdown and HTML must never enter Liquid or wiki conversion.
        page.content = ""
        page.data.merge!(
          "layout" => "release", "title" => title,
          "permalink" => entry.fetch("url"),
          "description" => "ossia score #{release.fetch('tag_name')} release notes",
          "parent" => "Changelog", "grand_parent" => "Reference",
          "nav_exclude" => true, "search_exclude" => false,
          "edit_link" => false, "release" => entry,
          "release_body_html" => local_html(site, release)
        )
        site.pages << page
        entry
      end

      numbered, development = entries.partition { |entry| !entry["development"] }
      groups = numbered.group_by do |entry|
        match = entry.fetch("tag_name").match(/\Av?(\d+)\./)
        match ? match[1] : "other"
      end
      site.data["release_archive"] = {
        "count" => entries.size,
        "groups" => groups.map do |major, items|
          legacy_id = { "3" => "version-3x-current", "2" => "version-2x-legacy", "1" => "version-1x-legacy" }[major]
          seen = Set.new
          items = items.map do |entry|
            minor = entry.fetch("tag_name")[/\Av?(3\.[0-8])(?:\.|\z)/, 1]
            minor && seen.add?(minor) ? entry.merge("legacy_anchor" => minor.delete(".")) : entry
          end
          { "title" => major == "other" ? "Other releases" : "Version #{major}.x",
            "id" => legacy_id || "version-#{major}", "releases" => items }
        end,
        "development" => development
      }
    end

    private

    def local_html(site, release)
      fragment = Nokogiri::HTML.fragment(release.fetch("body_html"))
      baseurl = site.baseurl.to_s.sub(%r{/\z}, "")
      fragment.css("[src], [poster], [href], [srcset]").each do |node|
        if node["srcset"]
          fail_build("Unexpected srcset in #{release['tag_name']}; mirror it in the importer first.")
        end
        %w[src poster href].each do |attribute|
          value = node[attribute]
          next unless value
          if value.start_with?("/assets/releases/")
            node[attribute] = "#{baseurl}#{value}"
          elsif attribute != "href"
            fail_build("Unmirrored #{attribute} in #{release['tag_name']}: #{value}; rerun the release importer.")
          end
        end
      end
      fragment.to_html
    end

    def fail_build(message)
      raise Jekyll::Errors::FatalException, "Release archive: #{message}"
    end
  end
end
