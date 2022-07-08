# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :omniauthable, omniauth_providers: %i[github google_oauth2]
  has_many :answers, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :votes
  has_many :social_auths

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

  def self.from_omniauth(access_token)
    authorization = SocialAuth.where(provider: access_token.provider, uid: access_token.uid).first
    return authorization.user if authorization

    email = access_token.info[:email]
    user = User.where(email: email).first
    unless user
      password = Devise.friendly_token[0, 20]
      user = User.create!(email: email, password: password, password_confirmation: password,
                          name: access_token.info[:name])
    end
    user.social_auths.create(provider: access_token.provider, uid: access_token.uid)
    user
  end
end
