class AddBannerHtmlToLandingPages < ActiveRecord::Migration[7.1]
  def change
    add_column :landing_pages, :banner_html, :text
  end
end
