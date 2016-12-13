ActiveAdmin.register VerticalMarket do
  menu label: "Vertical Markets", priority: 1

  permit_params :name,
    :parent_id,
    :headline,
    :description,
    :extra_content,
    :banner,
    :background,
    :lead_form_content,
    :live,
    :retail,
    case_study_vertical_markets_attributes: [:id, :case_study_id, :_destroy]


  config.sort_order = "parent_id"

  # :nocov:
  index do
    selectable_column
    column :name
    column :parent
    column "Reference Systems" do |v|
      v.reference_systems.length
    end
    column :live
    actions
  end
  # :nocov:

  filter :parent, as: :select
  filter :live
  #filter :name, as: :string
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
      unless vertical_market.children.length > 0
        li link_to("+ New Reference System", new_admin_vertical_market_reference_system_path(vertical_market))
      end
      vertical_market.reference_systems.each do |e|
        li link_to(e.name, [:admin, vertical_market, e])
      end
    end
  end

  sidebar "Case Studies", only: [:show, :edit] do
    ul do
      unless vertical_market.children.length > 0
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
      f.input :retail, label: "Offer retailer/ecommerce links with this vertical market."
      f.input :parent
      f.input :name, hint: "Maximum characters: 20", input_html: {maxlength: 20}
      f.input :headline, hint: "Maximum characters: 70", input_html: { maxlength: 70 }
      f.input :banner, hint: "Appears on solutions pages on brand sites. Preferred size: 1170x400 px with a strongly horizontal orientation."
      f.input :background, hint: "Used for top-level verticals on the homepage and on the category page."
      f.input :description, hint: "Maximum recommended characters: 650", input_html: { rows: 10 }
      f.input :extra_content, hint: "Appears after the case studies", input_html: { rows: 10, class: "mceEditor"}
      f.input :lead_form_content, input_html: { class: "mceEditor"}
    end
    f.has_many :case_study_vertical_markets, heading: "Case Studies", new_record: "Add a case study" do |s|
      s.input :id, as: :hidden
      s.input :case_study
      s.input :_destroy, as: :boolean, label: "Delete"
    end
    f.actions
  end
  # :nocov:

end
