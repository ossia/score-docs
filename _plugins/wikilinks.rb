module Jekyll
  module Wikilinks
  class Wikilink
    def self.parse(text)
      inner = text[2..-3]
      name, title = inner.split('|', 2)
      self.new(name, title)
    end

    attr_accessor :name, :title
    attr_reader :match

    def initialize(name, title)
      @name = name.strip
      @title = title.strip if not title.nil?
    end

    def title
      if @title.nil?
        if not @match.nil?
          match_title @match
        else
          @name
        end
      else
        @title
      end
    end

    def match_title(m)
      if not m.data.nil? and m.data.include? 'title'
        m.data['title']
      end
    end

    def synonyms(m)
      if not m.data.nil? and m.data.include? 'wikilinks'
        m.data['wikilinks']
      else
        []
      end
    end

    def url
      if has_match?
        "#{Jekyll.sites[0].baseurl}#{@match.url}"
      else
        raise("Error: wiki link not found: #{@name}")
      end
    end

    def has_match?
      not @match.nil?
    end

    # TODO: also allow properties to specify a "wikilink title" to match against
    def match_post(posts)
      @match = posts.docs.find { |p| p.slug.downcase == @name.downcase or match_title(p) == name }
    end

    def match_page(pages)
      @match = pages.find do |p|
        p.basename.downcase == @name.downcase or
          p.basename.downcase.gsub(/[^\p{Alnum}]/, '').start_with? @name.downcase.gsub(/[^\p{Alnum}]/, '') or
          match_title(p) == name or
          synonyms(p).any? { |s| s == name }
      end
    end

    def markdown
      "[#{title}](#{url} \"#{@name.gsub(/[^\p{Alnum} ]/, '').strip()}\")"
    end
  end
end

  class BetterLinks < Jekyll::Converter
    priority :highest

    def matches(ext)
      ext.downcase == ".md"
    end

    def output_ext(ext)
      ".md"
    end

    def convert(content)
      pat = /\[\[([^\]]+?)\]\]/
      site = Jekyll.sites[0]
      content.gsub(pat) do |m|
        wl = Wikilinks::Wikilink.parse(m)
        wl.match_page(site.pages)
        wl.match_post(site.posts) unless wl.has_match?
        wl.markdown
      end
    end
  end
end
