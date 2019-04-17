class AddSlugToContactInfoEmail < ActiveRecord::Migration[5.2]
  def change
    add_column :contact_info_emails, :slug, :string, after: :id
    add_index :contact_info_emails, :slug, unique: true     
  end
end
