class UsersController < ApplicationController
  def enable_otp
    current_user.update!(
      otp_secret: User.generate_otp_secret,
      otp_required_for_login: true
    )
    redirect_to edit_user_registration_path, notice: "MFA enabled. Be sure to configure an authenticator app with the QR code below!"
  end
  
  def disable_otp
    current_user.update!(otp_required_for_login: false)
    redirect_to edit_user_registration_path, alert: "MFA is disabled. Please re-enable soon for ongoing security of your account!"
  end
end