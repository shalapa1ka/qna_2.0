class UpdateDigestJob < ApplicationJob
  queue_as :default

  def perform(user, question)
    DispatchMailer.update_question_digest(user, question).deliver_later
  end
end
