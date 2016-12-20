class AddCustomSlugToTrainingContentPages < ActiveRecord::Migration
  def change
    add_column :training_content_pages, :custom_slug, :string
  end
end
