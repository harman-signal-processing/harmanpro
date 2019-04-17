class AddSlugToContactInfoTerritory < ActiveRecord::Migration[5.2]
  def change
    add_column :contact_info_territories, :slug, :string, after: :id
    add_index :contact_info_territories, :slug, unique: true     
  end
end
