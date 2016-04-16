class Question < ActiveRecord::Base

  validates_presence_of :question
  validates_presence_of :answer

  def initialize(attrs = {})
    super
    self.answer = sanitize(attrs[:answer])
  end

  def is_correct?(submission)
    answer == submission
  end

  # Returns whether the argument value matches the answer.
  #
  # If the answer is number string, and the argument value is number word,
  # It assumes that matches, and vice versa.
  #
  # Before matching, the argument value is sanitized by removing leading/trailing
  # whitespaces and squeezing blank between characters.
  #
  # @param  [String] submission
  # @return [Boolean]
  def is_correct?(submission)
    return true if /\A#{answer}\z/i === sanitize(submission)
    return true if is_number?(submission) && submission.to_f.to_words == answer
    return true if is_number?(answer)     && answer.to_f.to_words     == submission
    false
  end

  private

  def is_number?(string)
    Float(string)
    true
  rescue ArgumentError
    false
  end

  def sanitize(string)
    string.to_s.strip.split.join(" ")
  end
end
