class AddHiddenTitleToTrainingContentPages < ActiveRecord::Migration
  def change
    add_column :training_content_pages, :hide_title, :boolean
  end
end
