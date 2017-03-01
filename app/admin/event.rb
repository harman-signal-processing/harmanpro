ActiveAdmin.register Event do
  menu parent: "Events & News", priority: 2
  config.sort_order = 'start_on_desc'

  permit_params :name,
    :start_on,
    :end_on,
    :description,
    :featured,
    :active,
    :image,
    :hide_image,
    :page_content,
    :more_info_link,
    :new_window,
    :delete_image

  # :nocov:
  index do
    column :name do |event|
      if event.original_locale
        Globalize.with_locale(event.original_locale.key) do
          event.name
        end
      else
        event.name
      end
    end
    column :locale do |event|
      if event.original_locale
        event.original_locale.key
      end
    end
    column :start_on
    column :end_on
    column :featured
    column :active
    actions
  end

  #filter :name
  filter :featured
  filter :active
  filter :start_on
  filter :original_locale

  show do
    attributes_table do
      row :name
      row :start_on
      row :end_on
      row :description
      row :image do
        if event.image_file_name.present?
          link_to(image_tag(event.image.url(:small)), event.image.url)
        end
      end
      row :more_info do
        event.more_info_link.to_s
      end
      row :page_content do
        raw(event.page_content)
      end
      row :featured
      row :active
    end
    active_admin_comments
  end

  form html: {multipart: true} do |f|
    f.inputs do
      f.input :name
      f.input :start_on, as: :datepicker
      f.input :end_on, as: :datepicker
      f.input :description
      f.input :image, hint: f.object.image.present? ?
        image_tag(f.object.image.url(:thumb)) : "Only for 'featured' events."
      f.input :hide_image, hint: "Check this box if you want to make this a featured event, but don't want the header image to appear on the page. Instead, the thumbnail of the image is used only on the events index page."
      f.input :delete_image, as: :boolean, label: "Delete the image if present.", hint: "This will remove the previously saved image when you submit this form."
      f.input :more_info_link, hint: "'Featured' events will show this link on the event details page if page content is provided. Do not use a link back to itself here. This is meant for a link to a 3rd party page or another landing page on the site."
      f.input :new_window, hint: "Check if the more info link directs users away from the site."
      f.input :page_content, input_html: { class: "mceEditor"}
      f.input :featured
      f.input :active
    end
    f.actions
  end
  # :nocov:

end
