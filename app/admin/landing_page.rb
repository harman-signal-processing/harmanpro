ActiveAdmin.register LandingPage do
  menu label: "Landing Pages"

  permit_params :title,
    :subtitle,
    :description,
    :main_content,
    :left_content,
    :right_content,
    :sub_content,
    :hide_title,
    :banner

  # :nocov:
  index do
    selectable_column
    column :title
    column "Link" do |lp|
      link_to "Direct Link", landing_page_path(lp), target: "_blank"
    end
    column :created_at
    actions
  end

#  filter :title, as: :string
  filter :updated_at

  show do
    attributes_table do
      row :banner do |b|
        if b.banner_file_name.present?
          image_tag b.banner.url(:small)
        end
      end
      row :title
      row :hide_title
      row :subtitle
      row :description
      row :direct_link do
        link_to landing_page_url(landing_page), landing_page_url(landing_page), target: "_blank"
      end

      row :main_content do
        raw(textilize(landing_page.main_content))
      end

      row :left_content do
        raw(textilize(landing_page.left_content))
      end

      row :right_content do
        raw(textilize(landing_page.right_content))
      end

      row :sub_content do
        raw(textilize(landing_page.sub_content))
      end
    end
    active_admin_comments
  end

  form html: { multipart: true} do |f|
    f.inputs do
      f.input :title
      f.input :hide_title, label: "Hide big, h1 title tag"
      f.input :subtitle
      f.input :description, hint: "appears as meta description in HTML for page"
      f.input :banner
      f.input :main_content, hint: "textilize and/or html permitted"
      f.input :left_content, hint: "(optional)"
      f.input :right_content, hint: "(optional)"
      f.input :sub_content, hint: "(optional)"
    end
    f.actions
  end
  # :nocov:

end
