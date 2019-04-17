class AddSlugToLocationInfoLocation < ActiveRecord::Migration[5.2]
  def change
    add_column :location_info_locations, :slug, :string, after: :id
    add_index :location_info_locations, :slug, unique: true     
  end
end
