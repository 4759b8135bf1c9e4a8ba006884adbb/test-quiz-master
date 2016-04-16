module QuestionsHelper
  # Extract the plain text of the first line of the question.
  #
  # This is used to display the question list.
  #
  # @example extract title from "# foo\r\n\r\nbar"
  #   puts extract_title("#foo\r\n\r\nbar") #=> "foo"
  #
  # @param  [Question] question Question model
  # @return [String]
  def extract_title(question)
    return "" unless question.question.present?

    lines = question.question.lines.map(&:strip)
    title = lines.map { |text| strip_tags markdown(text) }.select(&:present?).first
    title || lines.first
  end
end
