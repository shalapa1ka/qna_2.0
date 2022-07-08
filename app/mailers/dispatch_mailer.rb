# frozen_string_literal: true

class DispatchMailer < ApplicationMailer
  default from: 'from@example.com'

  def digest(user)
    @questions = Question.where('created_at >= ?', 1.day.ago)
    mail to: user.email
  end

  def update_question_digest(user, question)
    @question = question
    mail to: user
  end

  def new_answer_digest(user, question)
    @question = question
    mail to: user
  end
end
