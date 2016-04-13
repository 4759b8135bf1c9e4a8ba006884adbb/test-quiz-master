require 'rails_helper'

describe 'Edit Question' do
  let(:question) { FactoryGirl.create(:question) }

  before(:each) do
    visit "/questions/#{question.id}/edit"
  end

  describe 'Update Question' do
    before(:each) do
      within("form#edit_question_#{question.id}") do
        fill_in 'question_question', with: question_value
        fill_in 'question_answer',   with: answer_value

        click_button "Update Question"
      end
    end

    context 'When input "" to Question, "" to Answer' do
      let(:question_value) { "" }
      let(:answer_value)   { "" }

      it 'displays "Question can\'t be blank"' do
        expect(page).to have_css(".alert", text: "Question can't be blank")
      end

      it 'displays "Answer can\'t be blank"' do
        expect(page).to have_css(".alert", text: "Answer can't be blank")
      end

      it 'displays the current path /questions/:id' do
        expect(page).to have_current_path("/questions/#{question.id}")
      end
    end

    context 'When input "What is the closest planet to the Sun?" to Question, "Mercury" to Answer' do
      let(:question_value) { "What is the closest planet to the Sun?" }
      let(:answer_value)   { "Mercury" }

      it 'displays "Question saved successfully."' do
        expect(page).to have_css(".alert", text: "Question saved successfully.")
      end

      it 'displays the current path /' do
        expect(page).to have_current_path('/')
      end

      it 'displays "What is the closest planet to the Sun?"' do
        expect(page).to have_css("ul > li > a", text: question_value)
      end
    end
  end
end
