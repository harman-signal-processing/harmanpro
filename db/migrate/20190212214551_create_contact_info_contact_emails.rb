class CreateContactInfoContactEmails < ActiveRecord::Migration[5.2]
  def change
    create_table :contact_info_contact_emails do |t|
      t.integer :position, index: true
      t.references :contact_info_contact, foreign_key: true
      t.references :contact_info_email, foreign_key: true

      t.timestamps
    end
  end
end
