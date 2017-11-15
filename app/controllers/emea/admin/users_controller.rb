class Emea::Admin::UsersController < Emea::AdminController
  before_action :load_user, only: [:show, :destroy]

  def index
    @emea_distributors = User.where(emea_distributor: true)

    respond_to do |format|
      format.html {
        @users = []
        @q ||= @emea_distributors.ransack(params[:q])
        if params[:q]
          @users = @q.result(:distinct => true)
        end

        @invitation_code = SiteSetting.where(name: "emea_distributor_invitation_code").first_or_initialize
      }
      format.csv {
        headers['Content-Disposition'] = "attachment; filename=\"EMEA-portal-users-#{Date.today.to_s}.csv\""
        headers['Content-Type'] ||= 'text/csv'
      }
    end
  end

  def show
  end

  def destroy
    if @user.destroy
      redirect_to action: 'index', notice: "User was deleted successfully"
    else
      redirect_to [:emea, :admin, @user], alert: "User could not be deleted."
    end
  end

  private

  def load_user
    @user = User.find(params[:id])
    authorize @user
  end

end
