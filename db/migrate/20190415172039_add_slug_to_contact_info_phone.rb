class AddSlugToContactInfoPhone < ActiveRecord::Migration[5.2]
  def change
    add_column :contact_info_phones, :slug, :string, after: :id
    add_index :contact_info_phones, :slug, unique: true      
  end
end
