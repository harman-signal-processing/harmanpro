ActiveAdmin.register Slide do
  menu parent: "Settings", priority: 2

  permit_params :name,
    :locale_id,
    :position,
    :start_on,
    :end_on,
    :background,
    :background_file_name,
    :background_file_size,
    :background_content_type,
    :background_updated_at,
    #:bubble,
    #:bubble_file_name,
    #:bubble_file_size,
    #:bubble_content_type,
    #:bubble_updated_at,
    :headline,
    #:description,
    #:link_text,
    :link_url,
    :link_new_window,
    :geo_target_country

  # :nocov:
  index do
    column :name
    column :position
    column :locale
    column :geo_target_country
    column :start_on
    column :end_on
    actions
  end

  filter :name
  filter :locale
  filter :start_on
  filter :end_on

  show do
    attributes_table do
      row :name
      row :start_on
      row :end_on
      row :locale
      row :geo_target_country
      row :background do
        if slide.background_file_name.present?
          link_to(image_tag(slide.background.url(:small)), slide.background.url)
        end
      end
      #row :bubble do
      #  if slide.bubble.present?
      #    link_to(image_tag(slide.bubble.url(:small)), slide.bubble.url)
      #  end
      #end
      row :headline
      #row :description
      #row :link_text
      row :link_url
      row :link_new_window
      row :position
    end
  end

  form  html: { multipart: true } do |f|
    f.inputs do
      f.input :name, hint: "Becomes the 'alt text' on the image"
      f.input :locale
      f.input :geo_target_country,
        as: :country,
        hint: "If present, only show this slide if the visitor's IP address appears to be in the selected country.",
        include_blank: true
      f.input :position, hint: "the sort order"
      f.input :start_on, as: :datepicker, hint: "optional"
      f.input :end_on, as: :datepicker, hint: "optional"
      f.input :background, label: "Banner image", hint: f.object.background.present? ?
        image_tag(f.object.background.url(:thumb)) : ""
      #f.input :bubble
      f.input :headline
      #f.input :description
      #f.input :link_text
      f.input :link_url
      f.input :link_new_window
    end
    f.actions
  end

  # :nocov:
end
