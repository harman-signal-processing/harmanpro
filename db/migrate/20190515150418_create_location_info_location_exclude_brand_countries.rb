class CreateLocationInfoLocationExcludeBrandCountries < ActiveRecord::Migration[5.2]
  def change
    create_table :location_info_location_exclude_brand_countries do |t|
      t.references :location_info_location, foreign_key: true, index: {name:'idx_location_exclude_on_location_id'}
      t.references :brand, foreign_key: true, type: :integer,  index: {name:'idx_location_exclude_on_supported_brands_brand_id'} 
      t.references :location_info_country, foreign_key: true, index: {name:'idx_location_exclude_on_country_id'}      
      t.timestamps
    end
  end
end
