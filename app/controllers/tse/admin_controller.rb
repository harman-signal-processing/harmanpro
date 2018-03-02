class Tse::AdminController < TseController
  before_action :authenticate_admin_user!

  def index
  end

  private

  def authenticate_admin_user!
    redirect_to new_user_session_path unless authenticate_user!
    raise Pundit::NotAuthorizedError unless current_user.tse_admin_access?
  end

end
