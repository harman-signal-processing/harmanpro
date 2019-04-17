class CreateContactInfoEmails < ActiveRecord::Migration[5.2]
  def change
    create_table :contact_info_emails do |t|
      t.string :label
      t.string :email

      t.timestamps
    end
    add_index :contact_info_emails, :label
    add_index :contact_info_emails, :email
  end
end
