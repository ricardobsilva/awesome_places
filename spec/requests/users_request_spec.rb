# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe 'GET #show' do
    it 'must return 200 http status' do
      user = create(:user)

      get '/user', headers: user_headers(user)

      expect(response).to have_http_status(:ok)
    end

    it 'must return the current user data' do
      user = create(:user)

      get '/user', headers: user_headers(user)

      expect(json_body).to have_key(:id)
      expect(json_body).to have_key(:email)
      expect(json_body).to have_key(:profile)
    end
  end
end
