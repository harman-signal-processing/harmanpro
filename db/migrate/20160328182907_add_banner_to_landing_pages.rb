class AddBannerToLandingPages < ActiveRecord::Migration
  def change
    add_column :landing_pages, :banner_file_name, :string
    add_column :landing_pages, :banner_content_type, :string
    add_column :landing_pages, :banner_updated_at, :datetime
    add_column :landing_pages, :banner_file_size, :integer
  end
end
