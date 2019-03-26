class CreateContactInfoTerritories < ActiveRecord::Migration[5.2]
  def change
    create_table :contact_info_territories do |t|
      t.string :name

      t.timestamps
    end
    add_index :contact_info_territories, :name
  end
end
