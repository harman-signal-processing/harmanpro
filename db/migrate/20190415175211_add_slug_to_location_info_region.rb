class AddSlugToLocationInfoRegion < ActiveRecord::Migration[5.2]
  def change
    add_column :location_info_regions, :slug, :string, after: :id
    add_index :location_info_regions, :slug, unique: true     
  end
end
