# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Places', type: :request do
  describe 'POST #create' do
    context 'when pass valid data' do
      it 'must return 201 http status' do
        user = create(:user)
        params = attributes_for(:place)

        post '/places', params: { place: params }, headers: user_headers(user)

        expect(response).to have_http_status(:created)
      end

      it 'must return the place created' do
        user = create(:user)
        params = attributes_for(:place)

        post '/places', params: { place: params }, headers: user_headers(user)

        expect(json_body).to have_key(:id)
        expect(json_body).to have_key(:name)
        expect(json_body).to have_key(:description)
        expect(json_body).to have_key(:user_id)
        expect(json_body).to have_key(:created_at)
        expect(json_body).to have_key(:updated_at)
      end
    end

    context 'when pass invalid data' do
      it 'must return 422 http status' do
        user = create(:user)
        params = attributes_for(:place, name: nil)

        post '/places', params: { place: params }, headers: user_headers(user)

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'must return errors' do
        user = create(:user)
        params = attributes_for(:place, name: nil)

        post '/places', params: { place: params }, headers: user_headers(user)

        expect(json_body).to have_key(:errors)
        expect(json_body[:errors]).to have_key(:name)
        expect(json_body[:errors][:name][0]).to eq("can't be blank")
      end
    end
  end

  describe 'GET #assessments' do
    it 'must return 200 http status' do
      user = create(:user)
      place = create(:place, user: user)
      create(:assessment, user: user, place: place)

      get "/places/#{place.id}/assessments", headers: user_headers(user)

      expect(response).to have_http_status(:ok)
    end

    it 'must return all the place assessments' do
      user = create(:user)
      place = create(:place, user: user)
      create(:assessment, user: user, place: place)

      get "/places/#{place.id}/assessments", headers: user_headers(user)

      expect(json_body[0]).to have_key(:id)
      expect(json_body[0]).to have_key(:rating)
      expect(json_body[0]).to have_key(:comment)
      expect(json_body[0]).to have_key(:created_at)
      expect(json_body[0]).to have_key(:updated_at)
      expect(json_body[0]).to have_key(:user)
      expect(json_body[0][:user]).to have_key(:id)
      expect(json_body[0][:user]).to have_key(:name)
      expect(json_body[0]).to have_key(:place)
      expect(json_body[0][:place]).to have_key(:id)
      expect(json_body[0][:place]).to have_key(:name)
      expect(json_body).to be_an(Array)
    end
  end
end
