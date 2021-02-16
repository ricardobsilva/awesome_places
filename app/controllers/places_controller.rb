class PlacesController < ApplicationController
  def create
    place = Place.create!(place_params.merge!(user: current_user))

    render json: place, status: :created
  end

  def assessments
    assessments = Assessment.where(place_id: params[:id])

    render json: assessments,
           include: { user: { only: %i[id name] }, place: { only: %i[id name] } },
           status: :ok
  end

  private

  def place_params
    params.require(:place).permit(:name, :description, :lat, :lng)
  end
end
