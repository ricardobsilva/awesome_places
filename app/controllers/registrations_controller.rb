class RegistrationsController < DeviseTokenAuth::SessionsController
  def update
    current_user.update!(account_update_params)

    head :no_content
  end

  private

  def account_update_params
    params.permit(:email, :password, :password_confirmation)
  end
end
