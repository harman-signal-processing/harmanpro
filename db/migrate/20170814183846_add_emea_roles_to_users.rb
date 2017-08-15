class AddEmeaRolesToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :emea_admin, :boolean, default: false
    add_column :users, :emea_distributor, :boolean, default: false
  end
end
