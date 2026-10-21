# Images in the documentation pages: the first one of the main content is
# fetched with high priority (it is often the largest paint), the others are
# loaded lazily, so that a page with many screenshots does not download all of
# them before showing the first one.
module LazyImages
  IMG = /<img\b(?![^>]*\bloading=)[^>]*>/

  def self.process(html)
    main = html.index("<main")
    return html unless main

    head = html[0...main]
    body = html[main..]
    first = true
    body = body.gsub(IMG) do |tag|
      if first
        first = false
        tag.include?("fetchpriority=") ? tag : tag.sub("<img", '<img fetchpriority="high"')
      else
        tag.sub("<img", '<img loading="lazy" decoding="async"')
      end
    end
    head + body
  end
end

Jekyll::Hooks.register [:pages, :documents], :post_render do |doc|
  next unless doc.output_ext == ".html" && doc.output
  doc.output = LazyImages.process(doc.output)
end
