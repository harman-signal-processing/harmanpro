class AddContentToCaseStudies < ActiveRecord::Migration
  def change
    add_column :case_studies, :content, :text
  end
end
