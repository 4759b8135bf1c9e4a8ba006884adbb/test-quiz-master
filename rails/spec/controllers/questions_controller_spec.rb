require 'rails_helper'

RSpec.describe QuestionsController, :type => :controller do
  shared_context "when id that does not match any question is specified" do
    let(:id) { 999999999999 }
  end

  shared_context "when id that matches existent question is specified" do
    let(:id)       { question.id }
    let(:question) { FactoryGirl.create(:question) }
  end

  shared_examples_for :assigns_nil_to_question do
    it "assigns nil to @question" do
      subject
      expect(assigns(:question)).to be nil
    end
  end

  shared_examples_for :assigns_question_that_specified_by_id_to_question do
    it "assigns question that specified by id to @question" do
      subject
      expect(assigns(:question)).to eq question
    end
  end

  shared_examples_for :has_an_answer_presence_validation_error do
    it 'has an answer presence validation error' do
      subject
      expect(assigns(:question).errors.full_messages_for(:answer)).to include("Answer can't be blank")
    end
  end

  shared_examples_for :has_a_question_presence_validation_error do
    it 'has a question presence validation error' do
      subject
      expect(assigns(:question).errors.full_messages_for(:question)).to include("Question can't be blank")
    end
  end

  shared_examples_for :notices_question_created_successfully do
    it "notices_question_created_successfully" do
      subject
      expect(flash[:notice]).to eq "Question created successfully."
    end
  end

  shared_examples_for :notices_question_saved_successfully do
    it "notices_question_saved_successfully" do
      subject
      expect(flash[:notice]).to eq "Question saved successfully."
    end
  end

  describe "GET #index" do
    subject { get :index }

    context "when question does not exist" do
      it "assigns none to @questions" do
        subject
        expect(assigns(:questions)).to be_none
      end
      it_behaves_like :renders_the_index_template
    end

    context "when question exists" do
      let!(:question) { FactoryGirl.create(:question) }

      it "assigns the question in @questions" do
        subject
        expect(assigns(:questions)).to include(question)
      end
      it_behaves_like :renders_the_index_template
    end
  end

  describe "GET #show" do
    subject { get :show, params }

    let(:params) {
      {
        id: id
      }
    }

    context do
      include_context "when id that does not match any question is specified"

      it_behaves_like :assigns_nil_to_question
      it_behaves_like :renders_the_show_template
    end

    context do
      include_context "when id that matches existent question is specified"

      it_behaves_like :assigns_question_that_specified_by_id_to_question
      it_behaves_like :renders_the_show_template
    end
  end

  describe "GET #new" do
    subject { get :new }

    it "assigns a new question to @question" do
      subject
      expect(assigns(:question)).not_to be_persisted
    end

    it_behaves_like :renders_the_new_template
  end

  describe "POST #create" do
    subject { post :create, params }

    let(:params) {
      {
        question: {
          question: question_value,
          answer:   answer,
        }.compact,
      }.compact
    }
    let(:question_value) { FactoryGirl.attributes_for(:question)[:question] }
    let(:answer)         { FactoryGirl.attributes_for(:question)[:answer] }

    context "when question is not specified" do
      let(:question_value) { nil }

      it_behaves_like :has_a_question_presence_validation_error
      it_behaves_like :renders_the_new_template
      it_behaves_like :does_not_change_the_question_count
    end

    context "when question is blank" do
      let(:question_value) { "" }

      it_behaves_like :has_a_question_presence_validation_error
      it_behaves_like :renders_the_new_template
      it_behaves_like :does_not_change_the_question_count
    end

    context "when answer is not specified" do
      let(:answer) { nil }

      it_behaves_like :has_an_answer_presence_validation_error
      it_behaves_like :renders_the_new_template
      it_behaves_like :does_not_change_the_question_count
    end

    context "when answer is blank" do
      let(:answer) { "" }

      it_behaves_like :has_an_answer_presence_validation_error
      it_behaves_like :renders_the_new_template
      it_behaves_like :does_not_change_the_question_count
    end

    context "when valid params are specified" do
      it_behaves_like :redirects_to_the_root_path
      it_behaves_like :notices_question_created_successfully
      it_behaves_like :increases_the_question_count
    end
  end

  describe "GET #edit" do
    subject { get :edit, params }

    let(:params) { { id: id } }

    context do
      include_context "when id that does not match any question is specified"

      it_behaves_like :assigns_nil_to_question
      it_behaves_like :renders_the_edit_template
    end

    context do
      include_context "when id that matches existent question is specified"

      it_behaves_like :assigns_question_that_specified_by_id_to_question
      it_behaves_like :renders_the_edit_template
    end
  end

  describe "PATCH #update" do
    subject { patch :update, params }

    let(:params) {
      {
        id: id,
        question: {
          question: question_value,
          answer:   answer,
        }.compact,
      }.compact
    }
    let(:question_value) { FactoryGirl.attributes_for(:question)[:question] }
    let(:answer)         { FactoryGirl.attributes_for(:question)[:answer] }

    context do
      include_context "when id that does not match any question is specified"

      it_behaves_like :assigns_nil_to_question
      it_behaves_like :renders_the_edit_template
    end

    context do
      include_context "when id that matches existent question is specified"

      context "when question is not specified" do
        let(:question_value) { nil }

        it_behaves_like :redirects_to_the_root_path
        it_behaves_like :notices_question_saved_successfully
      end

      context "when question is blank" do
        let(:question_value) { "" }

        it_behaves_like :has_a_question_presence_validation_error
        it_behaves_like :renders_the_edit_template
      end

      context "when answer is not specified" do
        let(:answer) { nil }

        it_behaves_like :redirects_to_the_root_path
        it_behaves_like :notices_question_saved_successfully
      end

      context "when answer is blank" do
        let(:answer) { "" }

        it_behaves_like :has_an_answer_presence_validation_error
        it_behaves_like :renders_the_edit_template
      end

      context "when valid question and answer are specified" do
        let(:question_value) { FactoryGirl.attributes_for(:question)[:question] }
        let(:answer)         { FactoryGirl.attributes_for(:question)[:answer] }

        it_behaves_like :redirects_to_the_root_path
        it_behaves_like :notices_question_saved_successfully
      end
    end
  end

  describe "POST #answer" do
    subject { post :answer, params }

    shared_examples_for :renders_the_answer_template do
      it "renders the :answer template" do
        subject
        expect(response).to render_template(:answer)
      end
    end

    shared_examples_for :assigns_false_to_is_correct do
      it "assigns false to @is_correct" do
        subject
        expect(assigns(:is_correct)).to be false
      end
    end

    shared_examples_for :assigns_true_to_is_correct do
      it "assigns true to @is_correct" do
        subject
        expect(assigns(:is_correct)).to be true
      end
    end

    let(:params) {
      {
        id: id,
        answer: {
          answer: answer,
        }.compact,
      }.compact
    }
    let(:answer) { FactoryGirl.attributes_for(:question)[:answer] }

    context do
      include_context "when id that does not match any question is specified"

      it_behaves_like :assigns_nil_to_question
      it_behaves_like :renders_the_show_template
    end

    context do
      include_context "when id that matches existent question is specified"

      context "when answer is not specified" do
        let(:answer) { nil }

        it_behaves_like :renders_the_show_template
      end

      context "when answer is blank" do
        let(:answer) { "" }

        it_behaves_like :assigns_false_to_is_correct
        it_behaves_like :renders_the_answer_template
      end

      context "when right answer is specified" do
        let(:answer) { question.answer }

        it_behaves_like :assigns_true_to_is_correct
        it_behaves_like :renders_the_answer_template
      end
    end
  end
end
