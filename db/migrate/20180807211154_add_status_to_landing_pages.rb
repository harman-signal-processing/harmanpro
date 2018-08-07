class AddStatusToLandingPages < ActiveRecord::Migration[5.1]
  def change
    add_column :landing_pages, :live, :boolean, default: true
    add_column :landing_pages, :preview_code, :string

    LandingPage.update_all(live: true)
  end
end
