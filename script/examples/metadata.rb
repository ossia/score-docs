# frozen_string_literal: true

# Harness for giving every published example the project information that
# ossia score's start screen shows: a name, a description, a link back to its
# documentation page, and a screenshot.
#
#   ruby script/examples/metadata.rb status
#   ruby script/examples/metadata.rb prepare [--force] [--author NAME] [--only ID]
#   ruby script/examples/metadata.rb capture --score PATH [--only ID] [--settle MS]
#
# `prepare` writes the text -- taken from each example page's own front matter,
# so the descriptions are the ones already reviewed on the site rather than
# something invented here. `capture` re-saves each example through score, which
# grabs its view as the thumbnail. `status` says what is still missing.
#
# Everything is idempotent: values already set are kept unless --force is given.

require "json"
require "yaml"
require "base64"
require "fileutils"
require "tmpdir"
require "optparse"
require "set"

ROOT = File.expand_path(ENV["SCORE_DOCS_ROOT"] || File.expand_path("../..", __dir__))
SITE = "https://ossia.io/score-docs"
# score::ProjectInfo::uuid_string -- the key of the entry in the file's "Plugins".
PROJECT_INFO_UUID = "aac1402f-6851-4a1a-ab50-5f213acd1262"
CAPTURE_SCRIPT = File.join(__dir__, "capture.mjs")

# --- the corpus -------------------------------------------------------------

Example = Struct.new(:id, :name, :description, :url, :asset, :format, keyword_init: true)

MANIFEST = "_site/assets/scores/index.json"

# The corpus is whatever the site publishes, read back from the generated
# manifest: _plugins/score_examples.rb is what decides which scores are
# published, which page documents each one and what its URL is, and duplicating
# any of that here would only let the two drift.
def examples
  path = File.join(ROOT, MANIFEST)
  unless File.file?(path)
    abort "no #{MANIFEST}: run `bundle exec jekyll build` first"
  end

  JSON.parse(File.read(path))["examples"].map do |e|
    Example.new(
      id: e["id"],
      name: e["name"],
      description: e["description"],
      url: e["page"],
      asset: File.join(ROOT, "assets/scores", "#{e["id"]}.#{e["format"]}"),
      format: e["format"],
    )
  end
end

# --- reading and writing the score document ---------------------------------

# A project archive keeps its score as a member; everything else is media that
# must survive untouched, so the member is swapped in place rather than the
# archive rebuilt.
def with_score_document(ex)
  if ex.format == "zip"
    Dir.mktmpdir do |tmp|
      member = `unzip -Z1 #{ex.asset.inspect} "*.score" 2>/dev/null`.lines.map(&:strip).first or abort "#{ex.id}: no .score in archive"
      unless system("unzip", "-q", "-o", "-j", ex.asset, member, "-d", tmp, out: File::NULL)
        abort "#{ex.id}: cannot extract #{member} from #{ex.asset}"
      end
      extracted = File.join(tmp, member)
      changed = yield extracted
      if changed
        # `zip <archive> <file>` replaces that one entry and leaves the rest be.
        Dir.chdir(tmp) { system("zip", "-q", ex.asset, member) or abort "#{ex.id}: zip failed" }
      end
      changed
    end
  else
    yield ex.asset
  end
end

def project_info(doc)
  (doc["Plugins"] || []).find { |p| p.is_a?(Hash) && p["uuid"] == PROJECT_INFO_UUID }
end

def qt_now
  Time.now.utc.strftime("%Y-%m-%dT%H:%M:%S.%LZ")
end

# Width and height of a base64 PNG, straight out of its IHDR.
def png_size(base64)
  return nil if base64.nil? || base64.empty?
  data = Base64.decode64(base64)
  return nil unless data[0, 8] == "\x89PNG\r\n\x1A\n".b
  w, h = data[16, 8].unpack("N2")
  [w, h]
rescue StandardError
  nil
end

# --- commands ---------------------------------------------------------------

def cmd_status(_opts)
  rows = []
  examples.each do |ex|
    with_score_document(ex) do |path|
      info = project_info(JSON.parse(File.read(path)))
      thumb = info && png_size(info["Thumbnail"])
      rows << [ex.id, ex.format,
               info ? "yes" : "-",
               info && !info["Name"].to_s.empty? ? "yes" : "-",
               info && !info["Description"].to_s.empty? ? "yes" : "-",
               info && !info["Url"].to_s.empty? ? "yes" : "-",
               thumb ? "#{thumb[0]}x#{thumb[1]}" : "-"]
      false # read-only: never repack the archive
    end
  end

  header = %w[example fmt info name desc url thumbnail]
  widths = header.each_with_index.map { |h, i| ([h] + rows.map { |r| r[i].to_s }).map(&:length).max }
  fmt = widths.map { |w| "%-#{w}s" }.join("  ")
  puts fmt % header
  puts widths.map { |w| "-" * w }.join("  ")
  rows.each { |r| puts fmt % r }

  missing = rows.count { |r| r[6] == "-" }
  puts
  puts "#{rows.size} examples, #{rows.count { |r| r[2] == "yes" }} with project info, " \
       "#{rows.size - missing} with a thumbnail"
  puts "#{missing} still need a screenshot -- run `capture`, or open them in score and save" if missing > 0
