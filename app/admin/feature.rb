ActiveAdmin.register Feature do
  menu label: "Features"

  permit_params :featurable_id,
    :featurable_type,
    :position,
    :layout_style,
    :content_position,
    :content,
    :pre_content,
    :image

  # :nocov:
  index do
    selectable_column
    id_column
    column :name
    column :featurable
    column :content_position
    column "Content" do |f|
      f.content[0,50] + "..."
    end
    actions
  end

  filter :featurable_type
  filter :featurable_id
  filter :layout_style
  filter :content_position

  form html: { multipart: true} do |f|
    f.inputs do
      f.input :featurable_type, collection: Feature.featurable_options
      f.input :featurable_id, hint: "ID of the item type selected above."
      f.input :position, label: "Order of appearance"
      f.input :layout_style, as: :radio, collection: Feature.layout_options
      f.input :content_position, as: :radio, label: "Text content position", collection: ["left", "right"]
      f.input :image, label: "Background or side image", hint: f.object.image.present? ?
        image_tag(f.object.image.url(:thumb)) :
        "No image uploaded yet."
      f.input :pre_content, label: "Content appearing before the feature", hint: "HTML permitted", input_html: { class: "mceEditor" }
      f.input :content, hint: "HTML permitted", input_html: { class: "mceEditor" }
      f.input :_destroy, as: :boolean, label: "Delete This Feature"
    end
    f.actions
  end

  #:nocov:

end
