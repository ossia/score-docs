require 'jekyll-wikirefs'

# Monkey patch to handle missing documents gracefully
module WikiRefsPatch
  def context_fm_data
    if self.context_doc.nil?
      # Log the missing document reference
      Jekyll.logger.warn "WikiRefs:", "Missing context document for wikilink"
      Jekyll.logger.warn "WikiRefs:", "  -> Filename: #{@filename}" if @filename
      Jekyll.logger.warn "WikiRefs:", "  -> Label: #{@label_txt}" if @label_txt
      Jekyll.logger.warn "WikiRefs:", "  -> Link type: #{@link_type}" if @link_type
      Jekyll.logger.warn "WikiRefs:", "  -> Context filename: #{@context_filename}" if @context_filename
      Jekyll.logger.warn "WikiRefs:", "  -> Full text: #{self.md_regex}" rescue nil

      # Return minimal hash to prevent crash
      return {
        'type' => @link_type || 'unknown',
        'url' => ''  # Empty URL instead of nil
      }
    end

    # Call original method if context_doc exists
    super
  end
end

# Apply the patch after the class is loaded
Jekyll::Hooks.register :site, :after_init do |site|
  Jekyll::WikiRefs::WikiLinkInline.prepend(WikiRefsPatch)
end