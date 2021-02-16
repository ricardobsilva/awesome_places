class PlacesController < ApplicationController
  def create
    place = Place.create!(place_params.merge!(user: current_user))

    render json: place, status: :created
  end

  private

  def place_params
    params.require(:place).permit(:name, :description, :lat, :lng)
  end
end
