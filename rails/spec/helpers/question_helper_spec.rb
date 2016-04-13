require 'rails_helper'

describe QuestionsHelper do
  let(:question) { FactoryGirl.create(:question) }

  describe 'extract_title' do
    subject {
      helper.extract_title(
        Question.new(
          FactoryGirl.attributes_for(:question, question: question_value)
        )
      )
    }

    context 'when Question#question is nil' do
      let(:question_value) { nil }
      it { is_expected.to eq "" }
    end

    context 'when Question#question is ""' do
      let(:question_value) { "" }
      it { is_expected.to eq "" }
    end

    context 'when Question#question is "# x"' do
      let(:question_value) { "# x" }
      it { is_expected.to eq "x" }
    end

    context 'when Question#question is "***" like nothing left after html-convert and strip tags' do
      let(:question_value) { "***" }

      it "returns first line of raw markdown" do
        is_expected.to eq "***"
      end
    end

    context 'when Question#question is "***\r\nx"' do
      let(:question_value) { "***\r\nx" }

      it "extracts first present text after html-convert and strip tags" do
        is_expected.to eq "x"
      end
    end
  end
end
