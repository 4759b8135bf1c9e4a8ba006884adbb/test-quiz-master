module ApplicationHelper
  def markdown(string)
    Markdown.new(string).to_html.chomp
  end
end
