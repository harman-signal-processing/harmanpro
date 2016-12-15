class AddCodeToTrainingContentPages < ActiveRecord::Migration
  def change
    add_column :training_content_pages, :header_code, :text
    add_column :training_content_pages, :footer_code, :text    
  end
end
