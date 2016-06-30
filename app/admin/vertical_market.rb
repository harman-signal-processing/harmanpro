ActiveAdmin.register VerticalMarket do
  menu label: "Vertical Markets", priority: 1

  permit_params :name, :parent_id, :headline, :description, :banner, :lead_form_content

  config.sort_order = "parent_id"

  # :nocov:
  index do
    selectable_column
    column :name
    column :parent
    column "Reference Systems" do |v|
      v.reference_systems.length
    end
    actions
  end
  # :nocov:

  filter :parent, as: :select
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
        li link_to("+ New Case Study", new_admin_vertical_market_case_study_path(vertical_market))
      end
      vertical_market.case_studies.each do |c|
        li link_to(c.name, [:admin, vertical_market, c])
      end
    end
  end

  form html: { multipart: true} do |f|
    f.inputs do
      f.input :parent
      f.input :name, hint: "Maximum characters: 20", input_html: {maxlength: 20}
      f.input :headline, hint: "Maximum characters: 70", input_html: { maxlength: 70 }
      f.input :banner, hint: "Only needed for a vertical which acts as a parent for other vertical markets. Preferred size: 1170x624 px with a strongly horizontal orientation."
      f.input :description, hint: "Maximum characters: 650", input_html: { rows: 10 }
      f.input :lead_form_content, input_html: { class: "mceEditor"}
    end
    f.actions
  end
  # :nocov:

end
