ActiveAdmin.register CountryLeadRecipient do
  menu parent: "LeadGen", label: "Recipients"
  actions :all
  permit_params :country, :user_id

  sortable

  index do
    selectable_column
    id_column
    column :country do |clr|
      ISO3166::Country.new(clr.country).common_name
    end
    column :user
    actions
  end

  form do |f|
    f.inputs do
      f.input :country
      f.input :user, collection: User.where(lead_recipient: true).order("email")
    end
    f.actions
  end

  csv do
    column(:country_code) { |clr| clr.country }
    column(:country_name) { |clr| ISO3166::Country.new(clr.country).common_name }
    column(:recipient) { |clr| clr.user.email }
  end
end
