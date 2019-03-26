class ContactInfo::AdminController < ApplicationController
  before_action :authenticate_admin_user!

  def index
  end

  private

  def authenticate_admin_user!
    redirect_to new_user_session_path unless authenticate_user!
    raise Pundit::NotAuthorizedError unless current_user.contact_admin_access?
  end  
end
