class Question < ActiveRecord::Base

  validates_presence_of :question
  validates_presence_of :answer

  # Returns whether the argument value matches the answer. (case-insensitive)
  #
  # If the answer is number string, and the argument value is number word,
  # It assumes that matches, and vice versa.
  #
  # Before matching, the answer and the argument value are sanitized
  # by removing leading/trailing whitespaces and squeezing blank between characters.
  #
  # @param  [String] submission
  # @return [Boolean]
  def is_correct?(submission)
    sanitized_answer     = sanitize(answer)
    sanitized_submission = sanitize(submission)

    return true if sanitized_answer.downcase == sanitized_submission.downcase
    return true if is_number?(sanitized_submission) && sanitized_submission.to_f.to_words == sanitized_answer
    return true if is_number?(sanitized_answer)     && sanitized_answer.to_f.to_words     == sanitized_submission
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
    string.to_s.strip.squeeze(" ")
  end
end
