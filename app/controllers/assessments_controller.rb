class AssessmentsController < ApplicationController
  def create
    assessment = Assessment.create!(assessment_params.merge!(user: current_user))

    render json: assessment, status: :created
  end

  private

  def assessment_params
    params.require(:assessment).permit(:rating, :comment, :place_id)
  end
end
