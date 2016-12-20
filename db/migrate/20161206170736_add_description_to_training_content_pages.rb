class AddDescriptionToTrainingContentPages < ActiveRecord::Migration
  def change
    add_column :training_content_pages, :description, :string
  end
end
