# frozen_string_literal: true

require 'rails_helper'

describe QuestionsController do
  let(:user) { create :user }
  let(:admin) { create :user, :admin }
  let(:other_user) { create :user }
  let(:question) { create :question, user: user }

  before(:each) do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in user
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves the new question in the database' do
        expect do
          post :create, xhr: true, params: { question: attributes_for(:question) }
        end.to change(Question, :count).by(1)
      end

      it 're-render nothing' do
        post :create, xhr: true, params: { question: attributes_for(:question) }
        expect(response.body).to be_blank
      end
    end

    context 'with invalid attributes' do
      it 'does not saves the new question in the database' do
        expect do
          post :create, xhr: true, params: { question: attributes_for(:question, title: '') }
        end.to_not change(Question, :count)
      end
    end

    # TODO: PATCH #update
    # TODO: DELETE #destroy
  end
end