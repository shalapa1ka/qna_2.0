# frozen_string_literal: true

require 'rails_helper'

describe AnswersController, type: :controller do
  let(:user) { create :user }
  let(:admin) { create :user, :admin }
  let(:other_user) { create :user }
  let(:question) { create :question }
  let(:answer) { create :answer, user: user }

  before(:each) do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in user
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves the new answer in the database' do
        expect do
          post :create, params: { answer: attributes_for(:answer), question_id: question, user_id: user }
        end.to change(Answer, :count).by(1)
      end

      it 'redirects to question show view' do
        post :create, params: { id: answer, answer: attributes_for(:answer),
                                question_id: question }
        expect(request).to redirect_to(assigns(:question))
      end
    end

    context 'with invalid attributes' do
      it 'does not saves' do
        expect do
          post :create, params: { answer: attributes_for(:answer, body: ''),
                                  question_id: question, user_id: user }
        end.to_not change(Answer, :count)
      end
      it 're-render question view' do
        post :create, params: { answer: attributes_for(:answer, body: ''),
                                question_id: question, user_id: user }
        expect(request).to render_template :new
      end
    end
  end
end
