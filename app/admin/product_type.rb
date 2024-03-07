ActiveAdmin.register ProductType do
  menu parent: "Brands & Products", priority: 3, label: "Product Types"

  permit_params :name, :description

  # :nocov:
  #filter :translations_name_contains, as: :string, label: "Search Names"
  filter :updated_at

  controller do
    # Overriding ActiveAdmin apply_filtering method to provide distinct results
    # The need arose when searching by name. Translated records were causing duplicate rows to be shown.
    # https://github.com/activeadmin/activeadmin/issues/4171
    def apply_filtering(chain)
       @search = chain.ransack(params[:q] || {})
       @search.result(distinct: true)
    end
  end

  index do
    selectable_column
    column :name
    column :description
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :description, as: :text, hint: "Maximum characters: 90", input_html: { maxlength: 90, rows: 3}
    end
    f.actions
  end
  # :nocov:

end
