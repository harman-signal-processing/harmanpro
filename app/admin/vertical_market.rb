ActiveAdmin.register VerticalMarket do
  menu label: "Vertical Markets", priority: 1

  permit_params :name,
    :parent_id,
    :headline,
    :description,
    :extra_content,
    :icon,
    :banner,
    :background,
    :hef_banner,
    :lead_form_content,
    :live,
    :retail,
    :show_hef,
    :hide_buy_section,
    :preview_code,
    :hide_image,
    case_study_vertical_markets_attributes: [:id, :case_study_id, :_destroy]


  config.sort_order = "parent_id"

  # :nocov:
  index do
    selectable_column
    column :name
    column :parent
    column "Reference Systems" do |v|
      v.reference_systems.size
    end
    column :retail
    column :show_hef
    column :live
    actions
  end
  # :nocov:

  controller do
    # Overriding ActiveAdmin apply_filtering method to provide distinct results
    # The need arose when searching by name. Translated records were causing duplicate rows to be shown.
    # https://github.com/activeadmin/activeadmin/issues/4171
    def apply_filtering(chain)
       @search = chain.ransack(params[:q] || {})
       @search.result(distinct: true)
    end
  end

  filter :translations_name_contains, as: :string, label: "Search Names"
  filter :parent, as: :select
  filter :live
  filter :retail
  filter :show_hef
  filter :updated_at

  # :nocov:
  sidebar "Child Verticals", only: [:show, :edit] do
    ul do
      li link_to("+ New Child Vertical Market", new_admin_vertical_market_path)
      vertical_market.children.each do |cv|
        li link_to(cv.name, [:admin, cv])
      end
    end
  end

  sidebar "Reference Systems", only: [:show, :edit] do
    ul do
      unless vertical_market.children.size > 0
        li link_to("+ New Reference System", new_admin_vertical_market_reference_system_path(vertical_market))
      end
      vertical_market.reference_systems.each do |e|
        li link_to(e.name, [:admin, vertical_market, e])
      end
    end
  end

  sidebar "Case Studies", only: [:show, :edit] do
    ul do
      unless vertical_market.children.size > 0
        li link_to("+ New Case Study", new_admin_case_study_path)
      end
      vertical_market.case_studies.each do |c|
        li link_to(c.name, [:admin, c])
      end
    end
  end

  form html: { multipart: true} do |f|
    f.inputs do
      f.input :live
      f.input :parent
      f.input :name, hint: "Maximum characters: 25", input_html: {maxlength: 25}
      f.input :headline, hint: "Maximum characters: 70", input_html: { maxlength: 70 }
      f.input :icon, hint: f.object.icon.present? ?
        image_tag(f.object.icon.url(:thumb)) + content_tag(:br) + "Appears on the overall solutions index." : "Appears on the overall solutions index. Preferred size is 93x93 px."
      f.input :banner, hint: f.object.banner.present? ?
        image_tag(f.object.banner.url(:thumb)) + content_tag(:br) + "Appears on solutions pages on brand sites. Preferred size: 1170x400 px with a strongly horizontal orientation." :
        "Appears on solutions pages on brand sites. Preferred size: 1170x400 px with a strongly horizontal orientation."
      f.input :hide_image, hint: "Check this box if you don't want the header image to appear on the page."
      f.input :background, hint: f.object.background.present? ?
        image_tag(f.object.background.url(:thumb)) + content_tag(:br) + "Used for top-level verticals on the homepage and on the category page." :
        "Used for top-level verticals on the homepage and on the category page."
      f.input :hef_banner, hint: f.object.hef_banner.present? ?
        image_tag(f.object.hef_banner.url(:thumb)) + content_tag(:br) + "Appears on solutions pages as Harman Finance background. Preferred size: 1170x400 px with a strongly horizontal orientation." :
        "Appears on solutions pages as Harman Finance background. Preferred size: 750x70 px with a strongly horizontal orientation."
      f.input :description, hint: "Maximum recommended characters: 650", as: :text, input_html: { rows: 10 }
      f.input :extra_content, as: :text, hint: "Appears after the case studies", input_html: { rows: 10, class: "mceEditor"}
      f.input :retail, label: "Offer retailer/ecommerce links with this vertical market."
      f.input :lead_form_content, as: :text, hint: "Replaces the retailer links if present and the default lead form.", input_html: { class: "mceEditor"}
      f.input :hide_buy_section, label: "Hide both the retailer links and the lead capture form."
      f.input :show_hef, label: "Show the Harman finance strip on this vertical market's page."
      f.input :preview_code, hint: "Put something here if you want to allow someone to preview the page before it goes live. Then, give them the link with ?preview_code=(whatever) at the end."
    end
    f.has_many :case_study_vertical_markets, heading: "Case Studies", new_record: "Add a case study" do |s|
      s.input :id, as: :hidden
      s.input :case_study, collection: CaseStudy.with_translations(I18n.locale).order(:headline)
      s.input :_destroy, as: :boolean, label: "Delete"
    end
    f.actions
  end
  # :nocov:

end
