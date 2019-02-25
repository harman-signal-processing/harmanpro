class CreateLocationInfoLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :location_info_locations do |t|
      t.string :name
      t.string :address1
      t.string :address2
      t.string :address3
      t.string :city
      t.string :state
      t.string :country
      t.string :postal
      t.string :lat
      t.string :lng
      t.string :google_map_place_id

      t.timestamps
    end
  end
end
