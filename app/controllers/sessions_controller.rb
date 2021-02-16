class SessionsController < DeviseTokenAuth::SessionsController
  skip_before_action :authenticate_user!

  def render_destroy_success
    head :no_content
  end
end