end

def cmd_prepare(opts)
  touched = 0
  examples.each do |ex|
    next if opts[:only] && ex.id != opts[:only]

    with_score_document(ex) do |path|
      doc = JSON.parse(File.read(path))
      doc["Plugins"] ||= []
      info = project_info(doc)
      unless info
        info = { "uuid" => PROJECT_INFO_UUID, "Created" => qt_now, "LastSaved" => qt_now,
                 "Thumbnail" => "", "AutomaticThumbnail" => true }
        doc["Plugins"] << info
      end

      before = info.dup
      fill = lambda do |key, value|
        next if value.to_s.empty?
        info[key] = value if opts[:force] || info[key].to_s.empty?
      end
      fill.call("Name", ex.name)
      fill.call("Description", ex.description)
      fill.call("Url", ex.url)
      fill.call("Author", opts[:author])
      # Left on so that the next save through score refreshes the screenshot.
      info["AutomaticThumbnail"] = true if info["AutomaticThumbnail"].nil?

      if info == before
        puts "  unchanged  #{ex.id}"
        next false
      end

      write_json(path, doc)
      touched += 1
      puts "  updated    #{ex.id}"
      true
    end
  end
  puts
  puts "#{touched} example(s) updated"
  puts "Now give them a screenshot: `capture`, or open each in score and save."
end

# Atomic, and never leaves a truncated document behind: the result has to parse
# back and still hold the project information before it replaces the original.
def write_json(path, doc)
  tmp = "#{path}.tmp"
  File.write(tmp, JSON.generate(doc))
  reparsed = JSON.parse(File.read(tmp))
  raise "#{path}: rewritten document lost its project info" unless project_info(reparsed)
  FileUtils.mv(tmp, path)
ensure
  FileUtils.rm_f(tmp) if tmp && File.exist?(tmp)
end

# A project archive holds a copy of the score next to its media, and the loose
# .score beside it is the same document without them. Re-saving one through
# score only touches the loose copy, so the archive -- which is what the
# documentation links, and what score prefers when both are present -- keeps
# serving the version from before the edit. This puts the loose copy back into
# the archive, leaving every other member byte for byte as it was.
def cmd_sync(opts)
  synced = 0
  Dir.glob(File.join(ROOT, "assets/scores/**/*.zip")).sort.each do |zip|
    loose = zip.sub(/\.zip\z/, ".score")
    label = zip.sub("#{ROOT}/assets/scores/", "")
    next if opts[:only] && !label.include?(opts[:only])

    unless File.file?(loose)
      puts "  no loose copy  #{label}"
      next
    end

    member = `unzip -Z1 #{zip.inspect} '*.score' 2>/dev/null`.lines.map(&:strip).first
    unless member
      puts "  no member      #{label}"
      next
    end

    Dir.mktmpdir do |tmp|
      system("unzip", "-qoj", zip, member, "-d", tmp, out: File::NULL)
      inside = File.join(tmp, File.basename(member))
      if File.binread(inside) == File.binread(loose)
        puts "  up to date     #{label}"
        next
      end

      # Keep the member's own name and place inside the archive: `zip` replaces
      # the entry at exactly the path it is given.
      staged = File.join(tmp, member)
      FileUtils.mkdir_p(File.dirname(staged))
      FileUtils.cp(loose, staged)
      Dir.chdir(tmp) { system("zip", "-q", zip, member) or abort "#{label}: zip failed" }
      synced += 1
      puts "  synced         #{label}  (#{File.size(loose)} bytes)"
    end
  end
  puts
  puts "#{synced} archive(s) updated from their loose .score"
end

