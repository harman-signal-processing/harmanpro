ActiveAdmin.register OnlineRetailer do
  menu parent: "Brands & Products", priority: 9
  permit_params :name, :url, :logo, :locale_id

  # :nocov:
  index do
    selectable_column
    id_column
    column :name
    column :locale
    column :url
    actions
  end

  filter :name, as: :string
  filter :locale

  form html: {multipart: true} do |f|
    f.inputs do
      f.input :name
      f.input :url,
        placeholder: "http://retailer.website/landing/page",
        hint: "Link directly to HARMAN brands products if retailer provides such a landing page."
      f.input :logo,
        hint: "Please use a PNG with transparent background."
      f.input :locale
    end
    f.actions
  end
  # :nocov:

end
