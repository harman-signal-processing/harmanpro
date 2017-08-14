class RenameAdminUsers < ActiveRecord::Migration[5.0]
  def self.up
    rename_table :admin_users, :users
  end

  def self.down
    rename_table :users, :admin_users
  end
end
