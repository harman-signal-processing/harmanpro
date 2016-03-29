ActiveAdmin.register ReferenceSystem do

  # :nocov:
  permit_params :name, :position, :description, :vertical_market_id, :retail,
    :venue_size_descriptor, :headline, :banner, :system_diagram

  belongs_to :vertical_market

  config.paginate = false
  config.sort_order = 'position_asc'

  sortable

  #filter :name
  filter :retail

  index do
    sortable_handle_column
    selectable_column
    column :name
    column :vertical_market
    actions
  end

  sidebar "Product Groups", only: [:show, :edit] do
    ul do
      #if reference_system.retail?
        li link_to("+ New Product Group", new_admin_reference_system_reference_system_product_type_path(reference_system))
      #end
      reference_system.reference_system_product_types.each do |rspt|
        li link_to(rspt.product_type.name, [:admin, reference_system, rspt])
      end
    end
  end

  form html: { multipart: true} do |f|
    f.inputs do
      f.input :vertical_market
      f.input :name, hint: "Maximum characters: 20", input_html: { maxlength: 20 }
      f.input :banner, hint: "Preferred size: 1170x624 px with a strongly horizontal orientation."
      f.input :venue_size_descriptor, hint: "Maximum characters: 16", input_html: { maxlength: 16 }
      f.input :headline, hint: "Maximum characters: 90", input_html: { maxlength: 90 }
      f.input :description, hint: "Maximum characters: 650", input_html: { maxlength: 650, rows: 6 }
      f.input :system_diagram, hint: "Becomes the backdrop for the interactive learning diagram."
      f.input :retail, label: "Offer ecommerce links with this system."
    end
    f.actions
  end
  # :nocov:

end
