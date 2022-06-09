# frozen_string_literal: true

class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_answer, only: %i[edit update destroy set_best vote]
  before_action :find_best_answer, only: :set_best
  before_action :find_question
  before_action :authorize_answer!
  after_action :verify_authorized

  def new
    @answer = Answer.new
    @answer.attachments.build
  end

  def edit; end

  def create
    @answer = current_user.answers.build(answer_params)
    @answer.question_id = params[:question_id]

    flash[:notice] = 'Answer successfully created!' if @answer.save
  end

  def update
    if @answer.update(answer_params)
      flash[:notice] = 'Answer successfully edited!'
    else
      render :edit
    end
  end

  def set_best
    @best_answer.update(best: false)
    @answer.update(best: true)
    flash[:notice] = 'Best answer successfully selected!'
  end

  def destroy
    flash[:notice] = 'Answer successfully deleted!' if @answer.destroy
  end

  def vote
    if current_user.voted?(@question.answers)
      flash[:alert] = 'You already voted!'
    else
      flash[:notice] = 'You successfully voted!'
      @answer.votes.create vote_params
    end
  end

  private

  def find_answer
    @answer = Answer.find(params[:id])
  end

  def find_best_answer
    @best_answer = Answer.where(best: true)
  end

  def find_question
    @question = Question.find(params[:question_id])
  end

  def vote_params
    params.require(:vote).permit(:user_id, :vote)
  end

  def answer_params
    params.require(:answer).permit(:body, :user_id, attachments_attributes: [:file])
  end

  def authorize_answer!
    authorize(@answer || Answer)
  end
end
