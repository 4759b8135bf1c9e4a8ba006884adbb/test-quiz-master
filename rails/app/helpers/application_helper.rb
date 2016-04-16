module ApplicationHelper
  # Converts Markdown to HTML
  #
  # @example converts "# foo\r\n\r\nbar"
  #   puts markdown("# foo\r\n\r\nbar") #=> "<h1>foo</h1>\n\n<p>bar</p>\n"
  #
  # @param  [String] string Markdown format text
  # @return [String] HTML format text
  def markdown(string)
    Markdown.new(string).to_html.chomp
  end
end
