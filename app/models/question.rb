# frozen_string_literal: true

class Question < ApplicationRecord
  validates :title, :body, presence: true
  has_many :answers, dependent: :destroy
  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :votes, as: :votesable, dependent: :destroy
  belongs_to :user

  accepts_nested_attributes_for :attachments

  scope :ordered, -> { order('updated_at DESC') }

  def likes
    votes.where(vote: :like).count
  end

  def dislikes
    votes.where(vote: :dislike).count
  end
end
