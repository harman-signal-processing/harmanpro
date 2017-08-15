class Emea::AdminController < EmeaController
  before_action :authenticate_admin_user!

  def index
  end

  private

  def authenticate_admin_user!
    redirect_to new_user_session_path unless authenticate_user!
    raise Pundit::NotAuthorizedError unless current_user.try(:admin?) || current_user.try(:emea_admin?)
  end
end
