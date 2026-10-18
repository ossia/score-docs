# frozen_string_literal: true

# The media vendored beside the examples stays in the repository so that a score
# can be opened and edited in place, and each example's .zip is built from it.
# The site hands out the archive, so a loose file that is byte for byte a member
# of a published archive is not published a second time.
#
# A loose file is still published when something on the site may load it
# directly: a standalone .score (one with no archive of the same name, so its
# media is not bundled) that names the file, or a page that links to its path.

require "set"
require "shellwords"
require "zlib"

module ScoreArchiveMedia
  SCORES_DIR = "assets/scores"

  class Generator < Jekyll::Generator
    safe false
    priority :low

    def generate(site)
      files = site.static_files.select { |f| relative(f).start_with?("#{SCORES_DIR}/") }
      archives = files.select { |f| f.path.end_with?(".zip") }
      archived = archive_members(archives)
      return if archived.empty?

      scores = standalone_scores(files, archives)
      pages = (site.pages + site.documents).map { |p| p.content.to_s }
      dropped = files.select do |f|
        next false if f.path.end_with?(".zip", ".score")
        name = File.basename(f.path)
        path = relative(f)
        next false unless archived[[name, File.size(f.path)]]&.include?(crc32(f.path))
        scores.none? { |text| text.include?(name) } && pages.none? { |text| text.include?(path) }
      end
      return if dropped.empty?

      drop = dropped.to_set
      site.static_files.reject! { |f| drop.include?(f) }
      bytes = dropped.sum { |f| File.size(f.path) }
      Jekyll.logger.info "score:", "#{dropped.size} loose media files " \
                                   "(#{(bytes / 1048576.0).round} MiB) left out; their archives carry them"
    end

    private

    def relative(file)
      file.relative_path.sub(%r{\A/}, "")
    end

    # [basename, size] => CRC-32s of the archive members with that name and size,
    # read from the zip directory so no member has to be extracted.
    def archive_members(archives)
      archives.each_with_object({}) do |zip, acc|
        # Length Method Size Cmpr Date Time CRC-32 Name
        `unzip -lv #{zip.path.shellescape} 2>/dev/null`.scan(
          /^\s*(\d+)\s+\S+\s+\d+\s+\S+\s+\S+\s+\S+\s+([0-9a-f]{8})\s+(.+)$/
        ) do |size, crc, name|
          next if name.end_with?("/")
          (acc[[File.basename(name), size.to_i]] ||= Set.new) << crc.to_i(16)
        end
      end
    end

    def crc32(path)
      crc = 0
      File.open(path, "rb") { |io| crc = Zlib.crc32(io.read(1 << 20), crc) until io.eof? }
      crc
    end

    # Scores whose media is not bundled into an archive and so is fetched loose.
    def standalone_scores(files, archives)
      bundled = archives.map { |f| f.path.delete_suffix(".zip") }.to_set
      files.filter_map do |f|
        next unless f.path.end_with?(".score")
        File.read(f.path) unless bundled.include?(f.path.delete_suffix(".score"))
      end
    end
  end
end
