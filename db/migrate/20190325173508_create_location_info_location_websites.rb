class CreateLocationInfoLocationWebsites < ActiveRecord::Migration[5.2]
  def change
    create_table :location_info_location_websites do |t|
      t.integer :position, index: true
      t.references :location_info_location, foreign_key: true, index: {name:'idx_location_websites_on_location_id'}
      t.references :contact_info_website, foreign_key: true, index: {name:'idx_location_websites_on_website_id'}
      
      t.timestamps
    end
  end
end
