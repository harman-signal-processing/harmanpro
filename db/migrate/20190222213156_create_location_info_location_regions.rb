class CreateLocationInfoLocationRegions < ActiveRecord::Migration[5.2]
  def change
    create_table :location_info_location_regions do |t|
      t.references :location_info_location, foreign_key: true, index: {name:'idx_location_regions_on_location_id'}      
      t.references :location_info_region, foreign_key: true, index: {name:'idx_location_regions_on_region_id'}      
      t.integer :position, index: true

      t.timestamps
    end
  end
end
