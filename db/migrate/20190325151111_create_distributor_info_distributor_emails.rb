class CreateDistributorInfoDistributorEmails < ActiveRecord::Migration[5.2]
  def change
    create_table :distributor_info_distributor_emails do |t|
      t.integer :position, index: true
      t.references :distributor_info_distributor, foreign_key: true, index: {name: 'idx_distributor_emails_on_distributor_id'}
      t.references :contact_info_email, foreign_key: true, index: {name: 'idx_distributor_emails_on_email_id'}
      
      t.timestamps
    end
  end
end
