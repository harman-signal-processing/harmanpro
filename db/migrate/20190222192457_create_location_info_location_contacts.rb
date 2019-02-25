class CreateLocationInfoLocationContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :location_info_location_contacts do |t|
      t.references :location_info_location, foreign_key: true, index: {name:'idx_location_contactss_on_location_id'}      
      t.references :contact_info_contact, foreign_key: true, index: {name:'idx_location_contacts_on_contact_id'}
      t.integer :position

      t.timestamps
    end
  end
end
