# frozen_string_literal: true

class Answer < ApplicationRecord
  validates :body, presence: true
  belongs_to :question
  belongs_to :user
  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :votes, as: :votesable, dependent: :destroy

  accepts_nested_attributes_for :attachments

  scope :order_best, -> { order(best: :desc) }

  def likes
    votes.where(vote: :like).count
  end

  def dislikes
    votes.where(vote: :dislike).count
  end
end
