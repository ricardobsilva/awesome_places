require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  describe 'DELETE #destroy' do
    it 'must return 204 http status' do
      user = create(:user)

      delete '/auth/sign_out', headers: user_headers(user)

      expect(response).to have_http_status(:no_content)
    end
  end
end
