class CreateContactInfoPhones < ActiveRecord::Migration[5.2]
  def change
    create_table :contact_info_phones do |t|
      t.string :label

      t.timestamps
    end
  end
end
