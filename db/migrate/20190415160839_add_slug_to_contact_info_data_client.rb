class AddSlugToContactInfoDataClient < ActiveRecord::Migration[5.2]
  def change
    add_column :contact_info_data_clients, :slug, :string, after: :id
    add_index :contact_info_data_clients, :slug, unique: true     
  end
end
