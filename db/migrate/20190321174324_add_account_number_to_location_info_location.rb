class AddAccountNumberToLocationInfoLocation < ActiveRecord::Migration[5.2]
  def change
    add_column :location_info_locations, :account_number, :string
  end
end
