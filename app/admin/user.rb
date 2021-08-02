ActiveAdmin.register User do
  menu parent: "Settings", priority: 2
  permit_params do
    params = [:email, :password, :password_confirmation]
    if current_user.admin? || current_user.super_admin?
      params += [:service_department, :super_admin, :translator, :admin, :lead_recipient,
        :emea_admin, :emea_distributor, :tse_admin, :contact_admin, :pr_admin,
        locale_translators_attributes: [:id, :available_locale_id, :_destroy],
        country_lead_recipients_attributes: [:id, :country, :_destroy]
      ]
    end
    params
  end

  #menu if: proc { current_user.can?(:manage, AdminUser) }

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
    attributes_table do
      row :email
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

end
