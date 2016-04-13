require 'rails_helper'

describe Question, :type => :model do
  describe 'is_correct?' do
    it 'requires the correct answer' do
      expect(Question.new(answer: "Paris").is_correct?("London")).to be false
      expect(Question.new(answer: "Paris").is_correct?("Paris")).to be true
    end

    it 'requires the perfect matching' do
      expect(Question.new(answer: "Paris").is_correct?("_Paris")).to be false
      expect(Question.new(answer: "Paris").is_correct?("Paris_")).to be false
    end

    it 'ignores whitespace' do
      expect(Question.new(answer: "  the  moon").is_correct?("the moon")).to be true
    end

    it 'ignores case' do
      expect(Question.new(answer: "France").is_correct?("france")).to be true
    end

    it 'understands numbers as words' do
      expect(Question.new(answer: "7").is_correct?("seven")).to be true
      expect(Question.new(answer: "seven").is_correct?("7")).to be true
      expect(Question.new(answer: "7.1").is_correct?("seven and one tenth")).to be true
      expect(Question.new(answer: "seven and one tenth").is_correct?("7.1")).to be true
    end
  end

  describe 'sanitize' do
    subject { FactoryGirl.build(:question).send(:sanitize, arg) }

    context 'when nil is specified' do
      let(:arg) { nil }
      it { is_expected.to eq "" }
    end

    context 'when " x" is specified' do
      let(:arg) { " x" }
      it { is_expected.to eq "x" }
    end

    context 'when "x " is specified' do
      let(:arg) { "x " }
      it { is_expected.to eq "x" }
    end

    context 'when " x " is specified' do
      let(:arg) { " x " }
      it { is_expected.to eq "x" }
    end

    context 'when "x  y" is specified' do
      let(:arg) { "x  y" }
      it { is_expected.to eq "x y" }
    end
  end
end
