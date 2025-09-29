require 'jekyll-wikirefs'

Jekyll.logger.info "WikiRefs Patch:", "Loading enhanced wikiref patches..."

# Monkey patch the DocManager directly to add title-based matching
module Jekyll
  module WikiRefs
    class DocManager
      alias_method :original_get_doc_by_fname, :get_doc_by_fname if method_defined?(:get_doc_by_fname)

      def get_doc_by_fname(filename)
        Jekyll.logger.error("Jekyll-WikiRefs: Must provide a 'filename'") if filename.nil? || filename.empty?

        # Debug: log that our patched method is being called
        Jekyll.logger.debug "WikiRefs Patch:", "get_doc_by_fname called with: #{filename}"

        # Strip any surrounding quotes that might have been included in the wikilink
        # This handles cases like [["Device explorer"]] where the user included quotes
        cleaned_filename = filename.strip.gsub(/^["']|["']$/, '')

        # First try to match by filename (existing behavior)
        docs = @md_docs.select{ |d| File.basename(d.basename, File.extname(d.basename)) == cleaned_filename }

        # If no match by filename, try to match by title
        if docs.nil? || docs.empty?
          docs = get_docs_by_title(cleaned_filename)
        end

        return nil if docs.nil? || docs.empty? || docs.size > 1
        return docs[0]
      end

      def get_docs_by_title(search_term)
        return [] if search_term.nil? || search_term.empty?

        # Clean up the search term - remove any quotes that might be present
        cleaned_search_term = search_term.strip.gsub(/^["']|["']$/, '')

        matching_docs = []

        @md_docs.each do |doc|
          # Skip if document doesn't have a title
          next if doc.data.nil? || doc.data['title'].nil?

          doc_title = doc.data['title'].to_s

          # Exact match (case-insensitive)
          if doc_title.downcase == cleaned_search_term.downcase
            matching_docs << doc
            next
          end

          # Match if search term is the first word of the title (case-insensitive)
          # This handles cases like "Shmdata" matching "Shmdata devices"
          first_word = doc_title.split(/\s+/).first
          if first_word && first_word.downcase == cleaned_search_term.downcase
            matching_docs << doc
            next
          end

          # Match if the entire search term appears in the title (case-insensitive)
          # This handles cases like "Shmdata devices" matching "Shmdata devices"
          if doc_title.downcase.include?(cleaned_search_term.downcase)
            matching_docs << doc
          end
        end

        # If we have multiple matches, prioritize exact matches
        if matching_docs.size > 1
          exact_matches = matching_docs.select { |doc| doc.data['title'].to_s.downcase == cleaned_search_term.downcase }
          return exact_matches unless exact_matches.empty?

          # Then prioritize first-word matches
          first_word_matches = matching_docs.select do |doc|
            first_word = doc.data['title'].to_s.split(/\s+/).first
            first_word && first_word.downcase == cleaned_search_term.downcase
          end
          return first_word_matches unless first_word_matches.empty?
        end

        return matching_docs
      end
    end
  end
end

# Monkey patch to handle missing documents gracefully with line number context
module WikiRefsPatch
  def context_fm_data
    if self.context_doc.nil?
      # Debug logging
      Jekyll.logger.debug "WikiRefs Patch:", "context_fm_data called - context_filename: #{@context_filename}, filename: #{@filename}"

      # Try to get line number context
      line_info = get_line_number_context(@context_filename, @filename)

      # Log the missing document reference with context
      Jekyll.logger.warn "WikiRefs:", "Missing context document for wikilink"
      Jekyll.logger.warn "WikiRefs:", "  -> Filename: #{@filename}" if @filename
      Jekyll.logger.warn "WikiRefs:", "  -> Label: #{@label_txt}" if @label_txt
      Jekyll.logger.warn "WikiRefs:", "  -> Link type: #{@link_type}" if @link_type
      Jekyll.logger.warn "WikiRefs:", "  -> Context filename: #{@context_filename}" if @context_filename
      Jekyll.logger.warn "WikiRefs:", "  -> Location: #{line_info}" if line_info
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

  private

  def get_line_number_context(context_filename, link_text)
    return nil if context_filename.nil? || link_text.nil?

    # Try to find the source file
    # Note: @doc_mngr might not be accessible here, let's try to find the file directly
    # Search in common locations
    possible_paths = [
      "docs/#{context_filename}.md",
      "_posts/#{context_filename}.md",
      "#{context_filename}.md",
      "_pages/#{context_filename}.md",
      "docs/reference-manual/#{context_filename}.md"
    ]

    # Find the first existing file
    file_path = possible_paths.find { |path| File.exist?(path) }

    # If not found, search recursively
    if file_path.nil?
      Dir.glob("**/*#{context_filename}*.md").each do |path|
        if File.basename(path, ".md").downcase == context_filename.downcase
          file_path = path
          break
        end
      end
    end

    return nil if file_path.nil? || !File.exist?(file_path)

    # Read the file and find the line containing the wikilink
    lines = File.readlines(file_path)
    lines.each_with_index do |line, index|
      # Check for various wikilink patterns
      if line.include?("[[#{link_text}]]") ||
         line.include?("[[\"#{link_text}\"]]") ||
         line.include?("[['#{link_text}']]") ||
         line.include?("[[#{link_text}|")
        return "#{file_path}:#{index + 1}"
      end
    end

    return file_path
  rescue => e
    return nil
  end
end

# Monkey patch for WikiLinkBlock as well
module WikiRefsBlockPatch
  def context_fm_data
    if self.context_doc.nil?
      # Try to get line number context for block links
      line_info = get_line_number_context_for_block(@context_filename, @link_type)

      Jekyll.logger.warn "WikiRefs:", "Missing context document for wikilink block"
      Jekyll.logger.warn "WikiRefs:", "  -> Link type: #{@link_type}" if @link_type
      Jekyll.logger.warn "WikiRefs:", "  -> Filenames: #{@filenames.join(', ')}" if @filenames && !@filenames.empty?
      Jekyll.logger.warn "WikiRefs:", "  -> Context filename: #{@context_filename}" if @context_filename
      Jekyll.logger.warn "WikiRefs:", "  -> Location: #{line_info}" if line_info

      # Return minimal hash to prevent crash
      return {
        'type' => @link_type || 'unknown',
        'urls' => []
      }
    end

    super
  end

  private

  def get_line_number_context_for_block(context_filename, link_type)
    return nil if context_filename.nil?

    # Try to find the source file directly
    possible_paths = [
      "docs/#{context_filename}.md",
      "_posts/#{context_filename}.md",
      "#{context_filename}.md",
      "_pages/#{context_filename}.md",
      "docs/reference-manual/#{context_filename}.md"
    ]

    # Find the first existing file
    file_path = possible_paths.find { |path| File.exist?(path) }

    # If not found, search recursively
    if file_path.nil?
      Dir.glob("**/*#{context_filename}*.md").each do |path|
        if File.basename(path, ".md").downcase == context_filename.downcase
          file_path = path
          break
        end
      end
    end

    return nil if file_path.nil? || !File.exist?(file_path)

    # Look for block link patterns like "type::"
    lines = File.readlines(file_path)
    lines.each_with_index do |line, index|
      if link_type && line.include?("#{link_type}::")
        return "#{file_path}:#{index + 1}"
      end
    end

    return file_path
  rescue => e
    return nil
  end
end

# Apply the patches after the classes are loaded
Jekyll::Hooks.register :site, :after_init do |site|
  Jekyll.logger.info "WikiRefs Patch:", "Applying WikiLinkInline and WikiLinkBlock patches..."
  Jekyll::WikiRefs::WikiLinkInline.prepend(WikiRefsPatch)
  Jekyll::WikiRefs::WikiLinkBlock.prepend(WikiRefsBlockPatch) if defined?(Jekyll::WikiRefs::WikiLinkBlock)
  Jekyll.logger.info "WikiRefs Patch:", "Patches applied successfully!"
end
