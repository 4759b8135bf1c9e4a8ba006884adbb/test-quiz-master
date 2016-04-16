shared_examples_for :increases_the_question_count do
  it "increases the question count" do
    expect { subject }.to change { Question.count }.by(1)
  end
end

shared_examples_for :does_not_change_the_question_count do
  it "does not change the question count" do
    expect { subject }.not_to change { Question.count }
  end
end
