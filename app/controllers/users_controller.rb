class UsersController < ApplicationController
  def show
    render json: current_user, status: :ok
  end
end
