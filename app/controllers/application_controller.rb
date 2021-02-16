# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ExceptionHandler
  include DeviseTokenAuth::Concerns::SetUserByToken

  before_action :authenticate_user!
end
