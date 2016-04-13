module QuestionsHelper
  def extract_title(question)
    return "" unless question.question.present?

    lines = question.question.lines.map(&:strip)
    title = lines.map { |text| strip_tags markdown(text) }.select(&:present?).first
    title || lines.first
  end
end
