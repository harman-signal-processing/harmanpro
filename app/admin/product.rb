ActiveAdmin.register Product do
  menu parent: "Brands & Products", priority: 2, label: "Products"
  permit_params :name, :brand_id, :url, :photo, :description, :ecommerce_id

  # :nocov:
  index do
    selectable_column
    column :brand
    column :name
    column :url
    actions
  end

  show do
    attributes_table do
      row :name
      row :brand
      row :external_link do
        if product.url.present?
          link_to product.url, product.url, target: "_blank"
        end
      end
      row :images do
        if product.photo_file_name.present?
          columns do
            column do
              image_tag(product.photo.url(:small))
            end
            column do
              ul do
                li link_to('original size', product.photo.url(:original))
                li link_to('large', product.photo.url(:large))
                li link_to('medium', product.photo.url(:medium))
                li link_to('small', product.photo.url(:small))
                li link_to('thumb', product.photo.url(:thumb))
                li link_to('thumb (square)', product.photo.url(:thumb_square))
                li link_to('tiny (square)', product.photo.url(:tiny))
              end
            end
          end
        end
      end
      row :description do
        raw(textilize(product.description))
      end
      row :ecommerce_id
    end
  end

  form html: { multipart: true} do |f|
    f.inputs do
      f.input :brand
      f.input :name
      f.input :photo, hint: f.object.photo.present? ?
        image_tag(f.object.photo.url(:thumb)) : ""
      f.input :url, hint: "Start with http://"
      f.input :ecommerce_id, hint: "Just the ID from shop.harmanpro.com like \"eon206p\"", label: "Ecomm ID"
      f.input :description, hint: "Maximum characters: 90", input_html: { maxlength: 90, rows: 3}
    end
    f.actions
  end

  sidebar "Product Types", only: :index do
    ul do
      li link_to("+ New Product Type", new_admin_product_type_path)
      ProductType.all.each do |product_type|
        li link_to(product_type.name, [:admin, product_type])
      end
    end
  end

  filter :brand, as: :select
  #filter :name, as: :string

  # :nocov:
end
