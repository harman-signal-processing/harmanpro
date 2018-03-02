class CreateTseCategoryContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :tse_category_contacts do |t|
      t.integer :tse_category_id
      t.integer :tse_contact_id

      t.timestamps
    end
    add_index :tse_category_contacts, :tse_category_id
    add_index :tse_category_contacts, :tse_contact_id
  end
end