# score stores a media path absolutely when it cannot express it any other way,
# which bakes the author's home directory into a published example. Paths that
# happen to live under the user library are the easy half: rewriting them to
# <LIBRARY>: makes them resolve for anyone who has the same package installed,
# which is what score would have written had the library root been known when
# the file was saved.
#
# Whatever is left points outside both the project and the library, and cannot
# be fixed by rewriting -- the media has to be vendored into an archive or the
# example changed to use something published.
def cmd_relativize(opts)
  root = opts[:library_root]&.chomp("/")
  abort "relativize needs --library-root <path to the user library>" unless root

  rewritten = 0
  unresolved = Hash.new { |h, k| h[k] = [] }

  each_published_document do |label, path|
    text = File.read(path)
    doc = JSON.parse(text)

    changed = 0
    walk_strings(doc) do |s|
      next s unless looks_like_absolute_path?(s)
      abs = s.start_with?("~/") ? File.join(Dir.home, s[2..]) : s
      if abs.start_with?("#{root}/")
        changed += 1
        "<LIBRARY>:#{abs.delete_prefix("#{root}/")}"
      else
        unresolved[label] << s
        s
      end
    end

    next false if changed.zero?
    if opts[:dry_run]
      puts "  would rewrite  #{label} (#{changed} path(s))"
      next false
    end
    write_json(path, doc)
    rewritten += 1
    puts "  rewrote        #{label} (#{changed} path(s))"
    true
  end

  puts
  puts "#{rewritten} document(s) rewritten"
  unless unresolved.empty?
    puts
    puts "still absolute -- these need the media vendored or the example changed:"
    unresolved.each do |label, refs|
      puts "  #{label}"
      refs.uniq.each { |r| puts "      #{r}" }
    end
  end
end

# A document holds plenty of strings that begin with a slash and are not paths:
# a GLSL or Faust source whose first line is a `//` comment, an OSC address, a
# regular expression. A path is one line, starts at the root or at ~, and names
# a file with an extension.
def looks_like_absolute_path?(s)
  return false if s.include?("\n") || s.length > 4096
  return false if s.start_with?("//")
  return false unless s.start_with?("/") || s.start_with?("~/")
  !File.extname(s).empty?
end

# Rewrites every string in the document tree through `block`.
def walk_strings(node, &block)
  case node
  when Hash then node.each { |k, v| node[k] = walk_strings(v, &block) }
  when Array then node.map! { |v| walk_strings(v, &block) }
  when String then return block.call(node)
  end
  node
end

# Every document the site publishes: loose scores, plus the member inside each
# archive. Yields [label, path]; the block returns whether it changed the file.
def each_published_document
  archives = Dir.glob(File.join(ROOT, "assets/scores/**/*.zip")).sort
  archived = archives.map { |z| z.sub(/\.zip\z/, ".score") }.to_set

  archives.each do |zip|
    label = zip.sub("#{ROOT}/assets/scores/", "")
    member = `unzip -Z1 #{zip.inspect} '*.score' 2>/dev/null`.lines.map(&:strip).first
    next unless member
    Dir.mktmpdir do |tmp|
      system("unzip", "-qoj", zip, member, "-d", tmp, out: File::NULL)
      inside = File.join(tmp, File.basename(member))
      next unless yield("#{label}!#{member}", inside)
      staged = File.join(tmp, member)
      FileUtils.mkdir_p(File.dirname(staged))
      FileUtils.cp(inside, staged) unless staged == inside
      Dir.chdir(tmp) { system("zip", "-q", zip, member) or abort "#{label}: zip failed" }
    end
  end

  Dir.glob(File.join(ROOT, "assets/scores/**/*.score")).sort.each do |f|
    next if archived.include?(f)
    yield(f.sub("#{ROOT}/assets/scores/", ""), f)
  end
end

# score::knownPlatforms(), in the same order.
PLATFORMS = %w[windows macos linux bsd android ios web].freeze

# Writes the Platforms whitelist of a document: the platforms whose build has
# everything the score needs. A document that runs everywhere stores nothing,
# so `--not web` is spelled out as the six others rather than as an exclusion.
def cmd_platforms(opts)
  abort "platforms needs --only <id>" unless opts[:only]

  wanted =
      if opts[:set]
        opts[:set].split(/[ ,]+/).reject(&:empty?)
      elsif opts[:not]
        excluded = opts[:not].split(/[ ,]+/).reject(&:empty?)
        unknown = excluded - PLATFORMS
        abort "unknown platform(s): #{unknown.join(", ")}" unless unknown.empty?
        PLATFORMS - excluded
      else
        abort "platforms needs --set <list> or --not <list>"
      end
  unknown = wanted - PLATFORMS
  abort "unknown platform(s): #{unknown.join(", ")}" unless unknown.empty?

  value = wanted.sort_by { |p| PLATFORMS.index(p) }
  value = [] if value.size == PLATFORMS.size
  stored = value.join(" ")

  ex = examples.find { |e| e.id == opts[:only] } or abort "no such example: #{opts[:only]}"
  with_score_document(ex) do |path|
    doc = JSON.parse(File.read(path))
    info = project_info(doc) or abort "#{ex.id}: no project info; run `prepare` first"
    if info["Platforms"].to_s == stored
      puts "  unchanged  #{ex.id}"
      next false
    end
    info["Platforms"] = stored
    write_json(path, doc)
    puts "  #{ex.id}: runs on #{stored.empty? ? "everything" : stored}"
    true
  end
end

