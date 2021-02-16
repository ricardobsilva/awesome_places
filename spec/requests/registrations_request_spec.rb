require 'rails_helper'

RSpec.describe 'Registrations', type: :request do
  describe 'PUT #update' do
    context 'when pass valid data' do
      it 'must return 204 status' do
        user = create(:user)
        params = attributes_for(:user, email: 'newemail@gmail.com')

        put '/auth', params: params, headers: user_headers(user)

        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when pass invalid data' do
      it 'must return 422 status' do
        user = create(:user)
        params = attributes_for(:user, email: nil)

        put '/auth', params: params, headers: user_headers(user)

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'must return errors' do
        user = create(:user)
        params = attributes_for(:user, email: nil)

        put '/auth', params: params, headers: user_headers(user)

        expect(json_body).to have_key(:errors)
        expect(json_body[:errors]).to have_key(:email)
        expect(json_body[:errors][:email][0]).to eq("can't be blank")
      end
    end
  end
end