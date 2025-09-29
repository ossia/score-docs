require 'jekyll-wikirefs'


# Monkey patch the DocManager directly to add title-based matching
module Jekyll
  module WikiRefs
    class DocManager
      alias_method :original_get_doc_by_fname, :get_doc_by_fname if method_defined?(:get_doc_by_fname)

      # Store context for better error messages
      def set_context(context_filename)
        @current_context = context_filename
        Jekyll.logger.debug "WikiRefs:", "set_context called with: #{context_filename}"
      end

      def get_doc_by_fname(filename)
        Jekyll.logger.error("Jekyll-WikiRefs: Must provide a 'filename'") if filename.nil? || filename.empty?

        # Keep track of the calling context for better error messages
        @last_search_term = filename

        # Strip any surrounding quotes that might have been included in the wikilink
        # This handles cases like [["Device explorer"]] where the user included quotes
        cleaned_filename = filename.strip.gsub(/^["']|["']$/, '')

        # First try to match by filename (existing behavior)
        docs = @md_docs.select{ |d| File.basename(d.basename, File.extname(d.basename)) == cleaned_filename }

        # If no match by filename, try to match by title
        if docs.nil? || docs.empty?
          docs = get_docs_by_title(cleaned_filename)
        end

        if docs.size > 1
          # Count how many docs have the exact filename match
          exact_filename_matches = docs.select { |doc|
            File.basename(doc.basename, File.extname(doc.basename)).downcase == cleaned_filename.downcase
          }

          # If there's exactly ONE file with the exact filename, use it without warning
          if exact_filename_matches.size == 1
            Jekyll.logger.debug "WikiRefs:", "Found unambiguous exact filename match for '#{cleaned_filename}': #{exact_filename_matches[0].basename}"
            return exact_filename_matches[0]
          end

          # If there are multiple exact filename matches or no exact matches, we need to disambiguate
          # First, check if one of the matches has both exact filename AND exact title match
          exact_title_and_filename = docs.find { |doc|
            basename = File.basename(doc.basename, File.extname(doc.basename))
            basename.downcase == cleaned_filename.downcase &&
            doc.data['title'] && doc.data['title'].downcase == cleaned_filename.downcase
          }

          # If not, use the first exact filename match if any
          exact_filename_match = exact_title_and_filename || exact_filename_matches.first

          # Get the calling context with line number
          line_info = nil
          if @current_context
            line_info = get_line_number_for_link(@current_context, cleaned_filename)
          end
          context_info = line_info ? " (#{line_info})" : (@current_context ? " (in document: #{@current_context})" : "")

          # Show warning for ambiguous matches
          if exact_filename_match
            selection_reason = exact_title_and_filename ? "exact title + filename match" : "exact filename match"
            Jekyll.logger.debug "WikiRefs:", "DEBUG: cleaned_filename='#{cleaned_filename}', context='#{@current_context}', line_info='#{line_info}'"
            Jekyll.logger.warn "WikiRefs:", "Multiple matches found for '#{cleaned_filename}'#{context_info}:"
            docs.each do |doc|
              marker = (doc == exact_filename_match) ? " <- SELECTED (#{selection_reason})" : ""
              # Show relative path if there are multiple files with same basename
              display_name = docs.count { |d| d.basename == doc.basename } > 1 ? doc.relative_path : doc.basename
              Jekyll.logger.warn "WikiRefs:", "  - #{display_name} (title: #{doc.data['title']})#{marker}"
            end
            return exact_filename_match
          end

          Jekyll.logger.warn "WikiRefs:", "Multiple matches found for '#{cleaned_filename}'#{context_info}:"
          docs.each do |doc|
            # Show relative path if there are multiple files with same basename
            display_name = docs.count { |d| d.basename == doc.basename } > 1 ? doc.relative_path : doc.basename
            Jekyll.logger.warn "WikiRefs:", "  - #{display_name} (title: #{doc.data['title']})"
          end
          # Show relative path if ambiguous
          first_display_name = docs.count { |d| d.basename == docs[0].basename } > 1 ? docs[0].relative_path : docs[0].basename
          Jekyll.logger.warn "WikiRefs:", "Using first match: #{first_display_name}"
          return docs[0]
        end

        return nil if docs.nil? || docs.empty?
        return docs[0]
      end

      def get_line_number_for_link(context_filename, link_text)
        return nil if context_filename.nil? || link_text.nil?

        # Search in common locations
        possible_paths = [
          "docs/#{context_filename}.md",
          "_posts/#{context_filename}.md",
          "#{context_filename}.md",
          "_pages/#{context_filename}.md",
          "docs/reference-manual/#{context_filename}.md",
          "docs/in-depth/#{context_filename}.md",
          "docs/reference-manual/panels/#{context_filename}.md",
          "docs/reference-manual/processes/#{context_filename}.md",
          "docs/reference-manual/devices/#{context_filename}.md"
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
            Jekyll.logger.debug "WikiRefs:", "Found link '#{link_text}' at line #{index + 1}: #{line.strip}"
            return "#{file_path}:#{index + 1}"
          end
        end

        # If we didn't find the link, it might be because context='midi' when midi.md is processing its own links
        Jekyll.logger.debug "WikiRefs:", "Could not find '[[#{link_text}]]' in #{file_path}"
        # Return just the file path without line number if we couldn't find the exact line
        return "#{file_path}"
      rescue => e
        return nil
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
      # Try to get line number context
      line_info = get_line_number_context(@context_filename, @filename)

      # Log the missing document reference with context
      Jekyll.logger.warn "WikiRefs:", "Missing context document for wikilink"
      Jekyll.logger.warn "WikiRefs:", "  -> Filename: #{@filename}" if @filename
      Jekyll.logger.warn "WikiRefs:", "  -> Label: #{@label_txt}" if @label_txt
      Jekyll.logger.warn "WikiRefs:", "  -> Link type: #{@link_type}" if @link_type
      Jekyll.logger.warn "WikiRefs:", "  -> Context filename: #{@context_filename}" if @context_filename
      Jekyll.logger.warn "WikiRefs:", "  -> Location: #{line_info}" if line_info

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

# Patch WikiLinkInline to set context when resolving links
module WikiLinkContextPatch
  def linked_doc
    # Set context in doc_manager before resolving
    # @context_filename is the document that CONTAINS this wikilink
    @doc_mngr.set_context(@context_filename) if @doc_mngr.respond_to?(:set_context)
    super
  end

  def context_doc
    # Don't set context here - this is retrieving the source document itself
    super
  end

  def is_valid?
    result = super
    # If the link is invalid, log a warning
    if !result && @filename
      # Try to get line number context
      line_info = get_line_number_context(@context_filename, @filename)

      Jekyll.logger.warn "WikiRefs:", "Invalid/missing wikilink"
      Jekyll.logger.warn "WikiRefs:", "  -> Link text: #{@filename}" if @filename
      Jekyll.logger.warn "WikiRefs:", "  -> In document: #{@context_filename}" if @context_filename
      Jekyll.logger.warn "WikiRefs:", "  -> Location: #{line_info}" if line_info
    end
    result
  end

  private

  def get_line_number_context(context_filename, link_text)
    return nil if context_filename.nil? || link_text.nil?

    # Search in common locations
    possible_paths = [
      "docs/#{context_filename}.md",
      "_posts/#{context_filename}.md",
      "#{context_filename}.md",
      "_pages/#{context_filename}.md",
      "docs/in-depth/#{context_filename}.md",
      "docs/reference-manual/#{context_filename}.md"
    ]

    file_path = possible_paths.find { |path| File.exist?(path) }

    if file_path.nil?
      Dir.glob("**/*#{context_filename}*.md").each do |path|
        if File.basename(path, ".md").downcase == context_filename.downcase
          file_path = path
          break
        end
      end
    end

    return nil if file_path.nil? || !File.exist?(file_path)

    lines = File.readlines(file_path)
    lines.each_with_index do |line, index|
      if line.include?("[[#{link_text}]]") ||
         line.include?("[[\"#{link_text}\"]]") ||
         line.include?("[['#{link_text}']]") ||
         line.include?("[[#{link_text}|")
        return "#{file_path}:#{index + 1}"
      end
    end

    return "#{file_path}"
  rescue => e
    return nil
  end
end

# Apply the patches after the classes are loaded
Jekyll::Hooks.register :site, :after_init do |site|
  Jekyll::WikiRefs::WikiLinkInline.prepend(WikiRefsPatch)
  Jekyll::WikiRefs::WikiLinkInline.prepend(WikiLinkContextPatch)
  Jekyll::WikiRefs::WikiLinkBlock.prepend(WikiRefsBlockPatch) if defined?(Jekyll::WikiRefs::WikiLinkBlock)
end
