ActiveAdmin.register CaseStudy do
  menu label: "Case Studies", priority: 2

  # :nocov:
  permit_params :headline, :description, :content, :banner, :pdf, :pdf_external_url,
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
      f.input :banner, hint: f.object.banner.present? ?
        image_tag(f.object.banner.url(:thumb)) + content_tag(:br) + "Preferred size: 1170x400 px with a strongly horizontal orientation." :
        "Preferred size: 1170x400 px with a strongly horizontal orientation."
      f.input :headline, hint: "Maximum characters: 40", input_html: { maxlength: 40 }
      f.input :description, hint: "Maximum characters: 60", input_html: { maxlength: 60, rows: 5 }
      f.input :pdf_external_url, label: "Link to PDF", hint: "Use this when the PDF is hosted elsewhere.", placeholder: "http://path.to/external.pdf"
      f.input :pdf, label: "Attached PDF", hint: "Use this when uploading a PDF directly to this Case Study."
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

