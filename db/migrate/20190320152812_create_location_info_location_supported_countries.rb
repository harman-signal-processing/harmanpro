class CreateLocationInfoLocationSupportedCountries < ActiveRecord::Migration[5.2]
  def change
    create_table :location_info_location_supported_countries do |t|
      t.integer :position, index: true
      t.references :location_info_location, foreign_key: true, index: {name:'idx_location_supported_countries_on_location_id'}
      t.references :location_info_country, foreign_key: true, index: {name:'idx_location_supported_countries_on_country_id'}      
      
      t.timestamps
    end
  end
end
