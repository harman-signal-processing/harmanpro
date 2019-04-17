class CreateDistributorInfoDistributorContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :distributor_info_distributor_contacts do |t|
      t.integer :position, index: true
      t.references :distributor_info_distributor, foreign_key: true, index: {name:'idx_distributor_contacts_on_distributor_id'}
      t.references :contact_info_contact, foreign_key: true, index: {name:'idx_distributor_contacts_on_contact_id'}

      t.timestamps
    end
  end
end
