class AddPdfsToCaseStudies < ActiveRecord::Migration[5.1]
  def change
    add_attachment :case_studies, :pdf
    add_column :case_studies, :pdf_external_url, :string
  end
end
