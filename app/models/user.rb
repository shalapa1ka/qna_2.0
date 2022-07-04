# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :answers, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :votes

  def author?(obj)
    obj.user == self
  end

  def voted?(type, parent_id = nil)
    if type == :Answer
      votes.where(votesable_type: type, votesable_parent_id: parent_id).any?
    else
      votes.where(votesable_type: type).any?
    end
  end
end
