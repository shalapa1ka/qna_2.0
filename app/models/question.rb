# frozen_string_literal: true

class Question < ApplicationRecord
  validates :title, :body, presence: true
  has_many :answers, dependent: :destroy
  has_many :attachments, as: :attachmentable
  belongs_to :user

  accepts_nested_attributes_for :attachments

  scope :ordered, -> { order('updated_at DESC') }
end
