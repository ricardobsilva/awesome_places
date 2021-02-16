# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Assessments", type: :request do
  describe 'POST #create' do
    context 'when pass valid data' do
      it 'must return 200 http status' do
        user = create(:user)
        place = create(:place, user: user)
        params = attributes_for(:assessment, place_id: place.id)

        post '/assessments', params: { assessment: params }, headers: user_headers(user)

        expect(response).to have_http_status(:created)
      end

      it 'must return the assessment created' do
        user = create(:user)
        place = create(:place, user: user)
        params = attributes_for(:assessment, place_id: place.id)

        post '/assessments', params: { assessment: params }, headers: user_headers(user)

        expect(json_body).to have_key(:id)
        expect(json_body).to have_key(:comment)
        expect(json_body).to have_key(:rating)
        expect(json_body).to have_key(:user_id)
        expect(json_body).to have_key(:place_id)

        expect(json_body[:place_id]).to eq(params[:place_id])
      end
    end

    context 'when pass invalid data' do
      it 'must return 422 http status' do
        user = create(:user)
        place = create(:place, user: user)
        params = attributes_for(:assessment, rating: nil, place_id: place.id)

        post '/assessments', params: { assessment: params }, headers: user_headers(user)

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'must return errors' do
        user = create(:user)
        place = create(:place, user: user)
        params = attributes_for(:assessment, rating: nil, place_id: place.id)

        post '/assessments', params: { assessment: params }, headers: user_headers(user)

        expect(json_body).to have_key(:errors)
        expect(json_body[:errors]).to have_key(:rating)
        expect(json_body[:errors][:rating][0]).to eq("can't be blank")
      end
    end
  end
end
