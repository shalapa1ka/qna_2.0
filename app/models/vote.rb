class Vote < ApplicationRecord
  validates :user, presence: true
  belongs_to :user
  belongs_to :votesable, polymorphic: true
end
