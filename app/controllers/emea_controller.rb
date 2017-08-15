class EmeaController < ApplicationController
  before_action :authenticate_emea_user!

  def index
    @page = EmeaPage.home
    render template: 'emea/emea_pages/show'
  end

  private

  def authenticate_emea_user!
    redirect_to new_user_session_path unless authenticate_user!
    raise Pundit::NotAuthorizedError unless current_user.emea_access?
  end
end