# Fills in the descriptions of the scores that have no documentation page, from
# script/examples/descriptions.yml. A score that already describes itself keeps
# what it has unless --force is given.
def cmd_describe(opts)
  file = File.join(__dir__, "descriptions.yml")
  texts = YAML.safe_load(File.read(file))

  known = examples.map(&:id).to_set
  if (stale = texts.keys.reject { |k| known.include?(k) }).any?
    warn "descriptions.yml names #{stale.size} score(s) that are not published:"
    stale.each { |s| warn "  #{s}" }
  end

  written = 0
  examples.each do |ex|
    next if opts[:only] && ex.id != opts[:only]
    text = texts[ex.id]&.strip
    next unless text

    with_score_document(ex) do |path|
      doc = JSON.parse(File.read(path))
      info = project_info(doc) or abort "#{ex.id}: no project info; run `prepare` first"
      if !info["Description"].to_s.strip.empty? && !opts[:force]
        puts "  has one   #{ex.id}"
        next false
      end
      next false if info["Description"].to_s == text

      info["Description"] = text
      write_json(path, doc)
      written += 1
      puts "  described #{ex.id}"
      true
    end
  end

  missing = examples.reject { |e| texts.key?(e.id) }
                    .select { |e| e.description.to_s.strip.empty? }
  puts
  puts "#{written} description(s) written"
  unless missing.empty?
    puts "#{missing.size} score(s) still have neither a page nor an entry here:"
    missing.each { |e| puts "  #{e.id}" }
  end
end

def cmd_capture(opts)
  abort "capture needs --score <path to ossia-score>" unless opts[:score]
  abort "no such binary: #{opts[:score]}" unless File.executable?(opts[:score])

  # score is driven on a private display and with a private configuration, so a
  # capture run cannot disturb the desktop or rewrite the user's own settings.
  Dir.mktmpdir("score-capture") do |home|
    env = {
      "XDG_CONFIG_HOME" => home,
      "SCORE_CAPTURE_SETTLE_MS" => opts[:settle].to_s,
      "QT_QPA_PLATFORM" => nil, # let xvfb-run provide a real X display
    }

    examples.each do |ex|
      next if opts[:only] && ex.id != opts[:only]

      with_score_document(ex) do |path|
        before = project_info(JSON.parse(File.read(path)))&.fetch("Thumbnail", "")
        ok = system(
          env, "xvfb-run", "-a", "--server-args=-screen 0 #{opts[:geometry]}x24",
          opts[:score], path, "--script", CAPTURE_SCRIPT,
          out: File::NULL, err: File::NULL)

        after = project_info(JSON.parse(File.read(path)))&.fetch("Thumbnail", "")
        size = png_size(after)
        if !ok
          puts "  FAILED     #{ex.id} (score exited non-zero)"
        elsif size.nil?
          puts "  no capture #{ex.id} (view never painted? raise --settle)"
        elsif after == before
          puts "  unchanged  #{ex.id} #{size[0]}x#{size[1]}"
        else
          puts "  captured   #{ex.id} #{size[0]}x#{size[1]}"
        end
        after != before
      end
    end
  end
end

# --- entry point ------------------------------------------------------------

opts = { settle: 4000, geometry: "1920x1080" }
parser = OptionParser.new do |o|
  o.banner = "usage: ruby script/examples/metadata.rb <status|prepare|describe|capture|sync|relativize|platforms> [options]"
  o.on("--force", "overwrite project information that is already set") { opts[:force] = true }
  o.on("--author NAME", "set the Author field (shown as the card subtitle)") { |v| opts[:author] = v }
  o.on("--only ID", "act on one example, e.g. basics/osc") { |v| opts[:only] = v }
  o.on("--score PATH", "ossia-score binary to drive (capture)") { |v| opts[:score] = v }
  o.on("--settle MS", Integer, "event loop time before saving (capture, default 4000)") { |v| opts[:settle] = v }
  o.on("--library-root PATH", "user library root (relativize)") { |v| opts[:library_root] = v }
  o.on("--dry-run", "report what would change without writing (relativize)") { opts[:dry_run] = true }
  o.on("--set LIST", "platforms the score runs on (platforms)") { |v| opts[:set] = v }
  o.on("--not LIST", "platforms it does not run on (platforms)") { |v| opts[:not] = v }
  o.on("--geometry WxH", "virtual screen size (capture, default 1920x1080)") { |v| opts[:geometry] = v }
end
parser.parse!

case ARGV.shift
when "status" then cmd_status(opts)
when "prepare" then cmd_prepare(opts)
when "capture" then cmd_capture(opts)
when "sync" then cmd_sync(opts)
when "relativize" then cmd_relativize(opts)
when "platforms" then cmd_platforms(opts)
when "describe" then cmd_describe(opts)
else
  puts parser
  exit 1
end
