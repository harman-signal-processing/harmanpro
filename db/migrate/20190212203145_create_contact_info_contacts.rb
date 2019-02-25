class CreateContactInfoContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contact_info_contacts do |t|
      t.string :label
      t.string :name
      t.string :title

      t.timestamps
    end
  end
end
