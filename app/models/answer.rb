# frozen_string_literal: true

class Answer < ApplicationRecord
  validates :body, presence: true
  belongs_to :question
  belongs_to :user
  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :votes, as: :votesable, dependent: :destroy

  accepts_nested_attributes_for :attachments

  scope :order_best, -> { order(best: :desc) }

  after_create :send_update_digest

  def likes
    votes.where(vote: :like).count
  end

  def dislikes
    votes.where(vote: :dislike).count
  end

  def send_update_digest
    question.subscriptions.where(new_answer: true).each do |sb|
      NewAnswerDigestJob.perform_later(sb.user, question)
    end
  end
end
