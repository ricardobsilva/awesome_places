class PlacesController < ApplicationController
  def index
    places = Place.map_mode(params[:lat], params[:lng]) if map_mode_params?

    places = Place.list_mode unless map_mode_params?

    render json: places, status: :ok
  end

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

  def map_mode_params?
    params[:lat].present? and params[:lng].present?
  end
end
