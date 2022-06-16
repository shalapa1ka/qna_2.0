require 'rails_helper'

describe 'Profile API' do
  describe 'GET /me' do
    let(:me) { create(:user) }
    let(:access_token) { create(:access_token, resource_owner_id: me.id) }

    context 'unauthorized' do
      it_behaves_like 'API Authenticable'

      context 'authorized' do

        before { do_request(access_token: access_token.token) }

        %w[id email created_at updated_at admin].each do |attr|
          it "contains #{attr}" do
            expect(response.body).to be_json_eql(me.send(attr.to_sym).to_json).at_path(attr)
          end
        end

        %w[password encrypted_password].each do |attr|
          it "does not contain #{attr}" do
            expect(response.body).to_not have_json_path(attr)
          end
        end
      end

      def do_request(params = {})
        get '/api/v1/profiles/me', as: :json, params: {}.merge(params)
      end
    end
  end
end