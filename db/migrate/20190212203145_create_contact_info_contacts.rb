class CreateContactInfoContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contact_info_contacts do |t|
      t.string :label
      t.string :name
      t.string :title

      t.timestamps
    end
    
    add_index :contact_info_contacts, :label
    add_index :contact_info_contacts, :name
    add_index :contact_info_contacts, :title
  end
end
