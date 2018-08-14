ActiveAdmin.register NewProduct do
  menu parent: "Brands & Products", priority: 3, label: "New Products"
  permit_params :name, :image, :content, :released_on, :more_info, :press_release,
    new_product_brands_attributes: [:id, :brand_id, :_destroy]

  index do
    selectable_column
    id_column
    column :name
    column :released_on
    actions
  end

  filter :name
  filter :released_on

  sidebar "See the future", only: [:index, :show] do
    p "To see how future products appear on the new products page, use #{ link_to("this link", "/new_products?show_future=true") }.".html_safe
  end

  show do
    attributes_table do
      row :name
      row :released_on
      row :image do
        if new_product.image.present?
          image_tag(new_product.image.url(:small))
        end
      end
      row :content do
        raw(new_product.content)
      end
      row :more_info
      row :press_release
      row :brands do
        new_product.brands.map{|b| b.name}.join(", ")
      end
    end
    active_admin_comments
  end

  form html: { multipart: true} do |f|
    f.inputs do
      f.input :name
      f.input :released_on, as: :datepicker, hint: "Dates in the future will not show on the new products page."
      f.input :image, hint: f.object.image.present? ?
        image_tag(f.object.image.url(:thumb)) + content_tag(:br) : "Preferred size is 500x407 px."
      f.input :content, hint: "The blurb that appears under the photo", input_html: { class: "mceEditor"}
      f.input :more_info, label: "More Info Link", hint: "You could leave this blank and include the link in the HTML above."
      f.input :press_release, label: "Press Release Link", hint: "Same here. Leave it blank if you included it in the HTML above."
    end
    f.has_many :new_product_brands, heading: "Brand(s)", new_record: "Add a brand" do |s|
      s.input :id, as: :hidden
      s.input :brand
      s.input :_destroy, as: :boolean, label: "Delete"
    end
    f.actions
  end

end
