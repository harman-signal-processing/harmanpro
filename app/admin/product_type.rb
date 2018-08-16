ActiveAdmin.register ProductType do
  menu parent: "Brands & Products", priority: 3, label: "Product Types"

  permit_params :name, :description

  # :nocov:
  filter :updated_at

  index do
    selectable_column
    column :name
    column :description
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :description, hint: "Maximum characters: 90", input_html: { maxlength: 90, rows: 3}
    end
    f.actions
  end
  # :nocov:

end
