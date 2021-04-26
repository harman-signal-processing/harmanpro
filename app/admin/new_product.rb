ActiveAdmin.register NewProduct do
  menu parent: "Brands & Products", priority: 4, label: "New Products"
  permit_params :name, :image, :content, :released_on, :more_info, :press_release,
    new_product_product_types_attributes: [:id, :product_type_id, :_destroy],
    new_product_brands_attributes: [:id, :brand_id, :_destroy]

  index do
    selectable_column
    id_column
    column :name
    column :brands
    column :released_on
    actions
  end

  controller do
    # Overriding ActiveAdmin apply_filtering method to provide distinct results
    # The need arose when searching by name. Translated records were causing duplicate rows to be shown.
    # https://github.com/activeadmin/activeadmin/issues/4171
    def apply_filtering(chain)
       @search = chain.ransack(params[:q] || {})
       @search.result(distinct: true)
    end
  end
  
  filter :translations_name_contains, as: :string, label: "Search Names"
  filter :brands, as: :select
  filter :released_on

  #sidebar "See the future", only: [:index, :show] do
  #  p "To see how future products appear on the new products page, use #{ link_to("this link", "/new_products?show_future=true") }.".html_safe
  #end

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
      row :product_types do
        new_product.product_types.map{|pt| pt.name}.join(", ")
      end
    end
  end

  form html: { multipart: true} do |f|
    f.inputs do
      f.input :name
      f.input :released_on, as: :datepicker, hint: "Dates in the future will not show on the new products page."
      f.input :image, hint: f.object.image.present? ?
        image_tag(f.object.image.url(:thumb)) + content_tag(:br) : "Preferred size is 500x407 px."
      f.input :content, as: :text, hint: "The blurb that appears under the photo", input_html: { class: "mceEditor"}
      f.input :more_info, label: "More Info Link", hint: "You could leave this blank and include the link in the HTML above."
      f.input :press_release, label: "Press Release Link", hint: "Same here. Leave it blank if you included it in the HTML above."
    end
    f.has_many :new_product_brands, heading: "Brand(s)", new_record: "Add a brand" do |s|
      s.input :id, as: :hidden
      s.input :brand, collection: Brand.order(Arel.sql("UPPER(name)"))
      s.input :_destroy, as: :boolean, label: "Delete"
    end
    f.has_many :new_product_product_types, heading: "Product Types(s)", new_record: "Add a product type" do |pt|
      pt.input :id, as: :hidden
      pt.input :product_type, collection: ProductType.with_translations(I18n.locale).order(:name)
      pt.input :_destroy, as: :boolean, label: "Delete"
    end
    f.actions
  end

end
