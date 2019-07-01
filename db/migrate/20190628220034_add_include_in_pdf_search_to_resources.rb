class AddIncludeInPdfSearchToResources < ActiveRecord::Migration[5.2]
  def change
    add_column :resources, :include_in_pdf_search, :boolean
  end
end
