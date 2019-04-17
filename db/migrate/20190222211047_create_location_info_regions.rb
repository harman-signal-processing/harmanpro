class CreateLocationInfoRegions < ActiveRecord::Migration[5.2]
  def change
    create_table :location_info_regions do |t|
      t.string :name

      t.timestamps
    end
    add_index :location_info_regions, :name
  end
end
