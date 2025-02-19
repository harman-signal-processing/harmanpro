ActiveAdmin.register User do
  menu parent: "Settings", priority: 2
  config.sort_order = "current_sign_in_at_desc"
  permit_params do
    params = [:email, :password, :password_confirmation]
    if current_user.admin? || current_user.super_admin?
      params += [:service_department, :super_admin, :translator, :admin, :lead_recipient,
        :emea_admin, :emea_distributor, :tse_admin, :contact_admin, :pr_admin,
        :otp_required_for_login,
        locale_translators_attributes: [:id, :available_locale_id, :_destroy],
        country_lead_recipients_attributes: [:id, :country, :_destroy]
      ]
    end
    params
  end

  #menu if: proc { current_user.can?(:manage, AdminUser) }
  
  action_item :edit_two_factor, only: :show, if: proc{ current_user == user } do
    if current_user.otp_required_for_login
      link_to("Disable MFA", disable_otp_admin_user_path, method: :put)
    else
      link_to("Enable MFA", enable_otp_admin_user_path, method: :put)
    end
  end

  # :nocov:
  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end
  # :nocov:

  controller do
    def update
      if params[:user][:password].blank?
        params[:user].delete("password")
        params[:user].delete("password_confirmation")
      end
      super
    end
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  show do
    if current_user == user && user.otp_required_for_login?
      panel "Multi-factor Authentication" do
        h3 do
          "Scan the QR code below to setup MFA with an authenticator app:"
        end
        div do
          RQRCode::QRCode.new(current_user.otp_provisioning_uri(current_user.email, issuer: "HARMAN Pro"), level: :l).as_svg(
            offset: 40,
            fill: "ffffff",
            color: :black,
            module_size: 11,
            standalone: true,
            use_path: true
          ).html_safe
        end
        h5 do
          "You MUST set up an authenticator app like Authy, Google Authenticator, Cisco Duo, etc. or you will not be able to login next time. " +
          "We currently do not support backup codes, so you'll need to contact an administrator if you lose access to your authenticator."
        end
      end
    end

    attributes_table do
      row :email
      row :otp_required_for_login
      # Not sure we should or need to show this...
      #row :otp_registration_url do
      #  user.otp_provisioning_uri(user.email, issuer: "HARMAN Pro")
      #end
      row :last_sign_in_at
      row :admin
      row :super_admin
      row :service_department
      row :translator
      row :locales
      row :emea_admin
      row :emea_distributor
      row :tse_admin
      row :contact_admin
      row :lead_recipient
      row :country_lead_recipients
      row :pr_admin
    end
  end

  # :nocov:
  form do |f|
    f.inputs "Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :otp_required_for_login, label: "OTP required for login (MFA)"
    end
    if current_user.admin? || current_user.super_admin?
      f.inputs "Roles" do
        f.input :admin, hint: "For access to this admin tool."
        f.input :service_department
        f.input :translator
        f.input :emea_distributor
        f.input :emea_admin
        f.input :contact_admin
        f.input :tse_admin
        f.input :lead_recipient
        f.input :pr_admin, label: "News/PR Admin"
        f.input :super_admin
      end
      f.has_many :locale_translators, heading: "Authorized Locales", new_record: "Add an authorized locale" do |s|
        s.input :id, as: :hidden
        s.input :locale, collection: AvailableLocale.order(:name)
        s.input :_destroy, as: :boolean, label: "Delete"
      end
      f.has_many :country_lead_recipients, heading: "LeadGen Countries", new_record: "Add a country" do |s|
        s.input :id, as: :hidden
        s.input :country
        s.input :_destroy, as: :boolean, label: "Delete"
      end
    end
    f.actions
  end
  # :nocov:

  member_action :disable_otp, method: :put do
    current_user.update!( otp_required_for_login: false )
    redirect_to admin_user_path(current_user.to_param)
  end

  member_action :enable_otp, method: :put do
    current_user.update!(
      otp_secret: User.generate_otp_secret,
      otp_required_for_login: true
    )
    redirect_to admin_user_path(current_user.to_param)
  end
end
