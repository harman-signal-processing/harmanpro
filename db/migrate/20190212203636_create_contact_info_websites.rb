class CreateContactInfoWebsites < ActiveRecord::Migration[5.2]
  def change
    create_table :contact_info_websites do |t|
      t.string :label
      t.string :url

      t.timestamps
    end
    add_index :contact_info_websites, :label
    add_index :contact_info_websites, :url
  end
end
