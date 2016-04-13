require 'rails_helper'

describe 'New Question' do
  before(:each) do
    visit "/questions/new"
  end

  describe 'Create Question' do
    before(:each) do
      within('form#new_question') do
        fill_in 'question_question', with: question_value
        fill_in 'question_answer',   with: answer_value

        click_button "Create Question"
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

      it 'displays the current path /questions' do
        expect(page).to have_current_path('/questions')
      end
    end

    context 'When input "What is the capital of Japan?" to Question, "Tokyo" to Answer' do
      let(:question_value) { "What is the capital of Japan?" }
      let(:answer_value)   { "Tokyo" }

      it 'displays "Question created successfully."' do
        expect(page).to have_css(".alert", text: "Question created successfully.")
      end

      it 'displays the current path /' do
        expect(page).to have_current_path('/')
      end

      it 'displays "What is the capital of Japan?" in the question list' do
        expect(page).to have_css("ul > li > a", text: question_value)
      end
    end
  end
end
