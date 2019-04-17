class CreateLocationInfoCountries < ActiveRecord::Migration[5.2]
  def change
    create_table :location_info_countries do |t|
      t.string :name, index: true
      t.string :harman_name, index: true
      t.string :alpha2, index: true
      t.string :alpha3, index: true
      t.string :continent
      t.string :region
      t.string :sub_region
      t.string :world_region
      t.string :harman_world_region, index: true
      t.integer :calling_code
      t.integer :numeric_code
  

      t.timestamps
    end

  end
end
