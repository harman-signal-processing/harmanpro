class Emea::AdminController < EmeaController
  before_action :authenticate_admin_user!

  def index
  end

  def update_invitation_code
    @invitation_code = SiteSetting.where(name: "emea_distributor_invitation_code").first_or_initialize
    @invitation_code.content = params[:site_setting][:content]
    if @invitation_code.save
      redirect_to emea_admin_users_path, notice: "Invitation code was updated."
    else
      redirect_to emea_admin_users_path, alert: "Sorry, something went wrong updating the invitation code."
    end
  end

  private

  def authenticate_admin_user!
    redirect_to new_user_session_path unless authenticate_user!
    raise Pundit::NotAuthorizedError unless current_user.emea_admin_access?
  end

end
