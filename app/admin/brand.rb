ActiveAdmin.register Brand do
  menu parent: "Brands & Products", priority: 1, label: "Brands"
  config.sort_order = 'name_asc'

  permit_params :name,
    :url,
    :downloads_page_url,
    :support_url,
    :marketing_url,
    :training_url,
    :tech_url,
    :logo,
    :white_logo,
    :by_harman_logo,
    :logo_collection,
    :description,
    :show_on_main_site,
    :show_on_services_site,
    :show_on_consultant_page,
    :api_url,
    :tech_support_email,
    :parts_email,
    :repair_email,
    :contact_info_for_consultants

  # :nocov:
  index do
    column :logo do |b|
      if b.logo_file_name.present?
        image_tag b.logo.url(:tiny)
      end
    end
    column :name
    column :url
    column :show_on_main_site
    column :show_on_services_site
    column :show_on_consultant_page
    actions
  end

  filter :name, as: :string

  show do
    attributes_table do
      row :description do
        raw(textilize(brand.description))
      end
      row :logo do
        if brand.logo_file_name.present?
          link_to(image_tag(brand.logo.url(:small)), brand.logo.url)
        end
      end
      row :white_logo do
        if brand.white_logo_file_name.present?
          link_to(image_tag(brand.white_logo.url(:small)), brand.white_logo.url)
        end
      end
      row :by_harman_logo do
        if brand.by_harman_logo_file_name.present?
          link_to(image_tag(brand.by_harman_logo.url(:small)), brand.by_harman_logo.url)
        end
      end
      row :logo_collection do
        if brand.logo_collection_file_name.present?
          link_to("Logo collection", brand.logo_collection.url)
        end
      end
      row :show_on_main_site
      row :show_on_services_site
      row :show_on_consultant_page
      row :contact_info_for_consultants do
        raw(textilize(brand.contact_info_for_consultants))
      end
      row :url
      row :downloads_page_url
      row :support_url
      row :marketing_url
      row :training_url
      row :tech_url
      row :api_url
      row :tech_support_email
      row :parts_email
      row :repair_email
    end
    active_admin_comments
  end

  form html: {multipaart: true} do |f|
    f.inputs do
      f.input :name
      f.input :url, placeholder: "http://brand.name.com"
      f.input :support_url, hint: "If present, appears on contacts page.", placeholder: "http://brand.name.com/support"
      f.input :training_url, hint: "If present, appears on the training page.", placeholder: "http://brand.name.com/training"
      f.input :tech_url, hint: "Appears on the service center login page if present.", placeholder: "http://tech.brand.com"
      f.input :marketing_url, hint: "IE, marketing toolkit, marcomm bank, etc.", placeholder: "http://mark.eting.url"
      f.input :logo, hint: f.object.logo.present? ?
        image_tag(f.object.logo.url(:tiny)) : "Logo not uploaded yet"
      f.input :white_logo, hint: f.object.white_logo.present? ?
        image_tag(f.object.white_logo.url(:tiny)) : "White logo not uploaded yet"
      f.input :by_harman_logo, hint: f.object.by_harman_logo.present? ?
        image_tag(f.object.by_harman_logo.url(:tiny)) : "By Harman logo not uploaded yet"
      f.input :logo_collection, hint: "Zipped collection of all pertinent brand logo variants"
      f.input :description
      f.input :show_on_main_site
      f.input :show_on_services_site
      f.input :show_on_consultant_page
      f.input :api_url, hint: "Base URL for API queries.", placeholder: "http://brand.com/api/v2/brand"
      f.input :downloads_page_url, hint: "If API URL is blank, and this is present, the link will appear on the consultants page.", placeholder: "http://brand.name.com/downloads"
      f.input :contact_info_for_consultants
      f.input :tech_support_email, hint: "Provide this to appear on the technical support form on the service page."
      f.input :parts_email, hint: "Provide this to appear on the parts section of the support form on the service page."
      f.input :repair_email, hint: "Provide this to appear on the repair section of the support form on the service page."
    end
    f.actions
  end
  # :nocov:
end
