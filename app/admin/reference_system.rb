ActiveAdmin.register ReferenceSystem do

  # :nocov:
  permit_params :name, :position, :description, :vertical_market_id,
    :venue_size_descriptor, :headline, :banner, :system_diagram,
    :delete_banner, :delete_diagram

  belongs_to :vertical_market

  config.paginate = false
  config.sort_order = 'position_asc'

  sortable

  #filter :name

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
      f.input :banner, hint: f.object.banner.present? ?
        image_tag(f.object.banner.url(:thumb)) + content_tag(:br) + "Preferred size: 1170x400 px with a strongly horizontal orientation." :
        "Preferred size: 1170x400 px with a strongly horizontal orientation."
      f.input :delete_banner, label: "Delete the existing banner (if present).", as: :boolean
      f.input :venue_size_descriptor, hint: "Maximum characters: 16", input_html: { maxlength: 16 }
      f.input :headline, hint: "Maximum characters: 90", input_html: { maxlength: 90 }
      f.input :description, as: :text, hint: "Maximum recommended characters: 650", input_html: { rows: 6 }
      f.input :system_diagram, hint: f.object.system_diagram.present? ?
        image_tag(f.object.system_diagram.url(:thumb_square)) + content_tag(:br) + "Becomes the backdrop for the interactive learning diagram." :
        "Becomes the backdrop for the interactive learning diagram."
      f.input :delete_diagram, label: "Delete the existing diagram (if present).", as: :boolean
    end
    f.actions
  end
  # :nocov:

end
