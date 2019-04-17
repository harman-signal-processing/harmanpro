class AddSlugToContactInfoContact < ActiveRecord::Migration[5.2]
  def change
    add_column :contact_info_contacts, :slug, :string, after: :id
    add_index :contact_info_contacts, :slug, unique: true    
  end
end
