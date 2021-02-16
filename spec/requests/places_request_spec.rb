# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Places', type: :request do

  describe 'GET #index' do
    it 'must return 200 http status' do
      user = create(:user)

      get '/places', headers: user_headers(user)

      expect(response).to have_http_status(:ok)
    end
    context 'when find by list mode' do
      it 'must return places by alphabetical order' do
        user = create(:user)
        place1 = create(:place, name: 'Rio Largo', user: user)
        place2 = create(:place, name: 'Arapiraca', user: user)
        place3 = create(:place, name: 'Porto Alegre', user: user)

        get '/places', headers: user_headers(user)

        expect(json_body[0][:id]).to eq(place2.id)
        expect(json_body[0][:name]).to eq(place2.name)
        expect(json_body[1][:id]).to eq(place3.id)
        expect(json_body[1][:name]).to eq(place3.name)
        expect(json_body[2][:id]).to eq(place1.id)
        expect(json_body[2][:name]).to eq(place1.name)
      end
    end

    context 'when find by map mode' do
      it 'must return places by alphabetical order' do
        user = create(:user)
        place1 = create(
          :place, name: 'Marechal Deodoro', user: user,
                  lat: -9.767288, lng: -35.850905
        )
        place2 = create(
          :place, name: 'Jequiá da Praia', user: user,
                  lat: -10.010804, lng: -36.026543
        )
        place3 = create(
          :place, name: 'Barra de São Miguel', user: user,
                  lat: -9.823314, lng: -35.886151
        )
        params = { lat: -9.649818, lng: -35.708951 }

        get '/places', params: params, headers: user_headers(user)

        expect(json_body[0][:id]).to eq(place1.id)
        expect(json_body[0][:name]).to eq(place1.name)
        expect(json_body[1][:id]).to eq(place3.id)
        expect(json_body[1][:name]).to eq(place3.name)
        expect(json_body[2][:id]).to eq(place2.id)
        expect(json_body[2][:name]).to eq(place2.name)
      end
    end
  end

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
