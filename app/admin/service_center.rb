ActiveAdmin.register ServiceCenter do
  menu label: "Service Centers", parent: "Service"

  permit_params :name,
    :contact_name,
    :address,
    :city,
    :state,
    :zip,
    :phone,
    :fax,
    :email,
    :website,
    :account_number,
    :active,
    :uses_rma_form,
    service_center_service_groups_attributes: [:id, :service_group_id, :_destroy]


  # :nocov:

  index do
    column :name
    column :city
    column :state
    column :account_number
    column :active
    column :uses_rma_form
    actions
  end

  filter :name, as: :string
  filter :active

  form do |f|
    f.inputs do
      f.input :name
      f.input :contact_name
      f.input :address
      f.input :city
      f.input :state
      f.input :zip
      f.input :phone
      f.input :fax
      f.input :email
      f.input :website
      f.input :account_number
      f.input :active
      f.input :uses_rma_form, hint: "RMA button will appear on brand sites /repairs listing for this service center"
    end
    f.has_many :service_center_service_groups, heading: "Service Groups", new_record: "Add a service group" do |s|
      s.input :id, as: :hidden
      s.input :service_group
      s.input :_destroy, as: :boolean, label: "Delete"
    end
    f.actions
  end
  # :nocov:
end
