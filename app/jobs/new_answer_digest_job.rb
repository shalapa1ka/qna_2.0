class NewAnswerDigestJob < ApplicationJob
  queue_as :default

  def perform(user, question)
    DispatchMailer.new_answer_digest(user, question).deliver_later
  end
end
