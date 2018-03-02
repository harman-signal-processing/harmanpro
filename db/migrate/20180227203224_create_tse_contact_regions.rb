class CreateTseContactRegions < ActiveRecord::Migration[5.1]
  def change
    create_table :tse_contact_regions do |t|
      t.integer :tse_contact_id
      t.integer :tse_region_id
      t.integer :rank

      t.timestamps
    end
    add_index :tse_contact_regions, :tse_contact_id
    add_index :tse_contact_regions, :tse_region_id
  end
end
