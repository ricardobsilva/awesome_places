class RegistrationsController < DeviseTokenAuth::RegistrationsController
  skip_before_action :authenticate_user!

  def update
    @resource.update!(sign_up_params)
    head :no_content
  end

  private

  def sign_up_params
    params.permit(:email, :password, :password_confirmation, :name)
  end
end
