ActiveAdmin.register CaseStudy do
  menu label: "Case Studies", priority: 2

  # :nocov:
  permit_params :headline, :description, :content, :banner, :pdf, :pdf_external_url, :youtube_id, :delete_pdf,
    case_study_vertical_markets_attributes: [:id, :vertical_market_id, :show_on_vertical_market_page, :_destroy],
    case_study_brands_attributes: [:id, :brand_id, :_destroy]

  config.paginate = false
  #config.sort_order = 'name_asc'

  filter :vertical_markets, collection: -> { VerticalMarket.all.order(:name) }
  filter :brands, collection: -> { Brand.for_case_studies }

  index do
    selectable_column
    column :headline
    column :vertical_markets do |c|
      c.vertical_markets.map do |v|
        v.name
      end.join(', ')
    end
    column :brands do |c|
      c.brands.map do |v|
        v.name
      end.join(', ')
    end
    actions
  end  #  index do

  show do
    attributes_table do
      row :created_at do
        case_study.created_at.strftime("%b %d, %Y %I:%M %p") if case_study.created_at.present?
      end
      row :updated_at do
        case_study.updated_at.strftime("%b %d, %Y %I:%M %p") if case_study.updated_at.present?
      end
      row :banner_file_name do
        if case_study.banner_file_name.present?
          text_node "#{case_study.banner_file_name}<br />".html_safe
          link_to(image_tag(case_study.banner.url(:small), lazy: false), case_study.banner.url, target: "_blank")
        end
      end  #  row :banner_file_name do
      row :banner_content_type
      row :banner_file_size do
        number_to_human_size(case_study.banner_file_size)
      end
      row :banner_updated_at do
        case_study.banner_updated_at.strftime("%b %d, %Y %I:%M %p") if case_study.banner_updated_at.present?
      end
      row :pdf_file_name do
        if case_study.pdf_file_name.present?
          link_to(case_study.pdf_file_name, case_study.pdf.url, target: "_blank")
        end
      end  #  row :pdf_file_name do
      row :pdf_content_type
      row :pdf_file_size do
        number_to_human_size(case_study.pdf_file_size)
      end
      row :pdf_update_at do
        case_study.pdf_updated_at.strftime("%b %d, %Y %I:%M %p") if case_study.pdf_updated_at.present?
      end
      row :pdf_external_url do
        if case_study.pdf_external_url.present?
          link_to(case_study.pdf_external_url, target: "_blank")
        end
      end  #  row :pdf_external_url do

      row :youtube_id do |case_study|
        if case_study.youtube_id.present?
          raw("#{link_to "https://www.youtube.com/embed/#{case_study.youtube_id}", "https://www.youtube.com/embed/#{case_study.youtube_id}", target: "_blank"}<br>" +
          "#{link_to(image_tag("https://i.ytimg.com/vi/#{case_study.youtube_id}/default.jpg", alt: "Case Study Video", lazy: false), "https://www.youtube.com/embed/#{case_study.youtube_id}", target: "_blank")} ")
        end
      end  #  row :youtube_id do |case_study|

    end  #  attributes_table do
  end  #  show do

  sidebar "Vertical Markets", only: [:show] do
    ul do
      case_study.vertical_markets.each do |c|
        li link_to(c.name, [:admin, c])
      end
    end
  end  #  sidebar "Vertical Markets", only: [:show] do

  sidebar "Brands", only: [:show] do
    ul do
      case_study.brands.each do |c|
        li link_to(c.name, [:admin, c])
      end
    end
  end  #  sidebar "Brands", only: [:show] do

  form html: { multipart: true} do |f|
    f.inputs do
      f.input :banner, hint: f.object.banner.present? ?
        image_tag(f.object.banner.url(:thumb), lazy: false) + content_tag(:br) + "Preferred size: 1170x400 px with a strongly horizontal orientation." :
        "Preferred size: 1170x400 px with a strongly horizontal orientation."

      f.input :headline, hint: "Maximum characters: 50", input_html: { maxlength: 50 }
      
      # Most have been created without the description. So now it looks funny when one of them shows up...
      # f.input :description, hint: "Maximum characters: 60", input_html: { maxlength: 60, rows: 5 }

      f.input :pdf_external_url, label: "Link to PDF", hint: "Use this when the PDF is hosted elsewhere.", placeholder: "http://path.to/external.pdf"
      f.input :pdf, label: "Attached PDF",
        hint:
            if f.object.pdf_file_name.present?
              raw("Use this when uploading a PDF directly to this Case Study.<br />" +
              "The current PDF file is below.<br />" +
              "#{link_to(case_study.pdf_file_name, case_study.pdf.url, target: '_blank')} ")
            else
              "Use this when uploading a PDF directly to this Case Study."
            end
      f.input :delete_pdf, as: :boolean, label: "Delete the PDF file.", hint: "This will remove the previously saved PDF file when you submit this form." if case_study.pdf.present?

      f.input :youtube_id,
        label: "Link to Youtube video",
        hint:
          if f.object.youtube_id.present?
            raw("If the case study has a Youtube video, enter the Youtube ID (not the full url).<br />" +
            "The current Youtube link is below.<br />" +
            "#{link_to("https://www.youtube.com/embed/#{case_study.youtube_id}", "https://www.youtube.com/embed/#{case_study.youtube_id}", target: "_blank")}" +
            "<br />" +
            "#{link_to(image_tag("https://i.ytimg.com/vi/#{case_study.youtube_id}/default.jpg", alt: "Case Study Video", lazy: false), "https://www.youtube.com/embed/#{case_study.youtube_id}", target: "_blank")} ")
          else
            "If the case study has a Youtube video, enter the Youtube ID (not the full url)."
          end,
        placeholder: "Youtube ID"

      f.input :content, as: :text, input_html: { rows: 15 }
    end  #  f.inputs do

    f.has_many :case_study_vertical_markets, heading: "Vertical Markets", new_record: "Add a vertical market" do |s|
      s.input :id, as: :hidden
      s.input :vertical_market, collection: VerticalMarket.with_translations(I18n.locale).order(:name)
      s.input :show_on_vertical_market_page
      s.input :_destroy, as: :boolean, label: "Delete"
    end  #  f.has_many :case_study_vertical_markets, heading: "Vertical Markets", new_record: "Add a vertical market" do |s|

    f.has_many :case_study_brands, heading: "Brands", new_record: "Associate with brand" do |b|
      b.input :id, as: :hidden
      b.input :brand, collection: Brand.for_case_studies
      b.input :_destroy, as: :boolean, label: "Delete"
    end  #  f.has_many :case_study_brands, heading: "Brands", new_record: "Associate with brand" do |b|

    f.actions
  end  #  form html: { multipart: true} do |f|
  # :nocov:

end  #  ActiveAdmin.register CaseStudy do

