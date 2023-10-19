class AddOtherImagesToNews < ActiveRecord::Migration[7.0]
  def change
    add_column :news_articles, :narrow_banner_file_name, :string
    add_column :news_articles, :narrow_banner_content_type, :string
    add_column :news_articles, :narrow_banner_file_size, :integer
    add_column :news_articles, :narrow_banner_updated_at, :datetime
  end
end
