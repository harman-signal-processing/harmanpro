class AddSlugToContactInfoWebsite < ActiveRecord::Migration[5.2]
  def change
    add_column :contact_info_websites, :slug, :string, after: :id
    add_index :contact_info_websites, :slug, unique: true     
  end
end
