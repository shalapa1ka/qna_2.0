# frozen_string_literal: true

class Question < ApplicationRecord
  validates :title, :body, presence: true
  has_many :answers, dependent: :destroy
  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :votes, as: :votesable, dependent: :destroy
  has_many :subscriptions
  belongs_to :user

  accepts_nested_attributes_for :attachments

  after_create :reputation_calculate, :create_author_subscription
  after_update :send_update_digest

  scope :ordered, -> { order('updated_at DESC') }

  def likes
    votes.where(vote: :like).count
  end

  def dislikes
    votes.where(vote: :dislike).count
  end

  private

  def create_author_subscription
    subscription = Subscription.new(user: user, question: self, new_answer: true)
    subscription.save!
  end

  def reputation_calculate
    Reputation.calculate(self)
  end

  def send_update_digest
    subscriptions.where(update_question: true).each do |sb|
      UpdateDigestJob.perform_later(sb.user, self)
    end
  end
end
