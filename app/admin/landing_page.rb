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
    :banner,
    :delete_banner,
    :custom_slug,
    :header_code,
    :footer_code,
    :live,
    :preview_code,
    features_attributes: [
      :id,
      :featurable_id,
      :featurable_type,
      :position,
      :content_position,
      :layout_style,
      :image,
      :pre_content,
      :content,
      :_destroy
    ]

  # :nocov:
  index do
    selectable_column
    id_column
    column :locale do |lp|
      if lp.original_locale
        lp.original_locale.key
      end
    end
    column :title do |lp|
      if lp.original_locale
        Globalize.with_locale(lp.original_locale.key) do
          lp.title
        end
      else
        lp.title
      end
    end
    column "Link" do |lp|
      begin
        if lp.original_locale && lp.original_locale != AvailableLocale.default
          link_to "Direct Link", landing_page_path(lp, locale: lp.original_locale.key), target: "_blank"
        else
          this_slug = lp.custom_slug.present? ? lp.custom_slug : lp.slug
          link_to "Direct Link", landing_page_path(id: this_slug), target: "_blank"
        end
      rescue
        link_to "Direct Link", landing_page_path(lp), target: "_blank"
      end
    end
    column :live
    column :created_at
    actions
  end

# Can't filter by title since it is Globalized now
#  filter :title, as: :string
  filter :original_locale
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
        if landing_page.original_locale && landing_page.original_locale != AvailableLocale.default
          link_to "Direct Link", landing_page_path(landing_page, locale: landing_page.original_locale.key), target: "_blank"
        else
          this_slug = landing_page.custom_slug.present? ? landing_page.custom_slug : landing_page.slug
          link_to "Direct Link", landing_page_path(id: this_slug), target: "_blank"
        end
      end
      row :live
      row :preview_code

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

      row :header_code
      row :footer_code
    end
  end

  form html: { multipart: true} do |f|
    f.inputs do
      f.input :title
      f.input :hide_title, label: "Hide the big, h1 title tag. (If checked, then the page title is only used on the browser tab--not the page itself.)"
      f.input :subtitle
      f.input :description, hint: "appears as meta description in HTML for page"
      f.input :banner, hint: f.object.banner.present? ?
        image_tag(f.object.banner.url(:thumb)) :
        "No banner uploaded."
      f.input :delete_banner, label: "Delete the banner (if present).", as: :boolean
      f.has_many :features, heading: "Fancy Features", new_record: "Add a feature" do |s|
        s.input :id, as: :hidden
        s.input :position, label: "Order of appearance"
        s.input :layout_style, as: :radio, collection: Feature.layout_options
        s.input :content_position, as: :radio, label: "Text content position", collection: ["left", "right"]
        s.input :image, label: "Background or side image", hint: s.object.image.present? ?
          image_tag(s.object.image.url(:thumb)) :
          "No image uploaded yet."
        s.input :pre_content, as: :text, label: "Content appearing before the feature", hint: "HTML permitted", input_html: { class: "mceEditor" }
        s.input :content, as: :text, hint: "HTML permitted", input_html: { class: "mceEditor" }
        s.input :_destroy, as: :boolean, label: "Delete This Feature"
      end
      f.input :main_content, as: :text, input_html: { class: "mceEditor"}
      f.input :left_content, as: :text, hint: "(optional)", input_html: { class: "mceEditor"}
      f.input :right_content, as: :text, hint: "(optional)", input_html: { class: "mceEditor"}
      f.input :sub_content, as: :text, hint: "(optional)", input_html: { class: "mceEditor"}
      f.input :header_code, as: :text, hint: "Javascript, etc. here will load in the page's HTML header"
      f.input :footer_code, as: :text, hint: "Javascript, etc. here will load just before the page's closing body tag"
      f.input :custom_slug, label: "Custom Friendly ID", hint: "Almost always leave this blank--unless the person requesting the page is smarter than you are and he/she needs a specific URL that doesn't match the page title. Don't include the page format (html, xml, js, etc.)"
      f.input :live
      f.input :preview_code, hint: "Put something here if you want to allow someone to preview the page before it goes live. Then, give them the link with ?preview_code=(whatever) at the end."
    end
    f.actions
  end
  # :nocov:

end
