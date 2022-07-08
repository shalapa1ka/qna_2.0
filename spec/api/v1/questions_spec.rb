# frozen_string_literal: true

require 'rails_helper'

describe 'Questions API' do
  let!(:access_token) { create :access_token }

  describe 'GET #index' do
    let(:do_request) { get '/api/v1/questions', as: json }
    it_behaves_like 'API Authenticable'

    context 'authorized' do
      let!(:questions) { create_list :question, 2 }
      let(:question) { questions.first }
      let!(:answer) { create :answer, question: question }

      before { do_request(access_token: access_token.token) }

      it 'returns list of questions' do
        expect(response.body).to have_json_size(2)
      end

      %w[id title body created_at updated_at].each do |attr|
        it "question object contains #{attr}" do
          expect(response.body).to be_json_eql(question.send(attr.to_sym).to_json).at_path("0/#{attr}")
        end
      end

      context 'answers' do
        it 'included in question object' do
          expect(response.body).to have_json_size(1).at_path('0/answers')
        end

        %w[id body created_at updated_at].each do |attr|
          it "answer object contains #{attr}" do
            expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).at_path("0/answers/0/#{attr}")
          end
        end
      end
    end
    def do_request(params = {})
      get '/api/v1/questions', as: :json, params: {}.merge(params)
    end
  end

  describe 'GET #show' do
    let(:question) { create :question }
    let(:api_url) { "/api/v1/questions/#{question.id}" }

    context 'unauthorized' do
      it 'returns 401 status if there is no access_token' do
        get api_url, as: :json
        expect(response.status).to eq 401
      end

      it 'returns 401 status if access_token is invalid' do
        get api_url, as: :json, params: { access_token: '1234' }
        expect(response.status).to eq 401
      end
    end

    context 'authorized' do
      let(:access_token) { create :access_token }
      let!(:answer) { create :answer, question: question }

      before { get api_url, as: :json, params: { access_token: access_token.token } }

      it 'returns 200 status' do
        expect(response).to be_successful
      end

      it 'returns question' do
        expect([response.body]).to have_json_size(1)
      end

      %w[id title body created_at updated_at].each do |attr|
        it "question object contains #{attr}" do
          expect(response.body).to be_json_eql(question.send(attr.to_sym).to_json).at_path(attr.to_s)
        end
      end

      context 'answers' do
        it 'included in question object' do
          expect(response.body).to have_json_size(1).at_path('answers')
        end

        %w[id body created_at updated_at].each do |attr|
          it "answer object contains #{attr}" do
            expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).at_path("answers/0/#{attr}")
          end
        end
      end
    end
  end
  # TODO: POST #create
end
