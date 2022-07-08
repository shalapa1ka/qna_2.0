class NewAnswerDigestJob < ApplicationJob
  queue_as :default

  def perform(*args)
    DispatchMailer.new_answer_digest(user, question)
  end
end
