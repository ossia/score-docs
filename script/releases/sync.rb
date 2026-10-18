#!/usr/bin/env ruby
# frozen_string_literal: true

require "optparse"
require_relative "../../lib/score_releases"

options = { root: File.expand_path("../..", __dir__) }
source = nil
check = false
parser = OptionParser.new do |opts|
  opts.banner = "Usage: ruby script/releases/sync.rb [options]"
  opts.on("--source-json FILE", "Use saved gh api --paginate --slurp full+json response") { |value| source = value }
  opts.on("--root DIRECTORY", "Archive repository root") { |value| options[:root] = value }
  opts.on("--cache-dir DIRECTORY", "Persistent download staging outside the site") { |value| options[:cache_dir] = value }
  opts.on("--refresh-media", "Refetch mutable media URLs instead of reusing verified bytes") { options[:refresh_media] = true }
  opts.on("--check", "Check snapshot and every media hash offline") { check = true }
  opts.on("-h", "--help") { puts opts; exit }
end
begin
  parser.parse!
  raise OptionParser::InvalidArgument, ARGV.join(" ") unless ARGV.empty?
  importer = ScoreReleases::Importer.new(**options)
  data = if check
           importer.check
         else
           importer.sync(source ? JSON.parse(File.read(source)) : ScoreReleases.fetch_releases)
         end
  puts "#{check ? 'Verified' : 'Synchronized'} #{data.fetch('releases').length} releases and #{data.fetch('media').length} media URLs."
rescue ScoreReleases::Error, OptionParser::ParseError, JSON::ParserError, Errno::ENOENT, KeyError => e
  warn "Release archive: #{e.message}"
  exit 1
end
