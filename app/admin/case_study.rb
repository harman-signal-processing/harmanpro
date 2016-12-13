ActiveAdmin.register CaseStudy do
  menu label: "Case Studies", priority: 2

  # :nocov:
  permit_params :headline, :description, :content, :banner,
    case_study_vertical_markets_attributes: [:id, :vertical_market_id, :_destroy]

  config.paginate = false
  #config.sort_order = 'name_asc'

  filter :vertical_markets

  index do
    selectable_column
    column :headline
    column :vertical_markets do |c|
      c.vertical_markets.map do |v|
        v.name
      end.join(', ')
    end
    actions
  end

  form html: { multipart: true} do |f|
    f.inputs do
      f.input :banner, hint: "Preferred size: 1170x400 px with a strongly horizontal orientation."
      f.input :headline, hint: "Maximum characters: 40", input_html: { maxlength: 40 }
      f.input :description, hint: "Maximum characters: 60", input_html: { maxlength: 60, rows: 5 }
      f.input :content, input_html: { rows: 15 }
    end
    f.has_many :case_study_vertical_markets, heading: "Vertical Markets", new_record: "Add a vertical market" do |s|
      s.input :id, as: :hidden
      s.input :vertical_market
      s.input :_destroy, as: :boolean, label: "Delete"
    end
    f.actions
  end
  # :nocov:

end

