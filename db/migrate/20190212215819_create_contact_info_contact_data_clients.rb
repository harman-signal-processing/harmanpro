class CreateContactInfoContactDataClients < ActiveRecord::Migration[5.2]
  def change
    create_table :contact_info_contact_data_clients do |t|
      t.integer :position, index: true
      t.references :contact_info_contact, foreign_key: true, index: {name:'idx_contact_data_clients_on_contact_id'}
      t.references :contact_info_data_client, foreign_key: true, index: {name:'idx_contact_data_clients_on_data_client_id'}

      t.timestamps
    end
  end
end
