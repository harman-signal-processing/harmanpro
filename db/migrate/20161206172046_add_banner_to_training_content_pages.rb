class AddBannerToTrainingContentPages < ActiveRecord::Migration
  def change
    add_column :training_content_pages, :banner_file_name, :string
    add_column :training_content_pages, :banner_content_type, :string
    add_column :training_content_pages, :banner_updated_at, :datetime
    add_column :training_content_pages, :banner_file_size, :integer    
  end
end
