class QuestionsController < ApplicationController
  before_filter :find_question, only: [:show, :edit, :update, :answer]

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new question_params
    if @question.save
      redirect_to root_path, notice: 'Question created successfully.'
    else
      render :new
    end
  rescue ActionController::ParameterMissing => e
    logger.warn e.message
    render :new
    return
  end

  def update
    unless @question
      render :edit
      return
    end

    if @question.update_attributes question_params
      redirect_to root_path, notice: 'Question saved successfully.'
    else
      render :edit
    end
  rescue ActionController::ParameterMissing => e
    logger.warn e.message
    render :edit
    return
  end

  def answer
    unless @question
      render :show
      return
    end

    @is_correct = @question.is_correct?(answer_params[:answer])
  rescue ActionController::ParameterMissing => e
    logger.warn e.message
    render :show
    return
  end

  private

  def find_question
    @question = Question.find_by(id: params[:id])
  end

  def question_params
    params.require(:question).permit(:question, :answer)
  end

  def answer_params
    params.require(:answer).permit(:answer)
  end
end
