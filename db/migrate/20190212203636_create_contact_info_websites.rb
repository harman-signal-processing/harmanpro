class CreateContactInfoWebsites < ActiveRecord::Migration[5.2]
  def change
    create_table :contact_info_websites do |t|
      t.string :label
      t.string :url

      t.timestamps
    end
  end
end
