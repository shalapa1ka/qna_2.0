# frozen_string_literal: true

class QuestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_question, except: %i[index new create cancel_vote]
  before_action :authorize_question!
  after_action :verify_authorized

  def index
    @pagy, @questions = pagy Question.all.ordered, link_extra: 'data-turbo-frame="pagination"'
  end

  def show
    @pagy, @answers = pagy @question.answers
  end

  def new
    @question = current_user.questions.new
    @question.attachments.build
  end

  def edit
    @question.attachments.build
  end

  def create
    @question = current_user.questions.build question_params
    flash[:notice] = 'Question successfully created!' if @question.save
  end

  def update
    flash[:notice] = 'Question successfully updated!' if @question.update(question_params)
  end

  def destroy
    flash[:notice] = 'Question successfully deleted!' if @question.destroy
  end

  def vote
    if current_user.voted?(:Question)
      flash[:alert] = 'You already voted!'
    else
      flash[:notice] = 'You successfully voted!'
      @question.votes.create vote_params
    end
    @questions = Question.all
  end

  def cancel_vote
    @vote = current_user.votes.where(votesable_type: :Question).first
    flash[:notice] = 'You vote successfully canceled!'
    @vote.destroy
    @questions = Question.all
  end

  def subscribe_update
    if Subscription.where(user: current_user, question: @question).any?
      @sb = Subscription.where(user: current_user, question: @question).first
      @sb.update_question = true
    else
      @sb = Subscription.new(user: current_user, question: @question, update_question: true)
    end
    redirect_to @question, notice: 'You successfully subscribed from updating question!' if @sb.save
  end

  def unsubscribe_update
    @sb = Subscription.where(user: current_user, question: @question).first
    @sb.update_question = false
    redirect_to @question, notice: 'You successfully unsubscribed from updating question!' if @sb.save
  end

  def subscribe_new_answer
    if Subscription.where(user: current_user, question: @question).any?
      @sb = Subscription.where(user: current_user, question: @question).first
      @sb.new_answer = true
    else
      @sb = Subscription.new(user: current_user, question: @question, new_answer: true)
    end
    redirect_to @question, notice: 'You successfully subscribed from updating question!' if @sb.save
  end

  def unsubscribe_new_answer
    @sb = Subscription.where(user: current_user, question: @question).first
    @sb.new_answer = false
    redirect_to @question, notice: 'You successfully unsubscribed from updating question!' if @sb.save
  end

  private

  def find_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body, attachments_attributes: [:file])
  end

  def vote_params
    params.require(:vote).permit(:user_id, :vote)
  end

  def authorize_question!
    authorize(@question || Question)
  end
end
