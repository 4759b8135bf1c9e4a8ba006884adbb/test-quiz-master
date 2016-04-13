require 'rails_helper'

describe 'Question time...' do
  let(:question) { FactoryGirl.create(:question) }

  before(:each) do
    visit "/questions/#{question.id}"
  end

  describe 'Submit answer' do
    before(:each) do
      within("form") do
        fill_in 'answer_answer', with: answer_value

        click_button "Submit answer"
      end
    end

    context 'When input "" to Answer' do
      let(:answer_value) { "" }

      it 'displays "Your answer is wrong."' do
        expect(page).to have_css(".alert", text: "Your answer is wrong.")
      end

      it 'displays the current path /questions/:id/answer' do
        expect(page).to have_current_path("/questions/#{question.id}/answer")
      end
    end

    context 'When input right answer to Answer' do
      let(:answer_value) { question.answer }

      it 'displays "Your answer is right."' do
        expect(page).to have_css(".alert", text: "Your answer is right.")
      end

      it 'displays the current path /questions/:id/answer' do
        expect(page).to have_current_path("/questions/#{question.id}/answer")
      end
    end
  end
end
