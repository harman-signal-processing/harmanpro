ActiveAdmin.register NewsArticle do
  menu parent: "Events & News", priority: 3
  config.sort_order = 'post_at_desc'

  permit_params :title,
    :keywords,
    :body,
    :post_at,
    :news_photo,
    :narrow_banner,
    :quote,
    :locale_id,
    brand_news_articles_attributes: [:id, :brand_id, :_destroy]

  index do
    selectable_column
    id_column
    column :post_at
    column :locale
    column :title
    actions
  end

  filter :keywords
  filter :title
  filter :locale
  filter :post_at

  form html: { multipart: true} do |f|
    f.inputs do
      f.input :title
      f.input :keywords, as: :text
      f.input :quote, as: :text
      li "News photo is the main, wide banner that appears at the top of the article page."
      f.input :news_photo, hint: f.object.news_photo.present? ?
        image_tag(f.object.news_photo.url(:thumb)) : ""
      li "Narrow banner is an optional variant, typically with a 4x6 aspect ratio with any text in the center square. If missing, the system will use similar sizes from the main banner."
      f.input :narrow_banner, hint: f.object.narrow_banner.present? ?
        image_tag(f.object.narrow_banner.url(:thumb)) : ""
      f.input :body, as: :text, input_html: { class: "mceEditor"}
      f.input :post_at, label: "Publish Date/Time", as: :date_time_picker, hint: "According to #{Rails.application.config.time_zone}."
      f.input :locale
    end
    f.has_many :brand_news_articles, heading: "Related Brands", new_record: "Add a related brand" do |s|
      s.input :id, as: :hidden
      s.input :brand, collection: Brand.order(Arel.sql("UPPER(name)"))
      s.input :_destroy, as: :boolean, label: "Delete"
    end
    f.actions
  end
end
