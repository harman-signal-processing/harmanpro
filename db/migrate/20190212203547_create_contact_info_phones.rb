class CreateContactInfoPhones < ActiveRecord::Migration[5.2]
  def change
    create_table :contact_info_phones do |t|
      t.string :label
      t.string :phone

      t.timestamps
    end
    add_index :contact_info_phones, :label
    add_index :contact_info_phones, :phone
  end
end
