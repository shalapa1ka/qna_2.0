# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validates' do
    it { should have_many(:answers).dependent(:destroy) }
    it { should have_many(:questions).dependent(:destroy) }
  end
  describe '.from_omniauth' do
    let!(:user) { create(:user) }
    let(:auth) { OmniAuth::AuthHash.new(provider: 'github', uid: '123456') }

    context 'user already has authorization' do
      it 'returns the user' do
        user.authorizations.create(provider: 'github', uid: '123456')
        expect(User.from_omniauth(auth)).to eq user
      end
    end

    context 'user has not authorization' do
      context 'user already exists' do
        let(:auth) do
          OmniAuth::AuthHash.new(provider: 'github', uid: '123456', info: { email: user.email, name: :test })
        end
        it 'does not create new user' do
          expect { User.from_omniauth(auth) }.to_not change(User, :count)
        end

        it 'creates authorization for user' do
          expect { User.from_omniauth(auth) }.to change(user.authorizations, :count).by(1)
        end

        it 'creates authorization with provider and uid' do
          authorization = User.from_omniauth(auth).authorizations.first

          expect(authorization.provider).to eq auth.provider
          expect(authorization.uid).to eq auth.uid
        end

        it 'returns the user' do
          expect(User.from_omniauth(auth)).to eq user
        end
      end

      context 'user does not exist' do
        let(:auth) do
          OmniAuth::AuthHash.new(provider: 'github', uid: '123456', info: { email: 'new@user.com', name: :test })
        end

        it 'creates new user' do
          expect { User.from_omniauth(auth) }.to change(User, :count).by(1)
        end

        it 'returns new user' do
          expect(User.from_omniauth(auth)).to be_a(User)
        end

        it 'fills user email' do
          user = User.from_omniauth(auth)
          expect(user.email).to eq auth.info[:email]
        end

        it 'creates authorization for user' do
          user = User.from_omniauth(auth)
          expect(user.authorizations).to_not be_empty
        end

        it 'creates authorization with provider and uid' do
          authorization = User.from_omniauth(auth).authorizations.first

          expect(authorization.provider).to eq auth.provider
          expect(authorization.uid).to eq auth.uid
        end
      end
    end
  end
end
