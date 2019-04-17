class CreateLocationInfoLocationEmails < ActiveRecord::Migration[5.2]
  def change
    create_table :location_info_location_emails do |t|
      t.integer :position, index: true
      t.references :location_info_location, foreign_key: true, index: {name:'idx_location_emails_on_location_id'}
      t.references :contact_info_email, foreign_key: true, index: {name:'idx_location_emails_on_email_id'}      
      
      t.timestamps
    end
  end
end
