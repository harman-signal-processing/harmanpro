ActiveAdmin.register Resource do
  # :nocov:
  menu label: "Resource Library"

  permit_params :name, :attachment, :image, :resource_type, :tag_list, :description, :include_in_pdf_search, :html

  filter :name
  filter :resource_type

  index do
    selectable_column
    column :preview do |r|
      if r.image_file_name.present?
        image_tag r.image.url(:tiny)
      end
    end
    column :name
    column :resource_type
    column "Resource" do |r|
      link_to 'direct link', r.attachment.url
    end
    column "Permalink" do |r|
      link_to 'permalink', resource_permalink_url(r)
    end
    actions
  end

  show do
    attributes_table do
      row :name
      row :resource_type
      row :attachment_file_name
      row :permalink do
        link_to resource_permalink_url(resource), resource_permalink_url(resource), target: "_blank"
      end
      row :direct_link do
        link_to resource.attachment.url, resource.attachment.url, target: "_blank"
      end
      row :attachment_content_type
      row :include_in_pdf_search if resource.attachment_content_type == "application/pdf"
      row :attachment_file_size do
        number_to_human_size(resource.attachment_file_size)
      end
      row :attachment_updated_at
      row :preview_image do
        if resource.image_file_name.present?
          columns do
            column max_width: "160px" do
              image_tag(resource.image.url(:small))
            end

            column do
              ul do
                li link_to('original size', resource.image.url(:original))
                li link_to('large', resource.image.url(:large))
                li link_to('medium', resource.image.url(:medium))
                li link_to('small', resource.image.url(:small))
                li link_to('thumb', resource.image.url(:thumb))
                li link_to('thumb (square)', resource.image.url(:thumb_square))
                li link_to('tiny (square)', resource.image.url(:tiny))
              end
            end
          end

        end
      end
      row :description
    end
  end

  form html: { multipart: true} do |f|
    f.inputs do
      f.input :name
      f.input :resource_type, hint: "ie, application guide, brochure, etc."
      f.input :attachment,  hint: "#{f.object.attachment_file_name} (#{number_to_human_size(f.object.attachment_file_size)})"
      f.input :include_in_pdf_search, hint: "Note: In order to have this PDF file be included in the pro site PDF search page, this box must be checked and Resource type must not be blank." if f.object.attachment_content_type == "application/pdf"
      f.input :image, label: "Preview image", hint: "will be available in several sizes"
      f.input :description, as: :text
      f.input :html, as: :text, hint: "For banners. If present, this HTML will be rendered instead of any attached image."
      f.input :tag_list, label: "Tags", hint: "separated by a comma."
    end
    f.actions
  end
  # :nocov:

end
