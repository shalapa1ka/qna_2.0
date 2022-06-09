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

  def voted?(objs)
    objs.each do |obj|
      if obj.votes.where(user_id: self).present? # TODO: minimize sql "выборку" - one object is enough
        return true
      end
    end
    false
  end
end
