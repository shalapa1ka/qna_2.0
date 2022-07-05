# frozen_string_literal: true

class DispatchMailer < ApplicationMailer
  default from: 'from@example.com'

  def digest(user)
    @questions = Question.where('created_at >= ?', 1.day.ago)
    mail to: user.email
  end
end
