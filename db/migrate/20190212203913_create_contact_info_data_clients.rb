class CreateContactInfoDataClients < ActiveRecord::Migration[5.2]
  def change
    create_table :contact_info_data_clients do |t|
      t.string :name

      t.timestamps
    end
    add_index :contact_info_data_clients, :name
  end
end
