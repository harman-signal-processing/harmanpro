class CreateContactInfoContactWebsites < ActiveRecord::Migration[5.2]
  def change
    create_table :contact_info_contact_websites do |t|
      t.integer :position
      t.references :contact_info_contact, foreign_key: true
      t.references :contact_info_website, foreign_key: true

      t.timestamps
    end
  end
end
