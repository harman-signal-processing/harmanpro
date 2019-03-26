class CreateLocationInfoLocationSupportedBrands < ActiveRecord::Migration[5.2]
  def change
    create_table :location_info_location_supported_brands do |t|
      t.references :location_info_location, foreign_key: true, index: {name:'idx_location_info_on_supported_brands_location_id'} 
      t.references :brand, foreign_key: true, type: :integer,  index: {name:'idx_location_info_on_supported_brands_brand_id'} 
      t.integer :position, index: true
      t.timestamps
    end
  end
end
