class CreateContactInfoContactTerritories < ActiveRecord::Migration[5.2]
  def change
    create_table :contact_info_contact_territories do |t|
      t.integer :position, index: true
      t.references :contact_info_contact, foreign_key: true, index: {name:'idx_contact_territories_on_contact_id'}
      t.references :contact_info_territory, foreign_key: true, index: {name:'idx_contact_territories_on_territory_id'}

      t.timestamps
    end
  end
end
