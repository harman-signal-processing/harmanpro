class AddOriginalLocaleToTrainingContentPages < ActiveRecord::Migration
  def change
    add_column :training_content_pages, :original_locale_id, :integer
    add_index :training_content_pages, :original_locale_id    
  end
end
