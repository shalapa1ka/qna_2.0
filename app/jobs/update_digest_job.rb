class UpdateDigestJob < ApplicationJob
  queue_as :default

  def perform(user, question)
    DispatchMailer.update_question(user, question)
  end
end
