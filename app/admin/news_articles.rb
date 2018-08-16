ActiveAdmin.register NewsArticle do
  menu parent: "Events & News", priority: 3
  config.sort_order = 'post_on_desc'

  permit_params :title,
    :keywords,
    :body,
    :post_on,
    :news_photo,
    :quote,
    :locale_id,
    brand_news_articles_attributes: [:id, :brand_id, :_destroy]

  index do
    selectable_column
    id_column
    column :post_on
    column :locale
    column :title
    actions
  end

  filter :keywords
  filter :title
  filter :locale
  filter :post_on

  form html: { multipart: true} do |f|
    f.inputs do
      f.input :title
      f.input :keywords
      f.input :quote
      f.input :news_photo, hint: f.object.news_photo.present? ?
        image_tag(f.object.news_photo.url(:thumb)) : ""
      f.input :body, input_html: { class: "mceEditor"}
      f.input :post_on, label: "Publish On", as: :datepicker
      f.input :locale
    end
    f.has_many :brand_news_articles, heading: "Related Brands", new_record: "Add a related brand" do |s|
      s.input :id, as: :hidden
      s.input :brand, collection: Brand.order("UPPER(name)")
      s.input :_destroy, as: :boolean, label: "Delete"
    end
    f.actions
  end
end
