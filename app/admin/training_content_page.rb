ActiveAdmin.register TrainingContentPage do

  menu label: "Training Content Pages"

  permit_params :title,
    :subtitle,
    :description,
    :main_content,
    #:left_content,
    :right_content,
    :sub_content,
    :hide_title,
    :banner,
    :delete_banner,
    :custom_slug,
    :header_code,
    :footer_code

  # :nocov:
  
  # This is for the page showing the list of Training Content Pages
  index do
    selectable_column
    id_column
    column :locale do |tcp|
      if tcp.original_locale
        tcp.original_locale.key
      end
    end
    column :title do |tcp|
      if tcp.original_locale
        Globalize.with_locale(tcp.original_locale.key) do
          tcp.title
        end
      else
        tcp.title
      end
    end
    column "Link" do |tcp|
      begin
        if tcp.original_locale && tcp.original_locale != AvailableLocale.default
          link_to "Direct Link", training_content_page_path(tcp, locale: tcp.original_locale.key), target: "_blank"
        else
          this_slug = tcp.custom_slug.present? ? tcp.custom_slug : tcp.slug
          link_to "Direct Link", training_content_page_path(id: this_slug), target: "_blank"
        end
      rescue
        link_to "Direct Link", training_content_page_path(tcp), target: "_blank"
      end
    end
    column :created_at
    column :banner do |b|
      b.banner_file_name.present?
    end
    actions
  end

# Can't filter by title since it is Globalized now
#  filter :title, as: :string
  filter :original_locale
  filter :updated_at

  # This is for readonly view of the choosen Training Content Page
  show do
    attributes_table do
      row :banner do |b|
        if b.banner_file_name.present?
          image_tag b.banner.url(:small)
        end
      end  #  row :banner do |b|
      row :title
      row :hide_title
      row :subtitle
      row :description
      row :direct_link do
        if training_content_page.original_locale && training_content_page.original_locale != AvailableLocale.default
          link_to "Direct Link", training_content_page_path(training_content_page, locale: training_content_page.original_locale.key), target: "_blank"
        else
          this_slug = training_content_page.custom_slug.present? ? training_content_page.custom_slug : training_content_page.slug
          link_to "Direct Link", training_content_page_path(id: this_slug), target: "_blank"
        end
      end

      row :main_content do
        raw(textilize(training_content_page.main_content))
      end

      #row :left_content do
      #  raw(textilize(training_content_page.left_content))
      #end

      row :right_content do
        raw(textilize(training_content_page.right_content))
      end

      row :sub_content do
        raw(textilize(training_content_page.sub_content))
      end

      row :header_code
      row :footer_code
    end
  end  #  show do
  

  # This is for the edit view of the choosen Training Content Page
  form html: { multipart: true} do |f|
    f.inputs do
      f.input :title
      f.input :custom_slug, label: "Custom Friendly ID", hint: "Almost always leave this blank--unless the person requesting the page is smarter than you are and he/she needs a specific URL that doesn't match the page title. Don't include the page format (html, xml, js, etc.)"
      f.input :hide_title, label: "Hide big, h1 title tag"
      f.input :subtitle
      f.input :description, hint: "appears as meta description in HTML for page"
      f.input :banner, :as => :file, :hint => image_tag(f.object.banner.url(:small), title:"Current banner")
      f.input :delete_banner, label: "Delete banner", as: :boolean
      f.input :main_content, as: :text, input_html: { class: "mceEditor"}
      f.input :right_content, as: :text, hint: "(optional)", input_html: { class: "mceEditor"}
      f.input :sub_content, as: :text, hint: "(optional)", input_html: { class: "mceEditor"}
      f.input :header_code, as: :text, hint: "Javascript, etc. here will load in the page's HTML header"
      f.input :footer_code, as: :text, hint: "Javascript, etc. here will load just before the page's closing body tag"
    end  #  f.inputs do
    f.actions
  end  #  form html: { multipart: true} do |f|
  # :nocov:

end  #  ActiveAdmin.register TrainingContentPage do
