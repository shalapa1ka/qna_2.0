class Api::V1::AnswersController < Api::V1::BaseController
  before_action :find_question, except: :index

  def index
    respond_with(@answers = @question.answers)
  end

  def show
    respond_with(@answer = @question.answers.find(params[:id]))
  end

  def create
    @answer = @question.answers.create({ body: params[:body], user: @question.user })
    respond_with @question
  end

  private

  def find_question
    @question = Question.find(params[:question_id])
  end
end