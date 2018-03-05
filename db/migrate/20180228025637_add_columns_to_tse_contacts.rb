class AddColumnsToTseContacts < ActiveRecord::Migration[5.1]
  def change
    add_column :tse_contacts, :address, :string
    add_column :tse_contacts, :manager, :string
    add_column :tse_contacts, :company, :string
  end
end
