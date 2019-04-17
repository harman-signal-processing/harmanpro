class CreateDistributorInfoDistributorLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :distributor_info_distributor_locations do |t|
      t.integer :position, index: true
      t.references :distributor_info_distributor, foreign_key: true, index: {name:'idx_distributor_locations_on_distributor_id'}
      t.references :location_info_location, foreign_key: true, index: {name:'idx_distributor_locations_on_location_id'}

      t.timestamps
    end
  end
end
