# frozen_string_literal: true

class QuestionChannel < ApplicationCable::Channel
  def subscribed
    stream_from "question_channel_#{params[:question_id]}"
  end

  def unsubscribed; end
end
